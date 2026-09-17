import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:nhac_lojas/components/back_arrow.dart';
import 'package:nhac_lojas/components/button_nhac.dart';
import 'package:nhac_lojas/components/container_nhac.dart';
import 'package:nhac_lojas/components/filter_tag.dart';

class CupomPage extends StatefulWidget {
  const CupomPage({super.key});

  @override
  State<CupomPage> createState() => _CupomPageState();
}

class _CupomPageState extends State<CupomPage> {
  bool cupom1Status = true;
  bool cupom2Status = true;
  bool cupom3Status = false;

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
                    'Cupons e promoções',
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24.h),
              
              // Conteúdo rolável encapsulado
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListaFilterTags(
                        filtros: const ['Ativos', 'Encerrados'],
                        quantidades: const [2, 3],
                      ),
                      SizedBox(height: 16.h),
                      Text(
                        'ATIVOS',
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
                        child: ContainerNhac(
                          informacao: '10% de desconto no frete',
                          complemento: 'Pedidos acima de R\$ 30,00\nVálido até 20/11/2026',
                          maxLinesComplemento: 2,
                          situacao: 'FRETE10',
                          ativoInicial: cupom1Status,
                          exibirTagEmCima: true,
                          exibirSwitch: true,
                          corTitulo: cupom1Status ? null : Colors.grey[400],
                          corComplemento: cupom1Status ? null : Colors.grey[400],
                          corSituacao: cupom1Status ? null : Colors.grey[400],
                          corSituacaoFundo: cupom1Status ? null : Colors.grey[200],
                          onSwitchChanged: (valor){
                            setState(() {
                              cupom1Status = valor;
                            });
                          },
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
                        child: ContainerNhac(
                          informacao: '20% de desconto',
                          complemento: 'Pedidos acima de R\$ 50,00\nVálido até 23/11/2026',
                          maxLinesComplemento: 2,
                          situacao: 'NHAC20',
                          ativoInicial: cupom2Status,
                          exibirTagEmCima: true,
                          exibirSwitch: true,
                          corTitulo: cupom2Status ? null : Colors.grey[400],
                          corComplemento: cupom2Status ? null : Colors.grey[400],
                          corSituacao: cupom2Status ? null : Colors.grey[400],
                          corSituacaoFundo: cupom2Status ? null : Colors.grey[200],
                          onSwitchChanged: (valor){
                            setState(() {
                              cupom2Status = valor;
                            });
                          },
                        ),
                      ),
                      SizedBox(height: 16.h),
                      Text(
                        'ENCERRADOS',
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
                        child: ContainerNhac(
                          informacao: 'R\$ 10,00 de desconto',
                          complemento: 'Em combos selecionados\nVálido até 30/05/2026',
                          maxLinesComplemento: 2,
                          situacao: 'COMBO10',
                          ativoInicial: cupom3Status,
                          exibirTagEmCima: true,
                          exibirSwitch: true,
                          corTitulo: cupom3Status ? null : Colors.grey[400],
                          corComplemento: cupom3Status ? null : Colors.grey[400],
                          corSituacao: cupom3Status ? null : Colors.grey[400],
                          corSituacaoFundo: cupom3Status ? null : Colors.grey[200],
                          onSwitchChanged: (valor){
                            setState(() {
                              cupom3Status = valor;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              
              SizedBox(height: 16.h),
              
              // Botão fixo no rodapé
              ButtonNhac(
                texto: 'Criar cupom',
                onTap: () => context.push('/criar-cupom'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}