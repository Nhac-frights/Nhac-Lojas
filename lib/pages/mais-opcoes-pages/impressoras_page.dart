import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:nhac_lojas/components/app_notification.dart';
import 'package:nhac_lojas/components/back_arrow.dart';
import 'package:nhac_lojas/components/button_nhac.dart';
import 'package:nhac_lojas/components/container_nhac.dart';

class ImpressorasPage extends StatefulWidget {
  const ImpressorasPage({super.key});

  @override
  State<ImpressorasPage> createState() => _ImpressorasPageState();
}

class _ImpressorasPageState extends State<ImpressorasPage> {
  bool imprimirAutomatico = true;
  bool viaCozinha = true;

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
                    'Impressoras',
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24.h),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Suas impressoras',
                        style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8.h),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(16.r),
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
                                icon: Icons.print_outlined,
                                corIcone: Color.fromARGB(255, 93, 32, 28),
                                informacao: 'Balcão · Elgin i9',
                                complemento: 'Bluetooth',
                                situacao: 'Conectada',
                                corSituacao: Colors.green,
                                corSituacaoFundo: const Color.fromARGB(50, 76, 175, 79),
                                corCirculo: Colors.green,
                              ),
                            ),
                            Divider(),
                            Opacity(
                              opacity: 0.5,
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  vertical: 8.h,
                                  horizontal: 4.w,
                                ),
                                child: ContainerNhac(
                                  icon: Icons.print_outlined,
                                  corIcone: Color.fromARGB(255, 93, 32, 28),
                                  informacao: 'Cozinha · Epson TM-T20',
                                  complemento: 'Wi-Fi',
                                  situacao: 'Offline',
                                  corSituacao: Colors.grey,
                                  corSituacaoFundo: const Color.fromARGB(
                                    50,
                                    158,
                                    158,
                                    158,
                                  ),
                                  corCirculo: Colors.grey,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 16.h),
                      Text(
                        'Impressão automática',
                        style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8.h),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(16.r),
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
                                informacao: 'Imprimir ao aceitar pedido',
                                complemento: 'Manda direto pra impressora do balcão',
                                exibirSwitch: true,
                                ativoInicial: imprimirAutomatico,
                                onSwitchChanged: (valor) {
                                  setState(() {
                                    imprimirAutomatico = valor;
                                  });
                                },
                                onTap: () => {
                                  setState(() {
                                    imprimirAutomatico = !imprimirAutomatico;
                                  }),
                                },
                              ),
                            ),
                            Divider(),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: 8.h,
                                horizontal: 4.w,
                              ),
                              child: ContainerNhac(
                                informacao: 'Via da cozinha',
                                complemento: 'Segunda via com os itens, sem valores',
                                exibirSwitch: true,
                                ativoInicial: viaCozinha,
                                onSwitchChanged: (valor) {
                                  setState(() {
                                    viaCozinha = valor;
                                  });
                                },
                                onTap: () => {
                                  setState(() {
                                    viaCozinha = !viaCozinha;
                                  }),
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16.h),
              ButtonNhac(
                texto: 'Adicionar impressora',
                onTap: () => context.push('/adicionar-impressora')
              ),
            ],
          ),
        ),
      ),
    );
  }
}