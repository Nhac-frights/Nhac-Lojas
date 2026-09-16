import 'package:go_router/go_router.dart';
import 'package:nhac_lojas/pages/auth/cadastro/confirmar_email_page.dart';
import 'package:nhac_lojas/services/sessao_service.dart';
import 'package:nhac_lojas/pages/auth/cadastro/criar_conta_page.dart';
import 'package:nhac_lojas/pages/auth/cadastro/dados_basicos_page.dart';
import 'package:nhac_lojas/pages/auth/cadastro/dados_entrega_page.dart';
import 'package:nhac_lojas/pages/auth/cadastro/endereco_loja_page.dart';
import 'package:nhac_lojas/pages/auth/cadastro/formas_pagamento_page.dart';
import 'package:nhac_lojas/pages/auth/cadastro/horario_funcionamento_page.dart';
import 'package:nhac_lojas/pages/auth/cadastro/loja_cadastrada_page.dart';
import 'package:nhac_lojas/pages/auth/cadastro/revisar_dados_page.dart';
import 'package:nhac_lojas/pages/auth/login_loja.dart';
import 'package:nhac_lojas/pages/auth/link_recuperacao_senha.dart';
import 'package:nhac_lojas/pages/auth/nova_senha.dart';
import 'package:nhac_lojas/pages/auth/recuperar_senha.dart';
import 'package:nhac_lojas/pages/bem_vindo.dart';
import 'package:nhac_lojas/pages/mais-opcoes-pages/adicionar_impressora.dart';
import 'package:nhac_lojas/pages/mais-opcoes-pages/avaliacoes_page.dart';
import 'package:nhac_lojas/pages/mais-opcoes-pages/cadastrar_produtos.dart';
import 'package:nhac_lojas/pages/mais-opcoes-pages/cardapio_cheio_page.dart';
import 'package:nhac_lojas/pages/mais-opcoes-pages/cardapio_vazio_page.dart';
import 'package:nhac_lojas/pages/mais-opcoes-pages/configuracoes_app.dart';
import 'package:nhac_lojas/pages/mais-opcoes-pages/configuracoes_conta.dart';
import 'package:nhac_lojas/pages/mais-opcoes-pages/convidar_funcionario.dart';
import 'package:nhac_lojas/pages/mais-opcoes-pages/criar_cupom_page.dart';
import 'package:nhac_lojas/pages/mais-opcoes-pages/cupom_page.dart';
import 'package:nhac_lojas/pages/mais-opcoes-pages/editar_info_loja.dart';
import 'package:nhac_lojas/pages/mais-opcoes-pages/endereco_edicao.dart';
import 'package:nhac_lojas/pages/mais-opcoes-pages/financeiro_page.dart';
import 'package:nhac_lojas/pages/mais-opcoes-pages/formas_pagamento_edicao_page.dart';
import 'package:nhac_lojas/pages/mais-opcoes-pages/funcionarios_page.dart';
import 'package:nhac_lojas/pages/mais-opcoes-pages/horario_edicao_page.dart';
import 'package:nhac_lojas/pages/mais-opcoes-pages/impressoras_page.dart';
import 'package:nhac_lojas/pages/mais-opcoes-pages/informacao_funcionario.dart';
import 'package:nhac_lojas/pages/mais-opcoes-pages/informacao_loja.dart';
import 'package:nhac_lojas/pages/chat_open.dart';
import 'package:nhac_lojas/pages/chat_page.dart';
import 'package:nhac_lojas/pages/home_page.dart';
import 'package:nhac_lojas/pages/main_shell.dart';
import 'package:nhac_lojas/pages/mais-opcoes-pages/relatorio_page.dart';
import 'package:nhac_lojas/pages/more_page.dart';
import 'package:nhac_lojas/pages/order_details_page.dart';
import 'package:nhac_lojas/pages/order_page.dart';
import 'package:nhac_lojas/pages/update_order_status.dart';

/// Rotas que podem ser abertas sem sessão: login, recuperação de senha e o
/// wizard de cadastro da loja. Qualquer outra rota exige estar logado.
const Set<String> rotasPublicas = {
  '/bem-vindo',
  '/login',
  '/criar-conta',
  '/confirmar-email',
  '/dados-basicos',
  '/endereco-loja',
  '/dados-entrega',
  '/horario-funcionamento',
  '/forma-pagamento-cadastro',
  '/revisar-dados',
  '/loja-cadastrada',
  '/recuperar-senha',
  '/link-recuperacao',
  '/nova-senha',
};

