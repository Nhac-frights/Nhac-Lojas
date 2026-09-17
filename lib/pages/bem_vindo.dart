import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:nhac_lojas/components/button_nhac.dart';

class BemVindo extends StatelessWidget {
  const BemVindo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: 120.w,
                            height: 44.h,
                            child: Image.asset('assets/images/nhac-logo.png'),
                          ),
                          Text(
                            'Lojas',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.sp,
                              color: const Color(0xFFFE645C),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 16.h),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              constraints: BoxConstraints(
                                maxHeight: (constraints.maxHeight * 0.35).clamp(160.0, 320.0),
                              ),
                              child: Center(
                                child: Image.asset(
                                  'assets/images/lanche-bem-vindo.png',
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                            SizedBox(height: 16.h),
                            Text(
                              'Bem-vindo ao Nhac Lojas!',
                              style: TextStyle(
                                fontSize: 26.sp,
                                color: const Color(0xFF5D201C),
                                fontWeight: FontWeight.w600,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 8.h),
                            Text(
                              'Faça login para acessar sua loja\nou cadastre uma nova',
                              style: TextStyle(
                                fontSize: 15.sp,
                                color: const Color(0x995D201C),
                                fontWeight: FontWeight.w500,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ButtonNhac(
                            texto: 'Cadastrar minha loja',
                            onTap: () => context.push('/criar-conta'),
                          ),
                          SizedBox(height: 12.h),
                          ButtonNhac(
                            texto: 'Já tenho uma conta · Entrar',
                            isSecundario: true,
                            onTap: () => context.push('/login'),
                          ),
                          SizedBox(height: 12.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Precisa de ajuda? ',
                                style: TextStyle(color: Colors.grey, fontSize: 13.sp),
                              ),
                              Text(
                                'Fale conosco',
                                style: TextStyle(
                                  color: Colors.redAccent,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13.sp,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
