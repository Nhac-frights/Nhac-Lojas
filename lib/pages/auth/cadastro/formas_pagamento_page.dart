import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:nhac_lojas/components/back_arrow.dart';
import 'package:nhac_lojas/components/button_nhac.dart';
import 'package:nhac_lojas/components/item_forma_pagamento.dart';
import 'package:nhac_lojas/components/register_steps.dart';

class FormasPagamentoPage extends StatefulWidget {
  const FormasPagamentoPage({super.key});

  @override
  State<FormasPagamentoPage> createState() => _FormasPagamentoPageState();
}

class _FormasPagamentoPageState extends State<FormasPagamentoPage> {
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
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 24.h),
                const RegisterSteps(passoAtual: PassoCadastrar.pagamento),
                SizedBox(height: 18.h),
                Text(
                  'Formas de pagamento',
                  style: TextStyle(fontSize: 28.sp, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8.h),
                Text(
                  'Selecione as formas de pagamento que sua loja aceita.',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(height: 18.h),
                const ItemFormaPagamento(
                  icon: Icons.money_outlined,
                  metodo: 'Dinheiro',
                ),
                const Divider(),
                const ItemFormaPagamento(
                  icon: Icons.credit_card,
                  metodo: 'Cartão de crédito',
                ),
                const Divider(),
                const ItemFormaPagamento(
                  icon: Icons.credit_card,
                  metodo: 'Cartão de débito',
                ),
                const Divider(),
                const ItemFormaPagamento(
                  icon: Icons.bolt_outlined,
                  metodo: 'Pix',
                ),
                const Divider(),
                const ItemFormaPagamento(
                  icon: Icons.money_outlined,
                  metodo: 'Vale refeição',
                  ativoInicial: false,
                ),
                const Divider(),
                const ItemFormaPagamento(
                  icon: Icons.money_outlined,
                  metodo: 'Vale alimentação',
                  ativoInicial: false,
                ),
                SizedBox(height: 24.h),
                ButtonNhac(
                  texto: fromReview ? 'Salvar e voltar à revisão' : 'Continuar',
                  onTap: () {
                    if (fromReview) {
                      context.pop();
                    } else {
                      context.push('/revisar-dados');
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
