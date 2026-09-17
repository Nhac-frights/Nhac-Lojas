import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:nhac_lojas/components/back_arrow.dart';
import 'package:nhac_lojas/components/button_nhac.dart';
import 'package:nhac_lojas/components/item_horario_funcionamento.dart';
import 'package:nhac_lojas/components/register_steps.dart';

class HorarioFuncionamentoPage extends StatelessWidget {
  const HorarioFuncionamentoPage({super.key});

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
                const RegisterSteps(passoAtual: PassoCadastrar.horarios),
                SizedBox(height: 18.h),
                Text(
                  'Horário de funcionamento',
                  style: TextStyle(
                    fontSize: 28.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  'Defina os dias e horários em que sua loja recebe pedidos.',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(height: 18.h),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    'Copiar p/ todos os dias',
                    style: TextStyle(
                      color: Colors.redAccent,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(height: 18.h),
                const ItemHorarioFuncionamento(
                  diaSemana: 'Seg',
                  horario: '08:00 - 18:00',
                  ativoInicial: true,
                ),
                const Divider(),
                const ItemHorarioFuncionamento(
                  diaSemana: 'Ter',
                  horario: '08:00 - 18:00',
                  ativoInicial: true,
                ),
                const Divider(),
                const ItemHorarioFuncionamento(
                  diaSemana: 'Qua',
                  horario: '08:00 - 18:00',
                  ativoInicial: true,
                ),
                const Divider(),
                const ItemHorarioFuncionamento(
                  diaSemana: 'Qui',
                  horario: '08:00 - 18:00',
                  ativoInicial: true,
                ),
                const Divider(),
                const ItemHorarioFuncionamento(
                  diaSemana: 'Sex',
                  horario: '08:00 - 22:00',
                  ativoInicial: true,
                ),
                const Divider(),
                const ItemHorarioFuncionamento(
                  diaSemana: 'Sáb',
                  horario: '10:00 - 22:00',
                  ativoInicial: true,
                ),
                const Divider(),
                const ItemHorarioFuncionamento(
                  diaSemana: 'Dom',
                  horario: 'Fechado',
                  ativoInicial: false,
                ),
                SizedBox(height: 24.h),
                ButtonNhac(
                  texto: fromReview ? 'Salvar e voltar à revisão' : 'Continuar',
                  onTap: () {
                    if (fromReview) {
                      context.pop();
                    } else {
                      context.push('/forma-pagamento-cadastro');
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