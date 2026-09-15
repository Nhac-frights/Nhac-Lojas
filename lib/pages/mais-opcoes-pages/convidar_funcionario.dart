import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:nhac_lojas/components/app_notification.dart';
import 'package:nhac_lojas/components/back_arrow.dart';
import 'package:nhac_lojas/components/button_nhac.dart';
import 'package:nhac_lojas/components/container_nhac.dart';
import 'package:nhac_lojas/components/filter_tag.dart';
import 'package:nhac_lojas/components/nhac_input_field.dart';

class ConvidarFuncionario extends StatelessWidget {
  const ConvidarFuncionario({super.key});

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
                    'Convidar funcionário',
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
                        'Nome completo',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      NhacInputField(
                        prefixIcon: Icon(Icons.person_2_outlined),
                        hintText: 'Ex: João Pedro',
                      ),
                      SizedBox(height: 16.h),
                      Text(
                        'E-mail ou telefone',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      NhacInputField(
                        prefixIcon: Icon(Icons.email_outlined),
                        hintText: 'joao@email.com',
                      ),
                      SizedBox(height: 16.h),
                      Text(
                        'Cargo',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      ListaFilterTags(filtros: ['Admin', 'Lojista']),
                      SizedBox(height: 16.h),
                      Text(
                        'O QUE ESSE CARGO ACESSA',
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
                            ContainerNhac(
                              informacao: 'Pedidos e mensagens',
                              exibirCheckVerde: true,
                            ),
                            SizedBox(height: 8.h),
                            Divider(),
                            SizedBox(height: 8.h),
                            ContainerNhac(
                              informacao: 'Cardápio',
                              exibirCheckVerde: true,
                            ),
                            SizedBox(height: 8.h),
                            Divider(),
                            SizedBox(height: 8.h),
                            ContainerNhac(
                              informacao: 'Painel da loja completo',
                              exibirCheckVerde: true,
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
                texto: 'Enviar convite',
                onTap: () {
                  context.pop();
                  showAppNotification(
                    context,
                    type: NotificationType.success,
                    message: 'Convite enviado com sucesso!',
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}