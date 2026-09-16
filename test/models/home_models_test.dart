import 'package:flutter_test/flutter_test.dart';
import 'package:nhac_lojas/models/loja.dart';
import 'package:nhac_lojas/models/painel_resumo.dart';
import 'package:nhac_lojas/models/pedido.dart';

/// Valida os contratos que a home consome (branch Edu):
///   GET /api/v1/lojista/painel   → PainelResumoDTO (+ FaturamentoDiaDTO)
///   GET /api/v1/lojas/minha-loja → LojaDetalhesDTO
/// Os payloads são cópias do formato devolvido pelo backend.
void main() {
  group('PedidoResumoLojista', () {
    test('mapeia o resumo de pedido do painel', () {
      final pedido = PedidoResumoLojista.fromJson({
        'id': 'b1f2c3d4-0000-4000-8000-000000000000',
        'clienteNome': 'Maria Silva',
        'quantidadeItens': 2,
        'valorTotal': 49.90,
        'status': 'PREPARANDO',
        'criadoEm': '2026-09-16T15:30:00Z',
      });

      expect(pedido.id, 'b1f2c3d4-0000-4000-8000-000000000000');
      expect(pedido.clienteNome, 'Maria Silva');
      expect(pedido.quantidadeItens, 2);
      expect(pedido.valorTotal, 49.90);
      expect(pedido.status, 'PREPARANDO');
      expect(pedido.situacao, 'Em preparo');
      expect(pedido.criadoEm, isNotNull);
      // Formato 'HH:mm' sem assumir o fuso da máquina de teste.
      expect(pedido.horarioFormatado, matches(RegExp(r'^\d{2}:\d{2}$')));
    });

    test('horarioFormatado fica vazio quando criadoEm não vem', () {
      final pedido = PedidoResumoLojista.fromJson(const {'status': 'PENDENTE'});

      expect(pedido.horarioFormatado, isEmpty);
      expect(pedido.clienteNome, isEmpty);
      expect(pedido.quantidadeItens, 0);
      expect(pedido.valorTotal, 0);
    });
  });

  group('labelStatusPedido', () {
    test('traduz os 6 status do enum StatusPedido do backend', () {
      expect(labelStatusPedido('PENDENTE'), 'Confirmar');
      expect(labelStatusPedido('PAGO'), 'Pago');
      expect(labelStatusPedido('PREPARANDO'), 'Em preparo');
      expect(labelStatusPedido('SAIU_ENTREGA'), 'A caminho');
      expect(labelStatusPedido('ENTREGUE'), 'Entregue');
      expect(labelStatusPedido('CANCELADO'), 'Cancelado');
    });

    test('status desconhecido é repassado sem inventar texto', () {
      expect(labelStatusPedido('EM_TRANSITO'), 'EM_TRANSITO');
    });
  });

  group('PainelResumo', () {
    final payload = <String, dynamic>{
      'lojaAberta': true,
      'faturamentoHoje': 1284.90,
      'pedidosEmPreparo': 5,
      'pedidosACaminho': 4,
      'pedidosConcluidosHoje': 25,
      'faturamentoUltimos7Dias': [
        {'data': '2026-09-10', 'valor': 980.50},
        {'data': '2026-09-11', 'valor': 1120.00},
      ],
      'pedidosRecentes': [
        {
          'id': 'aaaa-bbbb',
          'clienteNome': 'João Pedro',
          'quantidadeItens': 3,
          'valorTotal': 62.50,
          'status': 'SAIU_ENTREGA',
          'criadoEm': '2026-09-16T15:10:00Z',
        },
      ],
    };

    test('mapeia o resumo do painel', () {
      final painel = PainelResumo.fromJson(payload);

      expect(painel.lojaAberta, isTrue);
      expect(painel.faturamentoHoje, 1284.90);
      expect(painel.pedidosEmPreparo, 5);
      expect(painel.pedidosACaminho, 4);
      expect(painel.pedidosConcluidosHoje, 25);
      expect(painel.faturamentoUltimos7Dias, hasLength(2));
      expect(painel.faturamentoUltimos7Dias.first.valor, 980.50);
      expect(painel.faturamentoUltimos7Dias.first.data?.year, 2026);
      expect(painel.pedidosRecentes, hasLength(1));
      expect(painel.pedidosRecentes.first.situacao, 'A caminho');
    });

    test('totalPedidosHoje é a soma dos três grupos de status', () {
      expect(PainelResumo.fromJson(payload).totalPedidosHoje, 34);
    });

    test('payload vazio não quebra a tela', () {
      final painel = PainelResumo.fromJson(const {});

      expect(painel.lojaAberta, isFalse);
      expect(painel.faturamentoHoje, 0);
      expect(painel.totalPedidosHoje, 0);
      expect(painel.faturamentoUltimos7Dias, isEmpty);
      expect(painel.pedidosRecentes, isEmpty);
    });
  });

  group('LojaDetalhes', () {
    final payload = <String, dynamic>{
      'id': 'loja-001',
      'nome': 'Nhac Burguer',
      'descricao': 'Os melhores hambúrgueres artesanais da região',
      'categoria': 'Hamburgueria',
      'imagemUrl': 'https://firebasestorage.example/banner.png',
      'isAberto': true,
      'dadosOperacionais': {
        'avaliacaoMedia': 4.8,
        'taxaEntregaBase': 4.90,
        'tempoEntregaMin': 30,
        'tempoEntregaMax': 45,
        'totalAvaliacoes': 127,
        'entregaPropria': true,
        'retiradaNoLocal': false,
        'raioEntregaKm': 10.5,
      },
    };

    test('mapeia a minha-loja e os dados operacionais usados na home', () {
      final loja = LojaDetalhes.fromJson(payload);

      expect(loja.id, 'loja-001');
      expect(loja.nome, 'Nhac Burguer');
      expect(loja.categoria, 'Hamburgueria');
      expect(loja.isAberto, isTrue);
      expect(loja.avaliacaoMedia, 4.8);
      expect(loja.totalAvaliacoes, 127);
      expect(loja.avaliacaoFormatada, '4,8');
      expect(loja.estrelas, '★★★★★');
    });

    test('estrelas acompanham a média arredondada', () {
      final loja = LojaDetalhes.fromJson({
        'nome': 'Teste',
        'dadosOperacionais': {'avaliacaoMedia': 3.2, 'totalAvaliacoes': 10},
      });

      expect(loja.avaliacaoFormatada, '3,2');
      expect(loja.estrelas, '★★★☆☆');
    });

    test('loja sem dadosOperacionais não quebra (backend manda null)', () {
      final loja = LojaDetalhes.fromJson(const {'nome': 'Recém criada'});

      expect(loja.avaliacaoMedia, 0);
      expect(loja.totalAvaliacoes, 0);
      expect(loja.avaliacaoFormatada, '0,0');
      expect(loja.estrelas, '☆☆☆☆☆');
    });
  });
}