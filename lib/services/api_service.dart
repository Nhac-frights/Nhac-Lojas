import 'package:dio/dio.dart';
import 'package:nhac_lojas/models/erro_padrao.dart';
import 'package:nhac_lojas/models/login_resposta.dart';
import 'package:nhac_lojas/models/loja.dart';
import 'package:nhac_lojas/models/painel_resumo.dart';
import 'package:nhac_lojas/services/sessao_service.dart';

/// Erro já normalizado a partir do `ErroPadraoDTO` do backend.
/// Use `mensagem` para exibir ao usuário e `codigo`/`status` para decidir fluxo.
class ApiException implements Exception {
  final String mensagem;

  /// Código HTTP (401, 400, 404...).
  final int? status;

  /// Código padronizado do backend: CREDENCIAIS_INVALIDAS, REGRA_DE_NEGOCIO,
  /// VALIDACAO_FALHOU, ACESSO_NEGADO, etc. (ver ErrorCode.java).
  final String? codigo;

  /// Preenchido quando o backend devolve erro de validação ({campo: mensagem}).
  final Map<String, dynamic> details;

  /// true quando a requisição levou o token e o backend respondeu 401 —
  /// ou seja, o token expirou/invalidou e a sessão local já foi encerrada.
  final bool sessaoExpirada;

  const ApiException({
    required this.mensagem,
    this.status,
    this.codigo,
    this.details = const {},
    this.sessaoExpirada = false,
  });

  @override
  String toString() => mensagem;
}

/// Camada HTTP única do app (dio + flutter_secure_storage).
///
/// Centraliza a baseUrl, o timeout, o header `Authorization: Bearer <token>`
/// e a tradução de qualquer erro para [ApiException].
class ApiService {
  ApiService._();

  static final ApiService instance = ApiService._();

  /// ⚠️ Ajuste conforme onde o backend estiver rodando:
  /// - Android emulador  → http://10.0.2.2:8080/api/v1
  /// - Aparelho físico   → http://SEU_IP_LOCAL:8080/api/v1
  /// - iOS simulador/web → http://localhost:8080/api/v1
  static const String baseUrl = 'http://10.0.2.2:8080/api/v1';

  static const Duration _timeout = Duration(seconds: 15);

  late final Dio dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: _timeout,
      receiveTimeout: _timeout,
      sendTimeout: _timeout,
      contentType: Headers.jsonContentType,
      responseType: ResponseType.json,
    ),
  )..interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          final token = SessaoService.instance.token;
          if (token != null && token.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          handler.next(options);
        },
        onError: (erro, handler) async {
          // 401 numa requisição que levou o token = token expirado/inválido.
          // Encerra a sessão local; como o go_router usa o SessaoService como
          // refreshListenable, o redirect manda o app de volta para /login.
          // O login em si não tem header Authorization, então um 401 de senha
          // errada NÃO derruba sessão nenhuma.
          final levouToken =
              erro.requestOptions.headers.containsKey('Authorization');
          if (erro.response?.statusCode == 401 && levouToken) {
            erro.requestOptions.extra['sessaoExpirada'] = true;
            await SessaoService.instance.sair();
          }
          handler.next(erro);
        },
      ),
    );

  /// POST /api/v1/auth/login — rota pública.
  ///
  /// 200 → LoginResponseDTO
  /// 401 CREDENCIAIS_INVALIDAS → e-mail não encontrado ou senha inválida
  /// 400 REGRA_DE_NEGOCIO     → e-mail não verificado / conta desativada
  /// 400 VALIDACAO_FALHOU     → e-mail ou senha vazios/malformados
  Future<LoginResposta> login({
    required String email,
    required String senha,
  }) async {
    try {
      final resposta = await dio.post<Map<String, dynamic>>(
        '/auth/login',
        data: {'email': email, 'senha': senha},
      );
      return LoginResposta.fromJson(resposta.data ?? const <String, dynamic>{});
    } on DioException catch (erro) {
      throw _traduzirErro(erro);
    }
  }

  /// GET /api/v1/lojista/painel — resumo agregado da home.
  ///
  /// Devolve `PainelResumoDTO` (faturamento de hoje, contagem por grupo de
  /// status, faturamento dos últimos 7 dias e os 5 pedidos mais recentes).
  /// Requer token; 401 → sessão expirada.
  Future<PainelResumo> obterPainel() async {
    final dados = await _getMap('/lojista/painel');
    return PainelResumo.fromJson(dados);
  }

  /// GET /api/v1/lojas/minha-loja — loja vinculada ao token.
  /// 404 quando o usuário autenticado ainda não tem loja.
  Future<LojaDetalhes> obterMinhaLoja() async {
    final dados = await _getMap('/lojas/minha-loja');
    return LojaDetalhes.fromJson(dados);
  }

  /// GET que devolve um objeto JSON, já traduzindo qualquer falha.
  Future<Map<String, dynamic>> _getMap(String caminho) async {
    try {
      final resposta = await dio.get<Map<String, dynamic>>(caminho);
      return resposta.data ?? const <String, dynamic>{};
    } on DioException catch (erro) {
      throw _traduzirErro(erro);
    }
  }

  /// Converte qualquer falha do dio no formato de erro do backend.
  ApiException _traduzirErro(DioException erro) {
    final resposta = erro.response;
    final sessaoExpirada = erro.requestOptions.extra['sessaoExpirada'] == true;

    if (resposta != null) {
      final dados = resposta.data;
      if (dados is Map) {
        final erroPadrao = ErroPadrao.fromJson(dados.cast<String, dynamic>());
        return ApiException(
          status: resposta.statusCode ?? erroPadrao.status,
          codigo: erroPadrao.error,
          mensagem: erroPadrao.mensagemExibicao,
          details: erroPadrao.details,
          sessaoExpirada: sessaoExpirada,
        );
      }
      return ApiException(
        status: resposta.statusCode,
        mensagem: 'Erro ${resposta.statusCode} ao falar com o servidor.',
        sessaoExpirada: sessaoExpirada,
      );
    }

    switch (erro.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return const ApiException(
          mensagem: 'Tempo de conexão esgotado. Tente novamente.',
        );
      case DioExceptionType.connectionError:
        return const ApiException(
          mensagem:
              'Não foi possível conectar ao servidor. Verifique sua conexão.',
        );
      case DioExceptionType.cancel:
        return const ApiException(mensagem: 'Requisição cancelada.');
      default:
        return ApiException(
          mensagem: erro.message ?? 'Falha inesperada na requisição.',
        );
    }
  }
}