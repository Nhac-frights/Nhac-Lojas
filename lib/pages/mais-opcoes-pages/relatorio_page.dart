import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nhac_lojas/components/back_arrow.dart';
import 'package:nhac_lojas/components/container_nhac.dart';
import 'package:nhac_lojas/components/filter_tag.dart';

class RelatorioPage extends StatelessWidget {
  const RelatorioPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 24.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              Row(
                children: [
                  const BackArrow(),
                  SizedBox(width: 12.w),
                  Text(
                    'Relatórios',
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Spacer(),
                  ListaFilterTags(
                    filtros: ['Hoje'],
                    icones: [Icons.keyboard_arrow_down_rounded],
                    iconColor: Colors.black,
                  ),
                ],
              ),
              SizedBox(height: 24.h),
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
                        preco: 540.90.sp,
                        fontSizePreco: 18.sp,
                        complemento: 'Faturamento',
                        fontWeightComplemento: FontWeight.bold,
                        layoutVertical: true,
                      ),
                    ),
                  ),
                  SizedBox(width: 8.w,),
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(16.r),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: ContainerNhac(
                        informacao: '12',
                        fontSize: 18.sp,
                        complemento: 'Pedidos',
                        fontWeightComplemento: FontWeight.bold,
                        layoutVertical: true,
                      ),
                    ),
                  ),
                  SizedBox(width: 8.w,),
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(16.r),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: ContainerNhac(
                        preco: 45.08.sp,
                        fontSizePreco: 18.sp,
                        complemento: 'Ticket médio',
                        fontWeightComplemento: FontWeight.bold,
                        layoutVertical: true,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.h,),
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
              SizedBox(height: 16.h,),
              Text(
                'MAIS VENDIDOS',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8.h,),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(16.r),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: ContainerNhac(
                  icon: Icons.lunch_dining_rounded,
                  informacao: 'X-Burguer',
                  complemento: '24 vendas',
                ),
              ),
              SizedBox(height: 8.h,),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(16.r),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: ContainerNhac(
                  icon: Icons.local_drink_rounded,
                  informacao: 'Coca-Cola 350ml',
                  complemento: '17 vendas',
                ),
              ),
              SizedBox(height: 8.h,),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(16.r),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: ContainerNhac(
                  icon: Icons.free_breakfast,
                  informacao: 'Café',
                  complemento: '9 vendas',
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
  }
}