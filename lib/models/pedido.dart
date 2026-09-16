/// Espelho do `PedidoResumoLojistaDTO` do backend (branch Edu):
/// GET /api/v1/lojista/pedidos e GET /api/v1/lojista/painel (pedidosRecentes).
///
/// backend-nhac/src/main/java/br/com/nhac/backend_nhac/domain/pedido/dto/PedidoResumoLojistaDTO.java
class PedidoResumoLojista {
  /// UUID do pedido (String). O backend NÃO tem número sequencial de pedido.
  final String id;
  final String clienteNome;
  final int quantidadeItens;
  final double valorTotal;

  /// Valor cru do enum `StatusPedido` do backend: PENDENTE, PAGO, PREPARANDO,
  /// SAIU_ENTREGA, ENTREGUE ou CANCELADO.
  final String status;

  /// `criadoEm` vem como Instant (UTC); convertido para o fuso local.
  final DateTime? criadoEm;

  const PedidoResumoLojista({
    required this.id,
    required this.clienteNome,
    required this.quantidadeItens,
    required this.valorTotal,
    required this.status,
    this.criadoEm,
  });

  factory PedidoResumoLojista.fromJson(Map<String, dynamic> json) {
    final criadoEmBruto = json['criadoEm']?.toString();

    return PedidoResumoLojista(
      id: json['id'] as String? ?? '',
      clienteNome: json['clienteNome'] as String? ?? '',
      quantidadeItens: (json['quantidadeItens'] as num?)?.toInt() ?? 0,
      valorTotal: (json['valorTotal'] as num?)?.toDouble() ?? 0,
      status: json['status'] as String? ?? '',
      criadoEm: criadoEmBruto == null
          ? null
          : DateTime.tryParse(criadoEmBruto)?.toLocal(),
    );
  }

  /// Texto da tag de situação, no vocabulário que o ContainerNhac já colore.
  String get situacao => labelStatusPedido(status);

  /// Hora local no formato 'HH:mm' (o card do pedido mostra só a hora).
  String get horarioFormatado {
    final data = criadoEm;
    if (data == null) return '';
    final hora = data.hour.toString().padLeft(2, '0');
    final minuto = data.minute.toString().padLeft(2, '0');
    return '$hora:$minuto';
  }
}

/// Traduz o enum `StatusPedido` do backend para o texto usado na UI.
///
/// Os textos 'Em preparo', 'A caminho', 'Entregue' e 'Confirmar' são os mesmos
/// que o `ContainerNhac` já reconhece para colorir a tag de situação.
/// PENDENTE → 'Confirmar' porque é o pedido que ainda aguarda o aceite da loja.
String labelStatusPedido(String status) {
  switch (status) {
    case 'PENDENTE':
      return 'Confirmar';
    case 'PAGO':
      return 'Pago';
    case 'PREPARANDO':
      return 'Em preparo';
    case 'SAIU_ENTREGA':
      return 'A caminho';
    case 'ENTREGUE':
      return 'Entregue';
    case 'CANCELADO':
      return 'Cancelado';
    default:
      return status;
  }
}