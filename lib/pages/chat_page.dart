import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:nhac_lojas/components/container_nhac.dart';
import 'package:nhac_lojas/components/filter_tag.dart';
import 'package:nhac_lojas/components/icon_container.dart';
import 'package:nhac_lojas/controllers/scroll_shell_controller.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: ScrollShellController.of(context),
      child: Padding( 
        padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 110.h),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  'Chats',
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                IconContainer(
                  icon: Icons.search_rounded,
                ),
                SizedBox(width: 8.w),
                IconContainer(
                  icon: Icons.more_horiz,
                ),
              ],
            ),
            SizedBox(height: 24.h),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  const ListaFilterTags(
                    filtros: ['Todas', 'Pendentes'],
                    quantidades: [4, 2],
                  ),
                ],
              ),
            ),
            SizedBox(height: 24.h),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16.r),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: ContainerNhac(
                letrasIcon: 'MS',
                informacao: 'Maria Silva',
                complemento: 'Olá, poderia enviar mais molho, por favor?',
                horario: '12:35',
                statusMensagem: StatusMensagem.naoLida,
                formatoIcone: BoxShape.circle,
                quantidadeMensagens: 2,
                onTap: () => context.push('/chat-open'),
              ),
            ),
            SizedBox(height: 12.h),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16.r),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: ContainerNhac(
                letrasIcon: 'JP',
                informacao: 'João Pedro',
                complemento: 'Obrigado!',
                horario: '11:50',
                formatoIcone: BoxShape.circle,
                statusMensagem: StatusMensagem.enviada,
                onTap: () => context.push('/chat-open'),
              ),
            ),
            SizedBox(height: 12.h),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16.r),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: ContainerNhac(
                letrasIcon: 'AC',
                informacao: 'Ana Clara',
                complemento: 'Qual o tempo médio de entrega?',
                horario: 'Ontem',
                formatoIcone: BoxShape.circle,
                statusMensagem: StatusMensagem.naoLida,
                quantidadeMensagens: 1,
                onTap: () => context.push('/chat-open'),
              ),
            ),
            SizedBox(height: 12.h),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16.r),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: ContainerNhac(
                letrasIcon: 'LM',
                informacao: 'Lucas Martins',
                complemento: 'Pode deixar na portaria',
                horario: 'Ontem',
                formatoIcone: BoxShape.circle,
                statusMensagem: StatusMensagem.visualizada,
                onTap: () => context.push('/chat-open'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}