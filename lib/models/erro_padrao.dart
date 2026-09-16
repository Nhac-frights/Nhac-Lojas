/// Espelho do `ErroPadraoDTO` do backend (branch Edu):
/// backend-nhac/src/main/java/br/com/nhac/backend_nhac/exceptions/ErroPadraoDTO.java
///
/// Todo erro da API (NhacException, validação de campos, 500 genérico)
/// chega neste formato, então a UI sempre pode exibir `message`.
class ErroPadrao {
  final String? requestId;
  final DateTime? timestamp;
  final int? status;

  /// Código padronizado do erro. Ex: CREDENCIAIS_INVALIDAS, REGRA_DE_NEGOCIO,
  /// VALIDACAO_FALHOU, ACESSO_NEGADO (ver ErrorCode.java).
  final String? error;
  final String? title;

  /// Mensagem pronta para mostrar ao usuário final.
  final String? message;

  /// Quando `error == VALIDACAO_FALHOU`, vem {campo: "mensagem"}.
  final Map<String, dynamic> details;
  final String? path;
  final List<String> suggestions;

  const ErroPadrao({
    this.requestId,
    this.timestamp,
    this.status,
    this.error,
    this.title,
    this.message,
    this.details = const {},
    this.path,
    this.suggestions = const [],
  });

  factory ErroPadrao.fromJson(Map<String, dynamic> json) {
    return ErroPadrao(
      requestId: json['requestId'] as String?,
      timestamp: DateTime.tryParse(json['timestamp']?.toString() ?? ''),
      status: (json['status'] as num?)?.toInt(),
      error: json['error'] as String?,
      title: json['title'] as String?,
      message: json['message'] as String?,
      details: (json['details'] as Map?)?.map(
            (chave, valor) => MapEntry(chave.toString(), valor),
          ) ??
          const {},
      path: json['path'] as String?,
      suggestions: (json['suggestions'] as List?)
              ?.map((item) => item.toString())
              .toList() ??
          const [],
    );
  }

  /// Nunca fica sem texto para exibir.
  String get mensagemExibicao =>
      message ?? title ?? 'Não foi possível concluir a operação.';

  /// true quando `error == VALIDACAO_FALHOU` (ver ErrorCode.java), ou seja,
  /// `details` traz {campo: mensagem} e a UI pode pintar erro por campo.
  bool get codigoDeValidacao => error == 'VALIDACAO_FALHOU';
}