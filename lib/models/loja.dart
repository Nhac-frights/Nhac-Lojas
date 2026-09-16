/// Espelho (parcial) do `LojaDetalhesDTO` do backend (branch Edu):
/// GET /api/v1/lojas/minha-loja e GET /api/v1/lojas/{id}
///
/// backend-nhac/.../domain/loja/dto/LojaDetalhesDTO.java
///
/// Só os campos já consumidos pelas telas integradas até agora. As partes
/// aninhadas (endereco, horarios, formasPagamento) entram quando a etapa de
/// "Informações da loja" for feita.
class LojaDetalhes {
  final String id;
  final String nome;
  final String descricao;
  final String categoria;
  final String imagemUrl;
  final bool isAberto;

  /// Vem de `dadosOperacionais.avaliacaoMedia` (float do backend).
  final double avaliacaoMedia;

  /// Vem de `dadosOperacionais.totalAvaliacoes`.
  final int totalAvaliacoes;

  const LojaDetalhes({
    required this.id,
    required this.nome,
    required this.descricao,
    required this.categoria,
    required this.imagemUrl,
    required this.isAberto,
    required this.avaliacaoMedia,
    required this.totalAvaliacoes,
  });

  factory LojaDetalhes.fromJson(Map<String, dynamic> json) {
    final dadosOperacionais = json['dadosOperacionais'] is Map
        ? (json['dadosOperacionais'] as Map).cast<String, dynamic>()
        : const <String, dynamic>{};

    return LojaDetalhes(
      id: json['id'] as String? ?? '',
      nome: json['nome'] as String? ?? '',
      descricao: json['descricao'] as String? ?? '',
      categoria: json['categoria'] as String? ?? '',
      imagemUrl: json['imagemUrl'] as String? ?? '',
      isAberto: json['isAberto'] as bool? ?? false,
      avaliacaoMedia:
          (dadosOperacionais['avaliacaoMedia'] as num?)?.toDouble() ?? 0,
      totalAvaliacoes:
          (dadosOperacionais['totalAvaliacoes'] as num?)?.toInt() ?? 0,
    );
  }

  /// Ex: 4.8 → '4,8'.
  String get avaliacaoFormatada =>
      avaliacaoMedia.toStringAsFixed(1).replaceAll('.', ',');

  /// Ex: 4.8 → '★★★★★'; 3.2 → '★★★☆☆'.
  String get estrelas {
    final cheias = avaliacaoMedia.round().clamp(0, 5);
    return '★' * cheias + '☆' * (5 - cheias);
  }
}