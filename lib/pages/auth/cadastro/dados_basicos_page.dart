import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:nhac_lojas/components/back_arrow.dart';
import 'package:nhac_lojas/components/button_nhac.dart';
import 'package:nhac_lojas/components/nhac_input_field.dart';
import 'package:nhac_lojas/components/register_steps.dart';

class DadosBasicosPage extends StatefulWidget {
  const DadosBasicosPage({super.key});

  @override
  State<DadosBasicosPage> createState() => _DadosBasicosState();
}

class _DadosBasicosState extends State<DadosBasicosPage> {
  bool isCnpj = true;
  final TextEditingController documentoController = TextEditingController();
  final TextEditingController razaoSocialController = TextEditingController();
  final TextEditingController tipoEstabelecimentoController = TextEditingController();
  final TextEditingController tipoCulinariaController = TextEditingController();

  @override
  void dispose() {
    documentoController.dispose();
    razaoSocialController.dispose();
    tipoEstabelecimentoController.dispose();
    tipoCulinariaController.dispose();
    super.dispose();
  }

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
                const RegisterSteps(passoAtual: PassoCadastrar.dados),
                SizedBox(height: 18.h),
                Text(
                  'Dados básicos',
                  style: TextStyle(fontSize: 28.sp, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8.h),
                Text(
                  'Vamos começar com algumas informações sobre sua loja.',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(height: 18.h),
                Row(
                  children: [
                    Stack(
                      children: [
                        Container(
                          width: 76.r,
                          height: 76.r,
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
                        Positioned(
                          right: 2.w,
                          bottom: 2.h,
                          child: Container(
                            padding: EdgeInsets.all(2.r),
                            decoration: const BoxDecoration(
                              color: Color.fromARGB(255, 255, 231, 229),
                              shape: BoxShape.circle,
                            ),
                            child: Container(
                              padding: EdgeInsets.all(6.r),
                              decoration: const BoxDecoration(
                                color: Colors.redAccent,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.add,
                                size: 8.sp,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: 12.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Foto de perfil',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Logo ou foto da fachada da loja',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 18.h),
                Text(
                  'Nome da loja',
                  style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 4.h),
                const NhacInputField(hintText: 'Ex: Nhac Burguer'),
                SizedBox(height: 16.h),

                Text(
                  'Tipo de documento',
                  style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8.h),
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          if (!isCnpj) {
                            setState(() {
                              isCnpj = true;
                              documentoController.clear();
                            });
                          }
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          padding: EdgeInsets.symmetric(vertical: 12.h),
                          decoration: BoxDecoration(
                            color: isCnpj ? const Color(0xFF5D201C) : Colors.white,
                            borderRadius: BorderRadius.circular(50.r),
                            border: Border.all(
                              color: const Color(0xFF5D201C),
                              width: 1.w,
                            ),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            'CNPJ (Empresa)',
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: isCnpj ? Colors.white : const Color(0xFF5D201C),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          if (isCnpj) {
                            setState(() {
                              isCnpj = false;
                              documentoController.clear();
                            });
                          }
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          padding: EdgeInsets.symmetric(vertical: 12.h),
                          decoration: BoxDecoration(
                            color: !isCnpj ? const Color(0xFF5D201C) : Colors.white,
                            borderRadius: BorderRadius.circular(50.r),
                            border: Border.all(
                              color: const Color(0xFF5D201C),
                              width: 1.w,
                            ),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            'CPF (Pessoa Física)',
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: !isCnpj ? Colors.white : const Color(0xFF5D201C),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.h),

                Text(
                  isCnpj ? 'CNPJ' : 'CPF do responsável',
                  style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 4.h),
                NhacInputField(
                  controller: documentoController,
                  hintText: isCnpj ? '00.000.000/0000-00' : '000.000.000-00',
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    _DocumentoInputFormatter(isCnpj: isCnpj),
                  ],
                ),
                SizedBox(height: 16.h),

                if (isCnpj) ...[
                  Text(
                    'Razão Social',
                    style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4.h),
                  NhacInputField(
                    controller: razaoSocialController,
                    hintText: 'Ex: Nhac Restaurante e Hamburgueria Ltda',
                  ),
                  SizedBox(height: 16.h),
                ],

                Text(
                  'Descrição da loja',
                  style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 4.h),
                const NhacInputField(
                  hintText: 'Conte um pouco sobre a sua loja...',
                  maxLines: 3,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    '0/150',
                    style: TextStyle(color: Colors.grey, fontSize: 12.sp),
                  ),
                ),
                SizedBox(height: 16.h),
                Text(
                  'Tipo de estabelecimento',
                  style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 4.h),
                NhacInputField(
                  controller: tipoEstabelecimentoController,
                  hintText: 'Selecione',
                  readOnly: true,
                  suffixIcon: Icon(Icons.keyboard_arrow_down_rounded, size: 24.sp),
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return ListView(
                          shrinkWrap: true,
                          children: [
                            ListTile(
                              title: const Text('Restaurante'),
                              onTap: () {
                                tipoEstabelecimentoController.text = 'Restaurante';
                                Navigator.pop(context);
                              },
                            ),
                            ListTile(
                              title: const Text('Lanchonete'),
                              onTap: () {
                                tipoEstabelecimentoController.text = 'Lanchonete';
                                Navigator.pop(context);
                              },
                            ),
                            ListTile(
                              title: const Text('Padaria'),
                              onTap: () {
                                tipoEstabelecimentoController.text = 'Padaria';
                                Navigator.pop(context);
                              },
                            ),
                            ListTile(
                              title: const Text('Mercado/conveniência'),
                              onTap: () {
                                tipoEstabelecimentoController.text = 'Mercado/conveniência';
                                Navigator.pop(context);
                              },
                            ),
                            ListTile(
                              title: const Text('Farmácia'),
                              onTap: () {
                                tipoEstabelecimentoController.text = 'Farmácia';
                                Navigator.pop(context);
                              },
                            ),
                            ListTile(
                              title: const Text('Pet shop'),
                              onTap: () {
                                tipoEstabelecimentoController.text = 'Pet shop';
                                Navigator.pop(context);
                              },
                            ),
                            ListTile(
                              title: const Text('Loja de bebidas'),
                              onTap: () {
                                tipoEstabelecimentoController.text = 'Loja de bebidas';
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
                SizedBox(height: 16.h),
                Text(
                  'Culinária / Categoria',
                  style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 4.h),
                NhacInputField(
                  controller: tipoCulinariaController,
                  hintText: 'Selecione',
                  readOnly: true,
                  suffixIcon: Icon(Icons.keyboard_arrow_down_rounded, size: 24.sp),
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return ListView(
                          shrinkWrap: true,
                          children: [
                            ListTile(
                              title: const Text('Hamburgueria'),
                              onTap: () {
                                tipoCulinariaController.text = 'Hamburgueria';
                                Navigator.pop(context);
                              },
                            ),
                            ListTile(
                              title: const Text('Pizzaria'),
                              onTap: () {
                                tipoCulinariaController.text = 'Pizzaria';
                                Navigator.pop(context);
                              },
                            ),
                            ListTile(
                              title: const Text('Japonesa'),
                              onTap: () {
                                tipoCulinariaController.text = 'Japonesa';
                                Navigator.pop(context);
                              },
                            ),
                            ListTile(
                              title: const Text('Doceria'),
                              onTap: () {
                                tipoCulinariaController.text = 'Doceria';
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
                SizedBox(height: 24.h),
                ButtonNhac(
                  texto: fromReview ? 'Salvar e voltar à revisão' : 'Continuar',
                  onTap: () {
                    if (fromReview) {
                      context.pop();
                    } else {
                      context.push('/endereco-loja');
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

class _DocumentoInputFormatter extends TextInputFormatter {
  final bool isCnpj;

  _DocumentoInputFormatter({required this.isCnpj});

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final digitsOnly = newValue.text.replaceAll(RegExp(r'\D'), '');
    final maxLen = isCnpj ? 14 : 11;
    final trimmed = digitsOnly.length > maxLen
        ? digitsOnly.substring(0, maxLen)
        : digitsOnly;

    final StringBuffer buffer = StringBuffer();
    if (isCnpj) {
      for (int i = 0; i < trimmed.length; i++) {
        if (i == 2 || i == 5) buffer.write('.');
        if (i == 8) buffer.write('/');
        if (i == 12) buffer.write('-');
        buffer.write(trimmed[i]);
      }
    } else {
      for (int i = 0; i < trimmed.length; i++) {
        if (i == 3 || i == 6) buffer.write('.');
        if (i == 9) buffer.write('-');
        buffer.write(trimmed[i]);
      }
    }

    final formatted = buffer.toString();
    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}