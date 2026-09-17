import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:nhac_lojas/components/back_arrow.dart';
import 'package:nhac_lojas/components/button_nhac.dart';
import 'package:nhac_lojas/components/nhac_input_field.dart';
import 'package:nhac_lojas/components/register_steps.dart';

class EnderecoLojaPage extends StatelessWidget {
  const EnderecoLojaPage({super.key});

  @override
  Widget build(BuildContext context) {
    final bool fromReview =
        GoRouterState.of(context).uri.queryParameters['fromReview'] == 'true';

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 20.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const BackArrow(),
                    SizedBox(width: 12.w),
                    Text(
                      'Cadastrar loja',
                      style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(height: 24.h),
                const RegisterSteps(passoAtual: PassoCadastrar.endereco),
                SizedBox(height: 18.h),
                Text(
                  'Endereço da loja',
                  style: TextStyle(fontSize: 28.sp, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8.h),
                Text(
                  'Informe onde sua loja está localizada.',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(height: 18.h),
                Text(
                  'CEP',
                  style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 4.h),
                NhacInputField(
                  hintText: '00000-000',
                  keyboardType: TextInputType.number,
                  suffixIcon: Icon(
                    Icons.search_rounded,
                    color: Colors.redAccent,
                    size: 24.sp,
                  ),
                ),
                SizedBox(height: 16.h),
                Text(
                  'Rua',
                  style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 4.h),
                const NhacInputField(hintText: 'Nome da rua'),
                SizedBox(height: 16.h),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Número',
                            style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 4.h),
                          const NhacInputField(
                            hintText: '123',
                            keyboardType: TextInputType.number,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Complemento',
                            style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 4.h),
                          const NhacInputField(hintText: 'Opcional'),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.h),
                Text(
                  'Bairro',
                  style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 4.h),
                const NhacInputField(hintText: 'Nome do bairro'),
                SizedBox(height: 16.h),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Cidade',
                            style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 4.h),
                          const NhacInputField(hintText: 'Nome da cidade'),
                        ],
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'UF',
                            style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 4.h),
                          const NhacInputField(hintText: 'UF'),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 24.h),
                ButtonNhac(
                  texto: fromReview ? 'Salvar e voltar à revisão' : 'Continuar',
                  onTap: () {
                    if (fromReview) {
                      context.pop();
                    } else {
                      context.push('/dados-entrega');
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}