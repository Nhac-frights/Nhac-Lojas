import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:nhac_lojas/components/app_notification.dart';
import 'package:nhac_lojas/components/back_arrow.dart';
import 'package:nhac_lojas/components/button_nhac.dart';
import 'package:nhac_lojas/components/nhac_input_field.dart';
import 'package:nhac_lojas/services/api_service.dart';
import 'package:nhac_lojas/services/sessao_service.dart';

class LoginLoja extends StatefulWidget {
  const LoginLoja({super.key});

  @override
  State<LoginLoja> createState() => _LoginLojaState();
}

class _LoginLojaState extends State<LoginLoja> {
  bool _senhaVisivel = false;
  bool _carregando = false;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();

  String? _erroEmail;
  String? _erroSenha;

  @override
  void dispose() {
    _emailController.dispose();
    _senhaController.dispose();
    super.dispose();
  }

  /// POST /api/v1/auth/login {email, senha} → LoginResponseDTO.
  /// Guarda o token (30 dias) e entra no painel.
  Future<void> _entrar() async {
    final email = _emailController.text.trim();
    final senha = _senhaController.text;

    setState(() {
      _erroEmail = email.isEmpty ? 'Informe seu e-mail' : null;
      _erroSenha = senha.isEmpty ? 'Informe sua senha' : null;
    });
    if (_erroEmail != null || _erroSenha != null) return;

    setState(() => _carregando = true);
    try {
      final resposta = await ApiService.instance.login(
        email: email,
        senha: senha,
      );

      // Gate de papel: este é o app do lojista. CLIENTE e ENTREGADOR não
      // entram no painel (não salvamos a sessão deles).
      if (!SessaoService.papeisComAcessoAoPainel.contains(resposta.papel)) {
        if (!mounted) return;
        showAppNotification(
          context,
          type: NotificationType.error,
          message: 'Esta conta não tem acesso ao painel da loja.',
        );
        return;
      }

      await SessaoService.instance.salvar(resposta);
      if (!mounted) return;
      context.go('/home');
    } on ApiException catch (erro) {
      if (!mounted) return;
      // VALIDACAO_FALHOU traz details por campo; o resto vai como notificação.
      setState(() {
        _erroEmail = erro.details['email']?.toString();
        _erroSenha = erro.details['senha']?.toString();
      });
      if (_erroEmail == null && _erroSenha == null) {
        showAppNotification(
          context,
          type: NotificationType.error,
          message: erro.mensagem,
        );
      }
    } finally {
      if (mounted) setState(() => _carregando = false);
    }
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
                    const BackArrow(targetRoute: '/bem-vindo'),
                    SizedBox(width: 12.w),
                    Text(
                      'Entrar',
                      style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(height: 32.h),
                Text(
                  'Acesse sua conta',
                  style: TextStyle(fontSize: 28.sp, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8.h),
                Text(
                  'Digite seus dados para entrar.',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(height: 24.h),
                Text(
                  'E-mail ou telefone',
                  style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 4.h),
                NhacInputField(
                  controller: _emailController,
                  hintText: 'Email',
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  errorText: _erroEmail,
                  enabled: !_carregando,
                ),
                SizedBox(height: 16.h),
                Text(
                  'Senha',
                  style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 4.h),
                NhacInputField(
                  controller: _senhaController,
                  hintText: 'Senha',
                  obscureText: !_senhaVisivel,
                  textInputAction: TextInputAction.done,
                  errorText: _erroSenha,
                  enabled: !_carregando,
                  onFieldSubmitted: (_) => _entrar(),
                  suffixIcon: IconButton(
                    icon: _senhaVisivel
                        ? Icon(Icons.visibility, color: const Color(0xFFFF6961), size: 24.sp)
                        : SvgPicture.asset(
                            'assets/images/olho-fechado.svg',
                            width: 24.w,
                            height: 24.h,
                            colorFilter: const ColorFilter.mode(
                              Color(0xFFC9BCBC),
                              BlendMode.srcIn,
                            ),
                          ),
                    onPressed: () {
                      setState(() {
                        _senhaVisivel = !_senhaVisivel;
                      });
                    },
                  ),
                ),
                SizedBox(
                  height: 35.h,
                  width: double.infinity,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      child: Text(
                        'Esqueceu sua senha?',
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: const Color(0xFFFF6961),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      onPressed: () {
                        context.push('/recuperar-senha');
                      },
                    ),
                  ),
                ),
                SizedBox(height: 32.h),
                ButtonNhac(
                  texto: _carregando ? 'Entrando...' : 'Continuar',
                  onTap: _carregando ? null : _entrar,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
