import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:nhac_lojas/components/back_arrow.dart';
import 'package:nhac_lojas/components/button_nhac.dart';
import 'package:nhac_lojas/components/container_nhac.dart';
import 'package:nhac_lojas/components/icon_container.dart';

class OrderDetailsPage extends StatelessWidget {
  const OrderDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(20.w, 26.h, 20.w, 30.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const BackArrow(),
                  SizedBox(width: 12.w),
                  Text(
                    'Pedido #1250',
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  IconContainer(
                    icon: Icons.print_rounded,
                  ),
                ],
              ),
              SizedBox(height: 24.h),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          vertical: 4.h,
                          horizontal: 10.w,
                        ),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(50, 33, 149, 243),
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Text(
                          'Em preparo',
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: 12.h),
                      Text(
                        'INFORMAÇÕES DO CLIENTE',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 12.h),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(16.r),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        child: Column(
                          children: [
                            const ContainerNhac(
                              icon: Icons.person,
                              informacao: 'Maria Silva',
                            ),
                            SizedBox(height: 8.h),
                            const Divider(color: Color.fromARGB(50, 158, 158, 158)),
                            SizedBox(height: 8.h),
                            const ContainerNhac(
                              icon: Icons.call,
                              informacao: '(11) 98765-4321',
                            ),
                            SizedBox(height: 8.h),
                            const Divider(color: Color.fromARGB(50, 158, 158, 158)),
                            SizedBox(height: 8.h),
                            const ContainerNhac(
                              icon: Icons.location_on_outlined,
                              informacao: 'Rua das Flores, 123',
                              complemento: 'Apt 45 - Centro',
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 16.h),
                      Text(
                        'ITENS DO PEDIDO',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 12.h),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(16.r),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        child: Column(
                          children: [
                            const ContainerNhac(
                              informacao: 'X-Burguer',
                              quantidadeItens: 1,
                              complemento: 'Sem cebola',
                              preco: 28.90,
                              precoEmDestaque: true,
                            ),
                            SizedBox(height: 8.h),
                            const Divider(color: Color.fromARGB(50, 158, 158, 158)),
                            SizedBox(height: 8.h),
                            const ContainerNhac(
                              informacao: 'Batata Frita Média',
                              quantidadeItens: 1,
                              preco: 12.00,
                              precoEmDestaque: true,
                            ),
                            SizedBox(height: 8.h),
                            const Divider(color: Color.fromARGB(50, 158, 158, 158)),
                            SizedBox(height: 8.h),
                            const ContainerNhac(
                              informacao: 'Coca-Cola 350ml',
                              quantidadeItens: 1,
                              preco: 5.00,
                              precoEmDestaque: true,
                            ),
                            SizedBox(height: 8.h),
                            const Divider(color: Color.fromARGB(50, 158, 158, 158)),
                            SizedBox(height: 6.h),
                            const ContainerNhac(
                              complemento: 'Taxa de entrega',
                              preco: 4.90,
                              precoEmDestaque: true,
                            ),
                            SizedBox(height: 6.h),
                            const Divider(color: Color.fromARGB(50, 158, 158, 158)),
                            SizedBox(height: 6.h),
                            const ContainerNhac(
                              complemento: 'Total',
                              fontSizeComplemento: 14,
                              preco: 49.90,
                              fontSizePreco: 16,
                              precoEmDestaque: true,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 16.h),
                      Text(
                        'PAGAMENTO',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 14.h),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(16.r),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        child: const ContainerNhac(
                          icon: Icons.credit_card_rounded,
                          informacao: 'Online · Cartão de crédito',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16.h),
              ButtonNhac(
                texto: 'Atualizar status',
                onTap: () => context.push('/update-status'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}