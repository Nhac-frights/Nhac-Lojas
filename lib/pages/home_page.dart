import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:nhac_lojas/components/button_nhac.dart';
import 'package:nhac_lojas/components/container_nhac.dart';
import 'package:nhac_lojas/components/icon_container.dart';
import 'package:nhac_lojas/controllers/scroll_shell_controller.dart';
import 'package:nhac_lojas/models/loja.dart';
import 'package:nhac_lojas/models/painel_resumo.dart';
import 'package:nhac_lojas/services/api_service.dart';

/// Junta as duas chamadas que a home precisa.
class _DadosHome {
  final PainelResumo painel;
  final LojaDetalhes loja;

  const _DadosHome({required this.painel, required this.loja});
}

/// Formata como o resto do app: 'R$ 1284,90'.
String _moeda(double valor) =>
    'R\$ ${valor.toStringAsFixed(2).replaceAll('.', ',')}';

/// Estado de erro da home: mensagem do backend + tentar de novo.
class _ErroHome extends StatelessWidget {
  final String mensagem;
  final VoidCallback onTentarNovamente;

  const _ErroHome({required this.mensagem, required this.onTentarNovamente});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(24.r),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.cloud_off_rounded, size: 48.sp, color: Colors.redAccent),
            SizedBox(height: 12.h),
            Text(
              mensagem,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14.sp, color: Colors.grey[700]),
            ),
            SizedBox(height: 20.h),
            ButtonNhac(texto: 'Tentar de novo', onTap: onTentarNovamente),
          ],
        ),
      ),
    );
  }
}

/// Home do painel. Dados reais de:
///   GET /api/v1/lojista/painel   → contadores, faturamento, 7 dias, recentes
///   GET /api/v1/lojas/minha-loja → nome e status de abertura da loja
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<_DadosHome> _futuro;

  @override
  void initState() {
    super.initState();
    _futuro = _carregar();
  }

  Future<_DadosHome> _carregar() async {
    final painel = await ApiService.instance.obterPainel();
    final loja = await ApiService.instance.obterMinhaLoja();
    return _DadosHome(painel: painel, loja: loja);
  }

  void _recarregar() {
    setState(() => _futuro = _carregar());
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<_DadosHome>(
      future: _futuro,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(color: Colors.redAccent),
          );
        }
        if (snapshot.data == null) {
          final erro = snapshot.error;
          return _ErroHome(
            mensagem: erro is ApiException
                ? erro.mensagem
                : 'Não foi possível carregar o painel.',
            onTentarNovamente: _recarregar,
          );
        }
        return _conteudo(snapshot.data!);
      },
    );
  }

  /// Corpo da tela: mesma estrutura visual de antes, com dados do backend.
  Widget _conteudo(_DadosHome dados) {
    final painel = dados.painel;
    final loja = dados.loja;

    // Série do gráfico: um ponto por dia devolvido em faturamentoUltimos7Dias.
    final spotsFaturamento = <FlSpot>[
      for (var i = 0; i < painel.faturamentoUltimos7Dias.length; i++)
        FlSpot(i.toDouble(), painel.faturamentoUltimos7Dias[i].valor),
    ];
    return SingleChildScrollView(
      controller: ScrollShellController.of(context),
      child: Padding(
        padding: EdgeInsets.fromLTRB(20.w, 46.h, 20.w, 110.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 48.w,
                      height: 48.w,
                      padding: EdgeInsets.all(8.r),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 255, 242, 230),
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: Image.asset(
                        'assets/images/nhac-logo.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          loja.nome,
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          painel.lojaAberta
                              ? '• Loja aberta'
                              : '• Loja fechada',
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.bold,
                            color:
                                painel.lojaAberta ? Colors.green : Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                IconContainer(
                  icon: Icons.notifications_none_rounded,
                ),
              ],
            ),
            SizedBox(height: 24.h),
            Padding(
              padding: EdgeInsets.all(8.0.r),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'RESUMO DE HOJE',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Ver mais >',
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.redAccent,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 4.h),
            Row(
              children: [
                Expanded(
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(16.r),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: ContainerNhac(
                      informacao: '${painel.totalPedidosHoje}',
                      fontSize: 20,
                      complemento: 'Pedidos',
                    ),
                  ),
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(16.r),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: ContainerNhac(
                      informacao: '${painel.pedidosEmPreparo}',
                      fontSize: 20,
                      complemento: 'Em preparo',
                      corTitulo: Colors.orange,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.h),
            Row(
              children: [
                Expanded(
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(16.r),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: ContainerNhac(
                      informacao: '${painel.pedidosACaminho}',
                      fontSize: 20,
                      complemento: 'A caminho',
                      corTitulo: Colors.redAccent,
                    ),
                  ),
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(16.r),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: ContainerNhac(
                      informacao: '${painel.pedidosConcluidosHoje}',
                      fontSize: 20,
                      complemento: 'Concluídos',
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(20.r),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'FATURAMENTO',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    _moeda(painel.faturamentoHoje),
                    style: TextStyle(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 12.h),
                  // Só desenha o gráfico se o backend devolveu a série.
                  if (spotsFaturamento.length >= 2)
                    SizedBox(
                      height: 60.h,
                      child: LineChart(
                        LineChartData(
                          gridData: FlGridData(show: false),
                          titlesData: FlTitlesData(show: false),
                          borderData: FlBorderData(show: false),
                          lineTouchData: LineTouchData(enabled: false),
                          lineBarsData: [
                            LineChartBarData(
                              spots: spotsFaturamento,
                              isCurved: false,
                              color: Colors.redAccent,
                              barWidth: 2.5,
                              isStrokeCapRound: true,
                              dotData: FlDotData(show: false),
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
            SizedBox(height: 16.h),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.r),
              ),
              width: double.infinity,
              padding: EdgeInsets.all(20.r),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'AVALIAÇÃO DA LOJA',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Row(
                    children: [
                      Text(
                        loja.avaliacaoFormatada,
                        style: TextStyle(
                          fontSize: 24.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            loja.estrelas,
                            style: TextStyle(
                              color: Colors.orangeAccent,
                              fontSize: 14.sp,
                            ),
                          ),
                          Text(
                            '${loja.totalAvaliacoes} avaliações',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.h),
            Padding(
              padding: EdgeInsets.all(8.0.r),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'ÚLTIMOS PEDIDOS',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Ver todos >',
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.redAccent,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16.r),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Column(
                children: [
                  if (painel.pedidosRecentes.isEmpty)
                    Text(
                      'Nenhum pedido por aqui ainda.',
                      style: TextStyle(color: Colors.grey, fontSize: 12.sp),
                    ),
                  if (painel.pedidosRecentes.isNotEmpty)
                    for (final (indice, pedido)
                        in painel.pedidosRecentes.indexed) ...[
                      if (indice > 0)
                        const Divider(color: Color.fromARGB(50, 158, 158, 158)),
                      ContainerNhac(
                        informacao: pedido.clienteNome,
                        quantidadeItens: pedido.quantidadeItens,
                        preco: pedido.valorTotal,
                        horario: pedido.horarioFormatado,
                        situacao: pedido.situacao,
                        onTap: () => context.push('/order-details'),
                      ),
                    ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}