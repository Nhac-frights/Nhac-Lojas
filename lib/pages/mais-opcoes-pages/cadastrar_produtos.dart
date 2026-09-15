import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:nhac_lojas/components/app_notification.dart';
import 'package:nhac_lojas/components/back_arrow.dart';
import 'package:nhac_lojas/components/button_nhac.dart';
import 'package:nhac_lojas/components/container_nhac.dart';
import 'package:nhac_lojas/components/filter_tag.dart';
import 'package:nhac_lojas/components/nhac_input_field.dart';

class CadastrarProdutos extends StatefulWidget {
  final bool isEdicao;
  const CadastrarProdutos({this.isEdicao = false, super.key});

  @override
  State<CadastrarProdutos> createState() => _CadastrarProdutosState();
}

class _CadastrarProdutosState extends State<CadastrarProdutos> {
  bool produtoDisponivel = true;
  
  late final TextEditingController nomeController;
  late final TextEditingController descricaoController;
  late final TextEditingController precoController;
  late final TextEditingController descontoController;

  @override
  void initState() {
    super.initState();
    nomeController = TextEditingController(
      text: widget.isEdicao ? 'X-Burguer' : '',
    );
    descricaoController = TextEditingController(
      text: widget.isEdicao ? 'Uma descrição muito boa uau' : '',
    );
    precoController = TextEditingController(
      text: widget.isEdicao ? 'R\$ 29,90' : '',
    );
    descontoController = TextEditingController(
      text: widget.isEdicao ? '5%' : '',
    );
  }

  @override
  void dispose() {
    nomeController.dispose();
    descricaoController.dispose();
    precoController.dispose();
    descontoController.dispose();
    super.dispose();
  }

  void _mostrarModalDeletar(BuildContext context) {
    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (modalContext) {
        return SafeArea(
          child: Padding(
            padding: EdgeInsets.fromLTRB(20.r, 0, 20.r, 20.r),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(
                  radius: 36.r,
                  backgroundColor: const Color.fromARGB(255, 255, 242, 230),
                  child: Icon(
                    Icons.delete_outline_rounded,
                    color: Colors.redAccent,
                    size: 32.sp,
                  ),
                ),
                SizedBox(height: 16.h),
                Text(
                  'Excluir produto?',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  textAlign: TextAlign.center,
                  'Essa ação não pode ser desfeita. O produto será\nremovido definitivamente do seu cardápio.',
                  style: TextStyle(color: Colors.grey, fontSize: 14.sp),
                ),
                SizedBox(height: 24.h),
                ButtonNhac(
                  texto: 'Excluir produto',
                  onTap: () {
                    Navigator.pop(modalContext);
                    context.go('/cardapio-cheio');
                    showAppNotification(
                      context,
                      type: NotificationType.success,
                      assetImagePath: 'assets/images/hamburguer-nhac.jpg',
                      message: '${nomeController.text.isNotEmpty ? nomeController.text : "Produto"} excluído!',
                    );
                  },
                ),
                SizedBox(height: 12.h),
                ButtonNhac(
                  texto: 'Cancelar',
                  isSecundario: true,
                  onTap: () => Navigator.pop(modalContext),
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
            padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 20.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const BackArrow(),
                    SizedBox(width: 16.w),
                    Text(
                      widget.isEdicao ? 'Editar produto' : 'Novo produto',
                      style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(height: 24.h),
                widget.isEdicao
                ? Stack(
                    children: [
                      Container(
                        width: double.infinity,
                        height: 156.h,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12.r),
                          border: Border.all(color: Colors.redAccent),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12.r),
                          child: Image.asset(
                            'assets/images/hamburguer-nhac.jpg',
                            width: double.infinity,
                            height: 156.h,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Positioned(
                        right: 10,
                        bottom: 10,
                        child: Container(
                          padding: EdgeInsets.all(8.r),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.redAccent)
                          ),
                          child: Icon(
                            Icons.camera_alt_outlined,
                            color: Colors.redAccent,
                            size: 18.sp,
                          ),
                        ),
                      ),
                    ],
                  )
                : Container(
                    width: double.infinity,
                    height: 156.h,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(color: Colors.redAccent),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.camera_alt_outlined,
                          color: Colors.redAccent,
                          size: 26.sp,
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          'Adicionar foto do produto',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.redAccent,
                            fontSize: 14.sp,
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          'PNG ou JPG, até 5MB',
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                SizedBox(height: 16.h),
                Text(
                  'Nome do produto',
                  style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 4.h),
                NhacInputField(
                  controller: nomeController,
                  hintText: 'Ex: X-Burguer',
                ),
                SizedBox(height: 16.h),
                Text(
                  'Descrição',
                  style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 4.h),
                NhacInputField(
                  controller: descricaoController,
                  hintText: 'Descreva os ingredientes e detalhes',
                  maxLines: 3,
                ),
                SizedBox(height: 16.h),
                Text(
                  'Categoria',
                  style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 4.h),
                Wrap(
                  spacing: 8.w,
                  runSpacing: 8.h,
                  children: const [
                    ListaFilterTags(
                      filtros: ['Lanches', 'Bebidas', 'Sobremesas', 'Acompanhantes']
                    ),
                  ],
                ),
                SizedBox(height: 16.h),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Preço',
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 4.h),
                          NhacInputField(
                            controller: precoController,
                            hintText: 'R\$ 0,00',
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Desconto (opcional)',
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 4.h),
                          NhacInputField(
                            controller: descontoController,
                            hintText: '0%',
                          ),
                        ],
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
                  child: ContainerNhac(
                    informacao: 'Disponível',
                    complemento: 'Produto aparece no cardápio',
                    exibirSwitch: true,
                    ativoInicial: produtoDisponivel,
                    onSwitchChanged: (valor) {
                      setState(() {
                        produtoDisponivel = valor;
                      });
                    },
                  ),
                ),
                SizedBox(height: 24.h),
                if (widget.isEdicao)
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: GestureDetector(
                          onTap: () => _mostrarModalDeletar(context),
                          child: Container(
                            height: 49.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(32),
                              border: Border.all(
                                color: Colors.redAccent.withValues(alpha: 0.4),
                                width: 1.2,
                              ),
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.delete_outline_rounded,
                                color: Colors.redAccent,
                                size: 24,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        flex: 4,
                        child: ButtonNhac(
                          texto: 'Salvar produto',
                          onTap: () {
                            context.go('/cardapio-cheio');
                            showAppNotification(
                              context,
                              type: NotificationType.success,
                              assetImagePath: 'assets/images/hamburguer-nhac.jpg',
                              message: 'Produto editado!',
                            );
                          },
                        ),
                      ),
                    ],
                  )
                else
                  ButtonNhac(
                    texto: 'Salvar produto',
                    onTap: () {
                      context.go('/cardapio-cheio');
                      showAppNotification(
                        context,
                        type: NotificationType.success,
                        assetImagePath: 'assets/images/hamburguer-nhac.jpg',
                        message: 'Produto criado!',
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