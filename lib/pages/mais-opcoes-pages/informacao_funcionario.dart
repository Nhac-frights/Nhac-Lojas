import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nhac_lojas/components/app_notification.dart';
import 'package:nhac_lojas/components/back_arrow.dart';
import 'package:nhac_lojas/components/button_nhac.dart';
import 'package:nhac_lojas/components/container_nhac.dart';
import 'package:nhac_lojas/components/filter_tag.dart';

class InformacaoFuncionario extends StatelessWidget {
  const InformacaoFuncionario({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(20.w, 46.h, 20.w, 110.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const BackArrow(),
                  SizedBox(width: 12.w),
                  Text(
                    'Funcionário',
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24.h),
              Center(
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 44.r,
                      backgroundColor: const Color.fromARGB(255, 255, 242, 230),
                      child: Text(
                        'CA',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      'Carlos Andrade',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Container(
                      padding: EdgeInsets.symmetric(
                        vertical: 4.h,
                        horizontal: 12.w,
                      ),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(50, 76, 175, 79),
                        borderRadius: BorderRadius.circular(24.r),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.circle, color: Colors.green, size: 8.sp),
                          SizedBox(width: 4.w),
                          Text(
                            'Ativo',
                            style: TextStyle(
                              color: Colors.green,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16.h),
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
                        informacao: 'E-mail',
                        complemento: 'carlos.andrade@email.com',
                      ),
                    ),
                    Divider(),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 8.h,
                        horizontal: 4.w,
                      ),
                      child: ContainerNhac(
                        informacao: 'Telefone',
                        complemento: '(11) 97654-3210',
                      ),
                    ),
                    Divider(),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 8.h,
                        horizontal: 4.w,
                      ),
                      child: ContainerNhac(
                        informacao: 'Funcionário desde',
                        complemento: '11/09/2026',
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16.h),
              Text(
                'Cargo',
                style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 4.h),
              ListaFilterTags(filtros: ['Lojista', 'Admin']),
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
              SizedBox(height: 24.h,),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(16.r),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: ContainerNhac(
                  icon: Icons.person_off_outlined,
                  informacao: 'Remover funcionário',
                  corTitulo: Colors.redAccent,
                  onTap: () {
                    showAppNotification(
                      context,
                      type: NotificationType.info,
                      message: 'Trabaiano nisso calmaaaa'
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
