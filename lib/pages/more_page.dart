import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:nhac_lojas/components/app_notification.dart';
import 'package:nhac_lojas/components/container_nhac.dart';
import 'package:nhac_lojas/controllers/scroll_shell_controller.dart';

class MorePage extends StatelessWidget {
  const MorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: ScrollShellController.of(context),
      child: Padding(
        padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 110.h),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Mais',
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 24.h),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 4.w),
              child: ContainerNhac(
                icon: Icons.store_outlined,
                informacao: 'Informações da loja',
                complemento: 'Endereço, categoria e mais',
                exibirSeta: true,
                onTap: () => context.push('/informacao-loja'),
              ),
            ),
            const Divider(),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 4.w),
              child: ContainerNhac(
                icon: Icons.fastfood_outlined,
                informacao: 'Cardápio',
                complemento: 'Gerencie seus produtos',
                exibirSeta: true,
                onTap: () => context.push('/cardapio-vazio'),
              ),
            ),
            const Divider(),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 4.w),
              child: ContainerNhac(
                icon: Icons.bar_chart_rounded,
                informacao: 'Financeiro',
                complemento: 'Saldo, repasses e taxas',
                exibirSeta: true,
                onTap: () => context.push('/financeiro'),
              ),
            ),
            const Divider(),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 4.w),
              child: ContainerNhac(
                icon: Icons.trending_up_rounded,
                informacao: 'Relatórios',
                complemento: 'Faturamento, vendas e métricas',
                exibirSeta: true,
                onTap: () => context.push('/relatorio'),
              ),
            ),
            const Divider(),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 4.w),
              child: ContainerNhac(
                icon: Icons.star_outline_rounded,
                informacao: 'Avaliações',
                complemento: 'Veja o que os clientes dizem',
                exibirSeta: true,
                onTap: () => context.push('/avaliacoes'),
              ),
            ),
            const Divider(),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 4.w),
              child: ContainerNhac(
                icon: Icons.access_time,
                informacao: 'Horário de funcionamento',
                complemento: 'Configure seus horários',
                exibirSeta: true,
                onTap: () => context.push('/horarios'),
              ),
            ),
            const Divider(),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 4.w),
              child: ContainerNhac(
                icon: Icons.discount_outlined,
                informacao: 'Cupons e promoções',
                complemento: 'Crie e gerencia promoções',
                exibirSeta: true,
                onTap: () => context.push('/cupom'),
              ),
            ),
            const Divider(),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 4.w),
              child: ContainerNhac(
                icon: Icons.people,
                informacao: 'Funcionários',
                complemento: 'Gerencie sua equipe',
                exibirSeta: true,
                onTap: () => context.push('/funcionarios')
              ),
            ),
            const Divider(),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 4.w),
              child: ContainerNhac(
                icon: Icons.print_outlined,
                informacao: 'Impressoras',
                complemento: 'Gerencie suas impressoras',
                exibirSeta: true,
                onTap: () => context.push('/impressoras')
              ),
            ),
            const Divider(),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 4.w),
              child: ContainerNhac(
                icon: Icons.settings,
                informacao: 'Configurações',
                complemento: 'Preferências do aplicativo',
                exibirSeta: true,
                onTap: () => context.push('/configuracoes-app')
              ),
            ),
            const Divider(),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 4.w),
              child: ContainerNhac(
                icon: Icons.headphones_outlined,
                informacao: 'Suporte',
                complemento: 'Fale com nosso suporte',
                exibirSeta: true,
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
    );
  }
}