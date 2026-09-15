import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:nhac_lojas/components/back_arrow.dart';
import 'package:nhac_lojas/components/button_nhac.dart';
import 'package:nhac_lojas/components/container_nhac.dart';
import 'package:nhac_lojas/components/filter_tag.dart';

class AdicionarImpressora extends StatefulWidget {
  const AdicionarImpressora({super.key});

  @override
  State<AdicionarImpressora> createState() => _AdicionarImpressoraState();
}

class _AdicionarImpressoraState extends State<AdicionarImpressora> {
  bool carregando = true;

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
                        'Tipo de conexão',
                        style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 4.h),
                      const ListaFilterTags(filtros: ['Bluetooth', 'Wi-Fi']),
                      SizedBox(height: 8.h,),
                      Row(
                        children: [
                          if (carregando) ...[
                            SizedBox(width: 8.w),
                            SizedBox(
                              width: 14.w,
                              height: 14.w,
                              child: const CircularProgressIndicator(strokeWidth: 2, color: Colors.redAccent,),
                            ),
                          ],
                          SizedBox(width: 8.w,),
                          Text(
                            'Procurando dispositivos próximos...',
                            style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
                          ),
                        ],
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
                                icon: Icons.print_outlined,
                                corIcone: Color.fromARGB(255, 93, 32, 28),
                                informacao: 'Elgin i9',
                                complemento: '00:1B:44:11:3A:B7',
                                situacao: 'Conectar',
                                corSituacao: Colors.redAccent,
                                corSituacaoFundo: const Color.fromARGB(255, 255, 242, 230),
                                exibirCirculoSituacao: false,
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
                                  informacao: 'Bematech MP-4200',
                                  complemento: '88:4A:EA:5C:21:0F',
                                  situacao: 'Conectar',
                                  corSituacao: Colors.redAccent,
                                  corSituacaoFundo: const Color.fromARGB(255, 255, 242, 230),
                                  exibirCirculoSituacao: false,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 16.h,),
                      Text(
                        'Dica',
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
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.info_outline_rounded,
                              size: 18,
                              color: Colors.redAccent,
                            ),
                            SizedBox(width: 8.w,),
                            Text(
                              'Deixe a impressora ligada e próxima do\ncelular antes de buscar. Se não aparecer, \nverifique se oBluetooth dela está ativado.',
                              style: TextStyle(
                                fontSize: 14,
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Align(
                        alignment: AlignmentGeometry.center,
                        child: Text(
                          'Não encontrou? Adicionar manualmente',
                          style: TextStyle(color: Colors.redAccent, fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}