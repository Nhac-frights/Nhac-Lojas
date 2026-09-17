import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nhac_lojas/components/back_arrow.dart';
import 'package:nhac_lojas/components/container_nhac.dart';

class ConfiguracoesApp extends StatefulWidget {
  const ConfiguracoesApp({super.key});

  @override
  State<ConfiguracoesApp> createState() => _ConfiguracoesAppState();
}

class _ConfiguracoesAppState extends State<ConfiguracoesApp> {
  bool somPedido = true;
  bool vibracao = true;

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
                    'Configurações do app',
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24.h),
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'SOM E ALERTAS',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                      ),
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
                              informacao: 'Som de novo pedido',
                              complemento: 'Toca com o app em segundo plano',
                              exibirSwitch: true,
                              ativoInicial: somPedido,
                              onSwitchChanged: (valor) {
                                setState(() {
                                  somPedido = valor;
                                });
                              },
                              onTap: () => {
                                setState(() {
                                  somPedido = !somPedido;
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
                              informacao: 'Vibração',
                              complemento: 'Vibra ao receber notificações',
                              exibirSwitch: true,
                              ativoInicial: vibracao,
                              onSwitchChanged: (valor) {
                                setState(() {
                                  vibracao = valor;
                                });
                              },
                              onTap: () => {
                                setState(() {
                                  vibracao = !vibracao;
                                }),
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      'SOBRE',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                      ),
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
                          ContainerNhac(
                            informacao: 'Termo de uso',
                            exibirSeta: true,
                          ),
                          SizedBox(height: 8.h),
                          Divider(),
                          SizedBox(height: 8.h),
                          ContainerNhac(
                            informacao: 'Política de privacidade',
                            exibirSeta: true,
                          ),
                          SizedBox(height: 8.h),
                          Divider(),
                          SizedBox(height: 8.h),
                          ContainerNhac(
                            informacao: 'Fale com o suporte',
                            exibirSeta: true,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Align(
                      alignment: AlignmentGeometry.center,
                      child: Text(
                        'Nhac Lojas · versão 2.4.1',
                        style: TextStyle(color: Colors.grey, fontSize: 10),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
