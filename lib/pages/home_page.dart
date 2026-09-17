import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:nhac_lojas/components/container_nhac.dart';
import 'package:nhac_lojas/components/icon_container.dart';
import 'package:nhac_lojas/controllers/scroll_shell_controller.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: ScrollShellController.of(context),
      child: Padding(
        padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 110.h),
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
                      width: 48.r,
                      height: 48.r,
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
                          'Nhac Burguer',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '• Loja aberta',
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
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
                    child: const ContainerNhac(
                      informacao: '34',
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
                    child: const ContainerNhac(
                      informacao: '5',
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
                    child: const ContainerNhac(
                      informacao: '4',
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
                    child: const ContainerNhac(
                      informacao: '25',
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
                    'R\$ 1.284,90',
                    style: TextStyle(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    '↑ +12,5% em relação a ontem',
                    style: TextStyle(
                      color: Colors.green,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 12.h),
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
                            spots: const [
                              FlSpot(0, 1.0),
                              FlSpot(1, 1.2),
                              FlSpot(2, 1.1),
                              FlSpot(3, 1.8),
                              FlSpot(4, 1.5),
                              FlSpot(5, 2.1),
                              FlSpot(6, 1.8),
                              FlSpot(7, 2.0),
                            ],
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
                        '4,8',
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
                            '★★★★★',
                            style: TextStyle(
                              color: Colors.orangeAccent,
                              fontSize: 14.sp,
                            ),
                          ),
                          Text(
                            '127 avaliações',
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
                  ContainerNhac(
                    codigo: 1250,
                    informacao: 'Maria Silva',
                    quantidadeItens: 2,
                    preco: 49.90,
                    horario: '12:30',
                    situacao: 'Em preparo',
                    onTap: () => context.push('/order-details'),
                  ),
                  const Divider(color: Color.fromARGB(50, 158, 158, 158)),
                  ContainerNhac(
                    codigo: 1249,
                    informacao: 'João Pedro',
                    quantidadeItens: 3,
                    preco: 62.50,
                    horario: '12:10',
                    situacao: 'A caminho',
                    onTap: () => context.push('/order-details'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}