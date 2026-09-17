import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nhac_lojas/components/back_arrow.dart';
import 'package:nhac_lojas/components/button_nhac.dart';
import 'package:nhac_lojas/components/container_nhac.dart';

class FinanceiroPage extends StatelessWidget {
  const FinanceiroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
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
                    'Financeiro',
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24.h),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(16.r),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 93, 32, 28),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Column(
                  children: [
                    ContainerNhac(
                      informacao: 'Saldo disponível',
                      corTitulo: Color.fromARGB(255, 255, 231, 229),
                      fontSize: 14,
                      widget: ButtonNhac(
                        texto: 'Sacar',
                        onTap: () {},
                      ),
                      complemento: 'R\$ 1.248,90',
                      fontSizeComplemento: 26,
                      fontWeightComplemento: FontWeight.bold,
                      corComplemento: Colors.white,
                      proximoRepasse: '16/10/2026',
                      corRepasse: Color.fromARGB(255, 255, 231, 229),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16.h,),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(16.r),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: Column(
                        children: [
                          ContainerNhac(
                            informacao: 'Extrato',
                            icon: Icons.receipt_long_outlined,
                            layoutVertical: true,
                          ),
                        ],
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
                      child: Column(
                        children: [
                          ContainerNhac(
                            informacao: 'Repasses',
                            icon: Icons.money_outlined,
                            layoutVertical: true,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12.h,),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(16.r),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: Column(
                        children: [
                          ContainerNhac(
                            informacao: 'Taxas',
                            icon: Icons.bar_chart_rounded,
                            layoutVertical: true,
                          ),
                        ],
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
                      child: Column(
                        children: [
                          ContainerNhac(
                            informacao: 'Pagamento',
                            icon: Icons.credit_card_outlined,
                            layoutVertical: true,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.h),
              Text(
                'RESUMO DE HOJE',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8.h,),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(20.r),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 8.h,
                        horizontal: 4.w,
                      ),
                      child: ContainerNhac(
                        informacao: 'Faturamento',
                        preco: 1284.90,
                        corPreco: Colors.green,
                        complemento: ' (+12,5%)',
                        corComplemento: Colors.green,
                        fontSizeComplemento: 14,
                        fontWeightComplemento: FontWeight.bold,
                        complementoAoLadoPreco: true,
                      ),
                    ),
                    Divider(),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 8.h,
                        horizontal: 4.w,
                      ),
                      child: ContainerNhac(
                        informacao: 'Pedidos',
                        complemento: '34',
                        fontSizeComplemento: 14,
                        corComplemento: Color.fromARGB(255, 93, 32, 28),
                        fontWeightComplemento: FontWeight.bold,
                        complementoAoLadoPreco: true,
                      ),
                    ),
                    Divider(),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 8.h,
                        horizontal: 4.w,
                      ),
                      child: ContainerNhac(
                        informacao: 'Ticket médio',
                        preco: 37.79,
                      ),
                    ),
                  ],
                )
              ),
              SizedBox(height: 16.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'ÚLTIMOS REPASSES',
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
              SizedBox(height: 8.h,),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(20.r),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Column(
                  children: [
                    ContainerNhac(
                      informacao: '07/09/2026',
                      complemento: 'Repasse realizado',
                      preco: 856.40,
                      corPreco: Colors.green,
                    ),
                    Divider(),
                    ContainerNhac(
                      informacao: '01/09/2026',
                      complemento: 'Repasse realizado',
                      preco: 624.97,
                      corPreco: Colors.green,
                    ),
                  ],
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