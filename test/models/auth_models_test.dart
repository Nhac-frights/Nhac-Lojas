import 'package:flutter_test/flutter_test.dart';
import 'package:nhac_lojas/models/erro_padrao.dart';
import 'package:nhac_lojas/models/login_resposta.dart';

/// Valida o mapeamento dos contratos do backend (branch Edu) usados pelo
/// login. Os payloads abaixo são cópias literais do formato devolvido por:
///   - POST /api/v1/auth/login            → LoginResponseDTO
///   - qualquer erro da API               → ErroPadraoDTO
void main() {
  group('LoginResposta', () {
    test('mapeia o payload de sucesso do POST /api/v1/auth/login', () {
      final resposta = LoginResposta.fromJson({
        'token': 'eyJhbGciOiJIUzI1NiJ9.abc',
        'usuarioId': '3f1c2f6e-0000-4000-8000-000000000000',
        'nome': 'Carlos Andrade',
        'isNovoUsuario': false,
        'papel': 'LOJISTA',
      });

      expect(resposta.token, 'eyJhbGciOiJIUzI1NiJ9.abc');
      expect(resposta.usuarioId, '3f1c2f6e-0000-4000-8000-000000000000');
      expect(resposta.nome, 'Carlos Andrade');
      expect(resposta.isNovoUsuario, isFalse);
      expect(resposta.papel, 'LOJISTA');
    });

    test('usa valores neutros quando o payload vem incompleto', () {
      final resposta = LoginResposta.fromJson(const {});

      expect(resposta.token, isEmpty);
      expect(resposta.usuarioId, isEmpty);
      expect(resposta.nome, isEmpty);
      expect(resposta.isNovoUsuario, isFalse);
      expect(resposta.papel, isEmpty);
    });
  });

  group('ErroPadrao', () {
    test('mapeia o 401 CREDENCIAIS_INVALIDAS do login', () {
      final erro = ErroPadrao.fromJson({
        'requestId': '9c9d0ab1-1111-2222-3333-444444444444',
        'timestamp': '2026-09-16T12:00:00Z',
        'status': 401,
        'error': 'CREDENCIAIS_INVALIDAS',
        'title': 'Não Autorizado',
        'message': 'E-mail não encontrado ou senha inválida.',
        'details': <String, dynamic>{},
        'path': '/api/v1/auth/login',
        'suggestions': <dynamic>[],
      });

      expect(erro.status, 401);
      expect(erro.error, 'CREDENCIAIS_INVALIDAS');
      expect(erro.title, 'Não Autorizado');
      expect(erro.message, 'E-mail não encontrado ou senha inválida.');
      expect(erro.mensagemExibicao, 'E-mail não encontrado ou senha inválida.');
      expect(erro.path, '/api/v1/auth/login');
      expect(erro.timestamp, isNotNull);
      expect(erro.details, isEmpty);
      expect(erro.suggestions, isEmpty);
    });

    test('preserva os details por campo do 400 VALIDACAO_FALHOU', () {
      final erro = ErroPadrao.fromJson({
        'requestId': 'aaaa-bbbb',
        'timestamp': '2026-09-16T12:00:00Z',
        'status': 400,
        'error': 'VALIDACAO_FALHOU',
        'title': 'Erro de Validação de Dados',
        'message': 'Alguns campos enviados são inválidos. Verifique os detalhes.',
        'details': {
          'email': 'must not be blank',
          'senha': 'must not be blank',
        },
        'path': '/api/v1/auth/login',
        'suggestions': ['Verifique os campos informados e tente novamente.'],
      });

      expect(erro.codigoDeValidacao, isTrue);
      expect(erro.details['email'], 'must not be blank');
      expect(erro.details['senha'], 'must not be blank');
      expect(erro.suggestions, hasLength(1));
    });

    test('mensagemExibicao cai para title e depois para texto padrão', () {
      expect(
        ErroPadrao.fromJson(const {'title': 'Acesso Negado'}).mensagemExibicao,
        'Acesso Negado',
      );
      expect(
        ErroPadrao.fromJson(const {}).mensagemExibicao,
        'Não foi possível concluir a operação.',
      );
    });
  });
}