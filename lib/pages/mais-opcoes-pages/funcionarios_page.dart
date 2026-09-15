import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:nhac_lojas/components/app_notification.dart';
import 'package:nhac_lojas/components/back_arrow.dart';
import 'package:nhac_lojas/components/button_nhac.dart';
import 'package:nhac_lojas/components/container_nhac.dart';
import 'package:nhac_lojas/components/filter_tag.dart';

class FuncionariosPage extends StatelessWidget {
  const FuncionariosPage({super.key});

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
                    'Funcionários',
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
                      ListaFilterTags(
                        filtros: ['Todos', 'Ativos', 'Pendentes'],
                        quantidades: [4, 3, 1],
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
                                letrasIcon: 'CA',
                                informacao: 'Carlos Andrade',
                                complemento: 'Proprietário',
                                situacao: 'Ativo',
                                corSituacao: Colors.green,
                                corSituacaoFundo: const Color.fromARGB(50, 76, 175, 79),
                                corCirculo: Colors.green,
                                exibirSeta: true,
                                onTap: () => context.push('/informacao-funcionario'),
                              ),
                            ),
                            Divider(),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: 8.h,
                                horizontal: 4.w,
                              ),
                              child: ContainerNhac(
                                letrasIcon: 'MC',
                                informacao: 'Maria Costa',
                                complemento: 'Admin',
                                situacao: 'Ativo',
                                corSituacao: Colors.green,
                                corSituacaoFundo: const Color.fromARGB(50, 76, 175, 79),
                                corCirculo: Colors.green,
                                exibirSeta: true,
                                onTap: () => context.push('/informacao-funcionario'),
                              ),
                            ),
                            Divider(),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: 8.h,
                                horizontal: 4.w,
                              ),
                              child: ContainerNhac(
                                letrasIcon: 'RN',
                                informacao: 'Rafael Nunes',
                                complemento: 'Lojista',
                                situacao: 'Ativo',
                                corSituacao: Colors.green,
                                corSituacaoFundo: const Color.fromARGB(50, 76, 175, 79),
                                corCirculo: Colors.green,
                                exibirSeta: true,
                                onTap: () => context.push('/informacao-funcionario'),
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
                                  letrasIcon: 'LF',
                                  informacao: 'Leonardo Ferreira',
                                  complemento: 'Convite enviado',
                                  situacao: 'Pendente',
                                  corSituacao: Colors.orange,
                                  corSituacaoFundo: const Color.fromARGB(50, 255, 153, 0),
                                  corCirculo: Colors.orange,
                                  exibirSeta: true,
                                  onTap: () => context.push('/informacao-funcionario'),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 16.h),
                      Text(
                        'PERMISSÕES',
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
                              informacao: 'Admin',
                              complemento: 'Acessa pedidos cardápio, financeiro e relatórios',
                            ),
                            SizedBox(height: 4.h),
                            Divider(),
                            SizedBox(height: 4.h),
                            ContainerNhac(
                              informacao: 'Lojista',
                              complemento: 'Acessa apenas pedidos e mensagens',
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
                texto: 'Convidar funcionário',
                onTap: () => context.push('/convidar-funcionario')
              ),
            ],
          ),
        ),
      ),
    );
  }
}