final GoRouter appRouter = GoRouter(
  initialLocation: '/bem-vindo',
  // O SessaoService é um ChangeNotifier: quando a sessão é criada ou encerrada
  // (inclusive por 401 do backend) o redirect abaixo é reavaliado e o usuário
  // vai para a rota certa sem navegação explícita.
  refreshListenable: SessaoService.instance,
  redirect: (context, state) {
    final sessao = SessaoService.instance;
    final local = state.matchedLocation;
    final rotaPublica = rotasPublicas.contains(local);

    // Sem sessão: só as rotas públicas (senão, login).
    if (!sessao.estaLogado) return rotaPublica ? null : '/login';

    // Com sessão: bem-vindo e login viram a home.
    if (local == '/bem-vindo' || local == '/login') return '/home';

    return null;
  },
  routes: [
    ShellRoute(
      builder: (context, state, child) {
        return MainShell(child: child);
      },
      routes: [
        GoRoute(
          path: '/home',
          builder: (context, state) => const HomePage(),
        ),
        GoRoute(
          path: '/orders',
          builder: (context, state) => const OrderPage(),
        ),
        GoRoute(
          path: '/chat',
          builder: (context, state) => const ChatPage(),
        ),
        GoRoute(
          path: '/mais',
          builder: (context, state) => const MorePage(),
        ),
      ],
    ),
    GoRoute(
      path: '/bem-vindo',
      builder: (context, state) => const BemVindo(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginLoja(),
    ),
    GoRoute(
      path: '/recuperar-senha',
      builder: (context, state) => const RecuperarSenha(),
    ),
    GoRoute(
      path: '/link-recuperacao',
      builder: (context, state) => const LinkRecuperacaoSenha(),
    ),
    GoRoute(
      path: '/nova-senha',
      builder: (context, state) => const NovaSenha(),
    ),
    GoRoute(
      path: '/criar-conta',
      builder: (context, state) => const CriarContaPage(),
    ),
    GoRoute(
      path: '/confirmar-email',
      builder: (context, state) => const ConfirmarEmailPage(),
    ),
    GoRoute(
      path: '/dados-basicos',
      builder: (context, state) => const DadosBasicosPage(),
    ),
    GoRoute(
      path: '/endereco-loja',
      builder: (context, state) => const EnderecoLojaPage(),
    ),
    GoRoute(
      path: '/dados-entrega',
      builder: (context, state) => const DadosEntregaPage(),
    ),
    GoRoute(
      path: '/horario-funcionamento',
      builder: (context, state) => const HorarioFuncionamentoPage(),
    ),
    GoRoute(
      path: '/forma-pagamento-cadastro',
      builder: (context, state) => const FormasPagamentoPage(),
    ),
    GoRoute(
      path: '/revisar-dados',
      builder: (context, state) => const RevisarDadosPage(),
    ),
    GoRoute(
      path: '/loja-cadastrada',
      builder: (context, state) => const LojaCadastradaPage(),
    ),
    GoRoute(
      path: '/order-details',
      builder: (context, state) => const OrderDetailsPage(),
    ),
    GoRoute(
      path: '/update-status',
      builder: (context, state) => const UpdateOrderStatus(),
    ),
    GoRoute(
      path: '/chat-open',
      builder: (context, state) => const ChatOpen(),
    ),
    GoRoute(
      path: '/informacao-loja',
      builder: (context, state) => const InformacaoLoja(),
    ),
    GoRoute(
      path: '/formas-pagamento-edicao',
      builder: (context, state) => FormasPagamentoEdicaoPage(),
    ),
    GoRoute(
      path: '/endereco-edicao',
      builder: (context, state) => EnderecoEdicao(),
    ),
    GoRoute(
      path: '/configuracoes-conta',
      builder: (context, state) => ConfiguracoesConta(),
    ),
    GoRoute(
      path: '/cardapio-vazio',
      builder: (context, state) => const CardapioVazioPage(),
    ),
    GoRoute(
      path: '/cadastrar-produtos',
      builder: (context, state) => CadastrarProdutos(
        isEdicao: state.extra == true,
      ),
    ),
    GoRoute(
      path: '/cardapio-cheio',
      builder: (context, state) => const CardapioCheioPage(),
    ),
    GoRoute(
      path: '/financeiro',
      builder: (context, state) => const FinanceiroPage(),
    ),
    GoRoute(
      path: '/relatorio',
      builder: (context, state) => const RelatorioPage(),
    ),
    GoRoute(
      path: '/avaliacoes',
      builder: (context, state) => const AvaliacoesPage(),
    ),
    GoRoute(
      path: '/horarios',
      builder: (context, state) => const HorarioEdicaoPage(),
    ),
    GoRoute(
      path: '/cupom',
      builder: (context, state) => const CupomPage(),
    ),
    GoRoute(
      path: '/criar-cupom',
      builder: (context, state) => const CriarCupomPage(),
    ),
    GoRoute(
      path: '/funcionarios',
      builder: (context, state) => const FuncionariosPage(),
    ),
    GoRoute(
      path: '/convidar-funcionario',
      builder: (context, state) => const ConvidarFuncionario(),
    ),
    GoRoute(
      path: '/informacao-funcionario',
      builder: (context, state) => const InformacaoFuncionario(),
    ),
    GoRoute(
      path: '/impressoras',
      builder: (context, state) => const ImpressorasPage(),
    ),
    GoRoute(
      path: '/adicionar-impressora',
      builder: (context, state) => const AdicionarImpressora(),
    ),
    GoRoute(
      path: '/configuracoes-app',
      builder: (context, state) => const ConfiguracoesApp(),
    ),
    GoRoute(
      path: '/editar-info-loja',
      builder: (context, state) => const EditarInfoLoja(),
    ),
  ],
);