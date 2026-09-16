import 'package:nhac_lojas/models/pedido.dart';

/// Espelho do `FaturamentoDiaDTO` do backend:
/// backend-nhac/.../domain/painel/dto/FaturamentoDiaDTO.java
class FaturamentoDia {
  /// `data` vem como LocalDate no formato "AAAA-MM-DD".
  final DateTime? data;
  final double valor;

  const FaturamentoDia({required this.data, required this.valor});

  factory FaturamentoDia.fromJson(Map<String, dynamic> json) {
    return FaturamentoDia(
      data: DateTime.tryParse(json['data']?.toString() ?? ''),
      valor: (json['valor'] as num?)?.toDouble() ?? 0,
    );
  }
}

/// Espelho do `PainelResumoDTO` do backend (branch Edu):
/// GET /api/v1/lojista/painel
///
/// backend-nhac/.../domain/painel/dto/PainelResumoDTO.java
class PainelResumo {
  final bool lojaAberta;
  final double faturamentoHoje;
  final int pedidosEmPreparo;
  final int pedidosACaminho;
  final int pedidosConcluidosHoje;
  final List<FaturamentoDia> faturamentoUltimos7Dias;
  final List<PedidoResumoLojista> pedidosRecentes;

  const PainelResumo({
    required this.lojaAberta,
    required this.faturamentoHoje,
    required this.pedidosEmPreparo,
    required this.pedidosACaminho,
    required this.pedidosConcluidosHoje,
    required this.faturamentoUltimos7Dias,
    required this.pedidosRecentes,
  });

  factory PainelResumo.fromJson(Map<String, dynamic> json) {
    return PainelResumo(
      lojaAberta: json['lojaAberta'] as bool? ?? false,
      faturamentoHoje: (json['faturamentoHoje'] as num?)?.toDouble() ?? 0,
      pedidosEmPreparo: (json['pedidosEmPreparo'] as num?)?.toInt() ?? 0,
      pedidosACaminho: (json['pedidosACaminho'] as num?)?.toInt() ?? 0,
      pedidosConcluidosHoje:
          (json['pedidosConcluidosHoje'] as num?)?.toInt() ?? 0,
      faturamentoUltimos7Dias: (json['faturamentoUltimos7Dias'] as List?)
              ?.whereType<Map>()
              .map((item) => FaturamentoDia.fromJson(item.cast<String, dynamic>()))
              .toList() ??
          const [],
      pedidosRecentes: (json['pedidosRecentes'] as List?)
              ?.whereType<Map>()
              .map((item) =>
                  PedidoResumoLojista.fromJson(item.cast<String, dynamic>()))
              .toList() ??
          const [],
    );
  }

  /// O backend não devolve um total de pedidos do dia: soma os três grupos de
  /// status que ele informa. É o mesmo número que a home mockada mostrava
  /// (5 em preparo + 4 a caminho + 25 concluídos = 34).
  int get totalPedidosHoje =>
      pedidosEmPreparo + pedidosACaminho + pedidosConcluidosHoje;
}