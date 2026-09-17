import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nhac_lojas/components/back_arrow.dart';
import 'package:nhac_lojas/components/container_card_avaliacao.dart';
import 'package:nhac_lojas/components/container_nhac.dart';
import 'package:nhac_lojas/components/filter_tag.dart';

class AvaliacoesPage extends StatelessWidget {
  const AvaliacoesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 24.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const BackArrow(),
                  SizedBox(width: 12.w),
                  Text(
                    'Avaliações',
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24.h),
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
                      informacao: 'Muito dificil depois faço'
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16.h),
              
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    const ListaFilterTags(
                      filtros: ['Todas', 'Não respondidas', 'Respondidas'],
                      quantidades: [127, 5, 122],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16.h),
              ContainerCardAvaliacao(
                letraAvatar: 'MS',
                nomeCliente: 'Maria Silva',
                horario: 'Hoje',
                quantidadeEstrelas: 5,
                comentario: 'Muito rápido e o lanche chegou quente! Recomendo'
              ),
              SizedBox(height: 16.h,),
              ContainerCardAvaliacao(
                letraAvatar: 'JP',
                nomeCliente: 'João Pedro',
                horario: 'Ontem',
                quantidadeEstrelas: 5,
                comentario: 'Melhor hambúrguer da região'
              ),
              SizedBox(height: 16.h,),
              ContainerCardAvaliacao(
                letraAvatar: 'AC',
                nomeCliente: 'Ana Clara',
                horario: '2 dias atrás',
                quantidadeEstrelas: 4,
                comentario: 'Muito bom, só a batata que veio fria'
              ),
            ],
          ),
          ),
        ),
      ),
    );
  }
}