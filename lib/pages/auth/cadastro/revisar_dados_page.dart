import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:nhac_lojas/components/back_arrow.dart';
import 'package:nhac_lojas/components/button_nhac.dart';
import 'package:nhac_lojas/components/container_card_revisao.dart';
import 'package:nhac_lojas/components/filter_tag.dart';
import 'package:nhac_lojas/components/register_steps.dart';

class RevisarDadosPage extends StatefulWidget {
  const RevisarDadosPage({super.key});

  @override
  State<RevisarDadosPage> createState() => _RevisarDadosPageState();
}

class _RevisarDadosPageState extends State<RevisarDadosPage> {
  bool _aceitouTermos = false;

  void _mostrarTermos(BuildContext context, String titulo, String texto) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (modalContext) {
        return SafeArea(
          child: Padding(
            padding: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 24.h),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  titulo,
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF5D201C),
                  ),
                ),
                SizedBox(height: 12.h),
                Text(
                  texto,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.grey.shade800,
                    height: 1.4,
                  ),
                ),
                SizedBox(height: 20.h),
                ButtonNhac(
                  texto: 'Entendi e concordo',
                  onTap: () {
                    Navigator.pop(modalContext);
                    setState(() {
                      _aceitouTermos = true;
                    });
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

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
                      'Cadastrar loja',
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 24.h),
                const RegisterSteps(passoAtual: PassoCadastrar.revisar),
                SizedBox(height: 18.h),
                Text(
                  'Revise os dados da loja',
                  style: TextStyle(fontSize: 28.sp, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8.h),
                Text(
                  'Confirme as informações antes de finalizar seu cadastro.',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(height: 18.h),

                ContainerCardRevisao(
                  title: 'Dados básicos',
                  onEdit: () => context.push('/dados-basicos?fromReview=true'),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 64.r,
                            height: 64.r,
                            decoration: const BoxDecoration(
                              color: Color.fromARGB(255, 255, 213, 213),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.camera_alt_outlined,
                              size: 24.sp,
                              color: Colors.redAccent,
                            ),
                          ),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Nhac Burguer',
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  'Restaurante · Hamburgueria',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 14.sp,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 12.h),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'CNPJ: ',
                            style: TextStyle(
                              fontSize: 13.sp,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF5D201C),
                            ),
                          ),
                          Text(
                            '12.345.678/0001-90',
                            style: TextStyle(
                              fontSize: 13.sp,
                              color: Colors.grey.shade700,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 4.h),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Razão Social: ',
                            style: TextStyle(
                              fontSize: 13.sp,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF5D201C),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              'Nhac Hamburgueria e Alimentos Ltda',
                              style: TextStyle(
                                fontSize: 13.sp,
                                color: Colors.grey.shade700,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        'Os melhores hambúrgueres artesanais da região, feitos na hora com ingredientes frescos.',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 12.sp,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 18.h),

                ContainerCardRevisao(
                  title: 'Endereço',
                  onEdit: () => context.push('/endereco-loja?fromReview=true'),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Rua das Flores, 123',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        'Centro · São Paulo - SP',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 14.sp,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        'CEP 01310-100',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 14.sp,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 18.h),

                ContainerCardRevisao(
                  title: 'Entrega',
                  onEdit: () => context.push('/dados-entrega?fromReview=true'),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Tipo',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 14.sp,
                            ),
                          ),
                          Text(
                            'Entrega própria',
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 18.h),

                ContainerCardRevisao(
                  title: 'Pagamento',
                  onEdit: () => context.push('/forma-pagamento-cadastro?fromReview=true'),
                  child: Wrap(
                    spacing: 8.w,
                    runSpacing: 8.h,
                    children: const [
                      ListaFilterTags(
                        filtros: ['Dinheiro', 'Crédito', 'Débito', 'Pix']
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 18.h),

                ContainerCardRevisao(
                  title: 'Horários',
                  onEdit: () => context.push('/horario-funcionamento?fromReview=true'),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Seg a Sex',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 14.sp,
                            ),
                          ),
                          Text(
                            '08:00 - 18:00',
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 4.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Sábado',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 14.sp,
                            ),
                          ),
                          Text(
                            '10:00 - 22:00',
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 4.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Domingo',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 14.sp,
                            ),
                          ),
                          Text(
                            'Fechado',
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 24.h),

                // Checkbox obrigatório de termos e privacidade
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 8.h),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 24.r,
                        height: 24.r,
                        child: Checkbox(
                          value: _aceitouTermos,
                          activeColor: const Color(0xFFFF6961),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4.r),
                          ),
                          side: const BorderSide(
                            color: Color(0xFF5D201C),
                            width: 1.5,
                          ),
                          onChanged: (val) {
                            setState(() {
                              _aceitouTermos = val ?? false;
                            });
                          },
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              _aceitouTermos = !_aceitouTermos;
                            });
                          },
                          child: Text.rich(
                            TextSpan(
                              style: TextStyle(
                                fontSize: 13.sp,
                                color: const Color(0xFF5D201C),
                                fontWeight: FontWeight.w500,
                                height: 1.3,
                              ),
                              children: [
                                const TextSpan(text: 'Li e concordo com os '),
                                WidgetSpan(
                                  alignment: PlaceholderAlignment.baseline,
                                  baseline: TextBaseline.alphabetic,
                                  child: GestureDetector(
                                    onTap: () => _mostrarTermos(
                                      context,
                                      'Termos de Uso',
                                      'Ao utilizar a plataforma Nhac Lojas, você concorda com as diretrizes de operação comercial, compromissos de qualidade, prazos de entrega e taxas acordadas com o Nhac.',
                                    ),
                                    child: Text(
                                      'Termos de Uso',
                                      style: TextStyle(
                                        color: Colors.redAccent,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13.sp,
                                        decoration: TextDecoration.underline,
                                      ),
                                    ),
                                  ),
                                ),
                                const TextSpan(text: ' e com a '),
                                WidgetSpan(
                                  alignment: PlaceholderAlignment.baseline,
                                  baseline: TextBaseline.alphabetic,
                                  child: GestureDetector(
                                    onTap: () => _mostrarTermos(
                                      context,
                                      'Política de Privacidade',
                                      'Seus dados e os dados de seus clientes são tratados com total segurança de acordo com a LGPD. Não compartilhamos informações confidenciais com terceiros não autorizados.',
                                    ),
                                    child: Text(
                                      'Política de Privacidade',
                                      style: TextStyle(
                                        color: Colors.redAccent,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13.sp,
                                        decoration: TextDecoration.underline,
                                      ),
                                    ),
                                  ),
                                ),
                                const TextSpan(text: ' do Nhac Lojas.'),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16.h),

                ButtonNhac(
                  texto: 'Finalizar cadastro',
                  onTap: _aceitouTermos
                      ? () => context.go('/loja-cadastrada')
                      : () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Row(
                                children: [
                                  Icon(Icons.info_outline, color: Colors.white, size: 20.sp),
                                  SizedBox(width: 8.w),
                                  Expanded(
                                    child: Text(
                                      'Marque a caixa para concordar com os Termos de Uso e Política de Privacidade.',
                                      style: TextStyle(fontSize: 13.sp, color: Colors.white),
                                    ),
                                  ),
                                ],
                              ),
                              backgroundColor: const Color(0xFF5D201C),
                              behavior: SnackBarBehavior.floating,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                              duration: const Duration(seconds: 3),
                            ),
                          );
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