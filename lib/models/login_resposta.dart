/// Espelho do `LoginResponseDTO` do backend (branch Edu):
/// POST /api/v1/auth/login → 200
///
/// backend-nhac/src/main/java/br/com/nhac/backend_nhac/domain/auth/dto/LoginResponseDTO.java
class LoginResposta {
  /// JWT HS256, issuer "nhac-api", expira em 30 dias (TokenService.java).
  /// Vai como `Authorization: Bearer <token>` nas próximas chamadas.
  final String token;
  final String usuarioId;
  final String nome;

  /// true apenas quando a conta acabou de ser criada (login social/SMS).
  final bool isNovoUsuario;

  /// CLIENTE | LOJISTA | FUNCIONARIO | ENTREGADOR | ADMIN
  final String papel;

  const LoginResposta({
    required this.token,
    required this.usuarioId,
    required this.nome,
    required this.isNovoUsuario,
    required this.papel,
  });

  factory LoginResposta.fromJson(Map<String, dynamic> json) {
    return LoginResposta(
      token: json['token'] as String? ?? '',
      usuarioId: json['usuarioId'] as String? ?? '',
      nome: json['nome'] as String? ?? '',
      isNovoUsuario: json['isNovoUsuario'] as bool? ?? false,
      papel: json['papel'] as String? ?? '',
    );
  }
}