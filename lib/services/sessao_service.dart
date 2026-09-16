import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:nhac_lojas/models/login_resposta.dart';

/// Guarda o token JWT (30 dias, ver TokenService.java do backend) e os dados
/// básicos do usuário logado, persistindo no armazenamento seguro do sistema.
///
/// É um `ChangeNotifier` de propósito: o `go_router` usa esta instância como
/// `refreshListenable`, então quando a sessão é criada ou encerrada (inclusive
/// por 401 do backend) o redirect é reavaliado e o app volta sozinho para o
/// login. Singleton simples — o app ainda não tem gerenciamento de estado.
class SessaoService extends ChangeNotifier {
  SessaoService._();

  static final SessaoService instance = SessaoService._();

  /// Papéis que podem entrar no painel da loja. O backend libera
  /// `/api/v1/lojista/**` para qualquer usuário autenticado, mas o painel só
  /// faz sentido para dono/funcionário/admin.
  static const Set<String> papeisComAcessoAoPainel = {
    'LOJISTA',
    'FUNCIONARIO',
    'ADMIN',
  };

  static const String _chaveToken = 'nhac_token';
  static const String _chaveUsuarioId = 'nhac_usuario_id';
  static const String _chaveNome = 'nhac_nome';
  static const String _chavePapel = 'nhac_papel';

  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  String? _token;
  String? _usuarioId;
  String? _nome;
  String? _papel;

  String? get token => _token;
  String? get usuarioId => _usuarioId;
  String? get nome => _nome;

  /// CLIENTE | LOJISTA | FUNCIONARIO | ENTREGADOR | ADMIN
  String? get papel => _papel;

  bool get estaLogado => _token != null && _token!.isNotEmpty;

  /// true quando o papel logado pode acessar o painel da loja.
  bool get podeAcessarPainel =>
      _papel != null && papeisComAcessoAoPainel.contains(_papel);

  /// Chamado no main() antes do runApp, para o interceptor do ApiService já
  /// ter o token em memória no primeiro request (sem await dentro do request).
  Future<void> carregar() async {
    _token = await _storage.read(key: _chaveToken);
    _usuarioId = await _storage.read(key: _chaveUsuarioId);
    _nome = await _storage.read(key: _chaveNome);
    _papel = await _storage.read(key: _chavePapel);
    if (_token != null && !podeAcessarPainel) {
      // Sessão guardada de um papel sem acesso ao painel (ex.: CLIENTE).
      await sair();
      return;
    }
    notifyListeners();
  }

  /// Salva a sessão devolvida pelo POST /api/v1/auth/login.
  Future<void> salvar(LoginResposta resposta) async {
    _token = resposta.token;
    _usuarioId = resposta.usuarioId;
    _nome = resposta.nome;
    _papel = resposta.papel;
    notifyListeners();

    await _storage.write(key: _chaveToken, value: resposta.token);
    await _storage.write(key: _chaveUsuarioId, value: resposta.usuarioId);
    await _storage.write(key: _chaveNome, value: resposta.nome);
    await _storage.write(key: _chavePapel, value: resposta.papel);
  }

  /// O backend não tem endpoint de logout (o JWT só expira em 30 dias),
  /// então sair da conta é 100% local.
  Future<void> sair() async {
    _token = null;
    _usuarioId = null;
    _nome = null;
    _papel = null;
    notifyListeners();

    await _storage.delete(key: _chaveToken);
    await _storage.delete(key: _chaveUsuarioId);
    await _storage.delete(key: _chaveNome);
    await _storage.delete(key: _chavePapel);
  }
}