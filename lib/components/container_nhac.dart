import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum StatusMensagem { naoLida, enviada, visualizada }

class ContainerNhac extends StatelessWidget {
  final IconData? icon;
  final String? letrasIcon;
  final String? informacao;
  final String? complemento;
  final int? quantidadeItens;
  final String? horario;
  final double? preco;
  final int? codigo;
  final String? situacao;
  final bool exibirCirculoSituacao;
  final Color? corSituacao;
  final Color? corSituacaoFundo;
  final Color? corCirculo;
  final double? fontSize;
  final double? fontSizeComplemento;
  final FontWeight? fontWeightComplemento;
  final int? maxLinesComplemento;
  final double? fontSizePreco;
  final StatusMensagem? statusMensagem;
  final int? quantidadeMensagens;
  final Color? corIcone;
  final Color? corFundoIcone;
  final Color? corComplemento;
  final Color? corTitulo;
  final Color? corPreco;
  final BoxShape formatoIcone;
  final VoidCallback? onTap;
  final bool precoEmDestaque;
  final bool selecionado;
  final bool exibirRadio;
  final bool exibirCheck;
  final ValueChanged<bool>? onCheckChanged;
  final bool exibirCheckVerde;
  final bool exibirSeta;
  final bool exibirSwitch;
  final bool ativoInicial;
  final ValueChanged<bool>? onSwitchChanged;
  final String? proximoRepasse;
  final Color? corRepasse;
  final Widget? widget;
  final bool layoutVertical;
  final bool complementoAoLadoPreco;
  final bool exibirTagEmCima;
  final bool layoutAvaliacao;

  const ContainerNhac({
    super.key,
    this.icon,
    this.letrasIcon,
    this.informacao,
    this.complemento,
    this.quantidadeItens,
    this.horario,
    this.preco,
    this.codigo,
    this.situacao,
    this.exibirCirculoSituacao = true,
    this.corSituacao,
    this.corSituacaoFundo,
    this.corCirculo,
    this.fontSize,
    this.fontSizeComplemento,
    this.fontWeightComplemento,
    this.maxLinesComplemento = 1,
    this.fontSizePreco,
    this.statusMensagem,
    this.quantidadeMensagens,
    this.corIcone,
    this.corFundoIcone = const Color.fromARGB(255, 255, 242, 230),
    this.corComplemento,
    this.corTitulo,
    this.corPreco,
    this.formatoIcone = BoxShape.rectangle,
    this.onTap,
    this.precoEmDestaque = false,
    this.selecionado = false,
    this.exibirRadio = false,
    this.exibirCheck = false,
    this.onCheckChanged,
    this.exibirCheckVerde = false,
    this.exibirSeta = false,
    this.exibirSwitch = false,
    this.ativoInicial = false,
    this.onSwitchChanged,
    this.proximoRepasse,
    this.corRepasse,
    this.widget,
    this.layoutVertical = false,
    this.complementoAoLadoPreco = false,
    this.exibirTagEmCima = false,
    this.layoutAvaliacao = false,
  });

  @override
  Widget build(BuildContext context) {
    Color activeCorCirculo = corCirculo ?? Colors.transparent;
    Color activeCorSituacao = corSituacao ?? Colors.transparent;
    Color activeCorSituacaoFundo = corSituacaoFundo ?? Colors.transparent;

    if (situacao != null && corSituacao == null) {
      switch (situacao) {
        case 'Em preparo':
          activeCorCirculo = Colors.blue;
          activeCorSituacao = Colors.blue;
          activeCorSituacaoFundo = const Color.fromARGB(50, 33, 149, 243);
          break;
        case 'A caminho':
          activeCorCirculo = Colors.redAccent;
          activeCorSituacao = Colors.redAccent;
          activeCorSituacaoFundo = const Color.fromARGB(50, 255, 82, 82);
          break;
        case 'Entregue':
          activeCorCirculo = Colors.green;
          activeCorSituacao = Colors.green;
          activeCorSituacaoFundo = const Color.fromARGB(50, 76, 175, 79);
          break;
        case 'Confirmar':
          activeCorCirculo = Colors.orange;
          activeCorSituacao = Colors.orange;
          activeCorSituacaoFundo = const Color.fromARGB(50, 255, 153, 0);
          break;
        default:
          activeCorCirculo = const Color(0xFF5D201C);
          activeCorSituacao = corSituacao ?? const Color(0xFF5D201C);
          activeCorSituacaoFundo = corSituacaoFundo ?? const Color.fromARGB(255, 255, 231, 229);
          break;
      }
    }

    final String tituloExibicao = (codigo != null && informacao != null)
        ? '#$codigo · $informacao'
        : (informacao ?? '');

    String? subTituloExibicao = complementoAoLadoPreco ? null : complemento;
    if (quantidadeItens != null) {
      final String textoItens = '${quantidadeItens}x';
      final String? precoFormatado = (preco != null && !precoEmDestaque)
          ? 'R\$ ${preco!.toStringAsFixed(2).replaceAll('.', ',')}'
          : null;

      subTituloExibicao = [
        textoItens,
        ?precoFormatado,
        if (!complementoAoLadoPreco && complemento != null) complemento!,
      ].join(' · ');
    } else {
      subTituloExibicao ??= (complementoAoLadoPreco ? null : complemento);
    }

    final Color corDestaque = Colors.redAccent;
    Widget content;

    if (layoutVertical) {
      content = Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (preco != null) ...[
            SizedBox(height: 4.h),
            Text(
              'R\$ ${preco!.toStringAsFixed(2).replaceAll('.', ',')}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: (fontSizePreco ?? 14).sp,
              ),
            ),
          ],
          if (icon != null || letrasIcon != null) ...[
            Container(
              width: 48.w,
              height: 48.h,
              decoration: BoxDecoration(
                color: corFundoIcone,
                shape: formatoIcone,
                borderRadius: formatoIcone == BoxShape.rectangle
                    ? BorderRadius.circular(16.r)
                    : null,
              ),
              child: Center(
                child: icon != null
                    ? Icon(icon, color: corIcone ?? corDestaque, size: 24.sp)
                    : Text(
                        letrasIcon!,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.sp,
                          color: corIcone ?? const Color.fromARGB(255, 93, 32, 28),
                        ),
                      ),
              ),
            ),
            SizedBox(height: 8.h),
          ],
          if (tituloExibicao.isNotEmpty)
            Text(
              tituloExibicao,
              maxLines: 2,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: (fontSize ?? 14).sp,
                color: corTitulo ?? const Color.fromARGB(255, 93, 32, 28),
              ),
            ),
          if (subTituloExibicao != null) ...[
            SizedBox(height: 4.h),
            Text(
              subTituloExibicao,
              maxLines: maxLinesComplemento,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: (fontSizeComplemento ?? 12).sp,
                fontWeight: fontWeightComplemento ?? FontWeight.w400,
                color: corComplemento ?? Colors.grey[600],
              ),
            ),
          ],
        ],
      );
    } else {
      content = Row(
        crossAxisAlignment: layoutAvaliacao ? CrossAxisAlignment.start : CrossAxisAlignment.center,
        children: [
          if (exibirCheckVerde) ...[
            Icon(
              Icons.check,
              color: Colors.green,
              size: 18.sp,
            ),
            SizedBox(width: 12.w),
          ],

          if (exibirCheck) ...[
            GestureDetector(
              onTap: () {
                if (onCheckChanged != null) {
                  onCheckChanged!(!selecionado);
                }
              },
              child: Container(
                width: 26.r,
                height: 26.r,
                decoration: BoxDecoration(
                  color: selecionado
                      ? const Color(0xFFFF6961)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border.all(
                    color: selecionado
                        ? Colors.transparent
                        : Colors.grey.shade300,
                    width: 2,
                  ),
                ),
                child: selecionado
                    ? Icon(
                        Icons.check_rounded,
                        color: Colors.white,
                        size: 18.sp,
                      )
                    : null,
              ),
            ),
            SizedBox(width: 12.w),
          ],

          if (situacao != null && exibirCirculoSituacao && !exibirTagEmCima) ...[
            Icon(Icons.circle, size: 14.sp, color: activeCorCirculo),
            SizedBox(width: 12.w),
          ],

          if (icon != null || letrasIcon != null) ...[
            Container(
              width: 48.r,
              height: 48.r,
              decoration: BoxDecoration(
                color: corFundoIcone,
                shape: formatoIcone,
                borderRadius: formatoIcone == BoxShape.rectangle
                    ? BorderRadius.circular(16.r)
                    : null,
              ),
              child: Center(
                child: icon != null
                    ? Icon(icon, color: corIcone ?? corDestaque, size: 24.sp)
                    : Text(
                        letrasIcon!,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.sp,
                          color: corIcone ?? const Color.fromARGB(255, 93, 32, 28),
                        ),
                      ),
              ),
            ),
            SizedBox(width: 12.w),
          ],

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (situacao != null && exibirTagEmCima) ...[
                  Container(
                    padding: EdgeInsets.symmetric(
                      vertical: 8.h,
                      horizontal: 16.w,
                    ),
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 255, 242, 230),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Text(
                      situacao!,
                      style: TextStyle(
                        color: activeCorSituacao,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 6.h),
                ],

                if (tituloExibicao.isNotEmpty)
                  Text(
                    tituloExibicao,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: (fontSize ?? 16).sp,
                      color: corTitulo ?? const Color.fromARGB(255, 93, 32, 28),
                    ),
                  ),
                if (subTituloExibicao != null) ...[
                  SizedBox(height: 2.h),
                  Text(
                    subTituloExibicao,
                    maxLines: maxLinesComplemento,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: (fontSizeComplemento ?? 13).sp,
                      fontWeight: fontWeightComplemento ?? FontWeight.w400,
                      color: corComplemento ?? Colors.grey[600],
                    ),
                  ),
                ],
                if (widget != null) ...[
                  SizedBox(height: 12.h),
                  widget!,
                  SizedBox(height: 4.h),
                ],
                if (proximoRepasse != null) ...[
                  SizedBox(height: 4.h),
                  Text(
                    'Próximo repasse: ${proximoRepasse!}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      color: corRepasse ?? Colors.grey[500],
                    ),
                  ),
                ],
              ],
            ),
          ),

          if (horario != null ||
              (preco != null && (precoEmDestaque || quantidadeItens == null)) ||
              (situacao != null && !exibirTagEmCima) ||
              statusMensagem != null ||
              (complementoAoLadoPreco && complemento != null))
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (horario != null)
                  Text(
                    horario!,
                    style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                      fontSize: 12.sp,
                    ),
                  ),

                if ((preco != null &&
                        situacao == null &&
                        (precoEmDestaque || quantidadeItens == null)) ||
                    (complementoAoLadoPreco && complemento != null))
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      if (preco != null &&
                          situacao == null &&
                          (precoEmDestaque || quantidadeItens == null))
                        Text(
                          'R\$ ${preco!.toStringAsFixed(2).replaceAll('.', ',')}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: (fontSizePreco ?? 14).sp,
                            color: corPreco,
                          ),
                        ),
                      if (complementoAoLadoPreco && complemento != null) ...[
                        if (preco != null) SizedBox(width: 4.w),
                        Text(
                          complemento!,
                          maxLines: maxLinesComplemento,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: (fontSizeComplemento ?? 13).sp,
                            fontWeight:
                                fontWeightComplemento ?? FontWeight.w400,
                            color: corComplemento ?? Colors.grey[600],
                          ),
                        ),
                      ],
                    ],
                  ),

                if (horario != null ||
                    preco != null ||
                    (complementoAoLadoPreco && complemento != null))
                  SizedBox(height: 4.h),

                if (situacao != null && !exibirTagEmCima)
                  Container(
                    padding: EdgeInsets.symmetric(
                      vertical: 6.h,
                      horizontal: 14.w,
                    ),
                    decoration: BoxDecoration(
                      color: activeCorSituacaoFundo,
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    child: Text(
                      situacao!,
                      style: TextStyle(
                        color: activeCorSituacao,
                        fontSize: 13.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                if (statusMensagem != null) _buildStatusChat(),
              ],
            ),

          if (exibirRadio) ...[
            SizedBox(width: 12.w),
            Icon(
              selecionado
                  ? Icons.radio_button_checked_rounded
                  : Icons.radio_button_off_rounded,
              color: selecionado ? corDestaque : Colors.grey[300],
              size: 24.sp,
            ),
          ],

          if (exibirSwitch) ...[
            SizedBox(width: 8.w),
            Transform.scale(
              scale: 0.85,
              child: Switch(
                value: ativoInicial,
                activeThumbColor: Colors.white,
                activeTrackColor: const Color(0xFFFF6961),
                inactiveThumbColor: Colors.white,
                inactiveTrackColor: Colors.grey.shade300,
                trackOutlineColor: WidgetStateProperty.all(Colors.transparent),
                onChanged: onSwitchChanged,
              ),
            ),
          ],
          if (exibirSeta) ...[
            SizedBox(width: 8.w),
            Icon(
              Icons.arrow_forward_ios_outlined,
              color: Colors.grey,
              size: 12.sp,
            ),
          ],
        ],
      );
    }

    final VoidCallback? handleTap =
        onTap ??
        (onCheckChanged != null ? () => onCheckChanged!(!selecionado) : null);

    if (handleTap != null) {
      return InkWell(onTap: handleTap, child: content);
    }

    return content;
  }

  Widget _buildStatusChat() {
    switch (statusMensagem!) {
      case StatusMensagem.naoLida:
        return Container(
          padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 8.w),
          decoration: const BoxDecoration(
            color: Colors.redAccent,
            shape: BoxShape.circle,
          ),
          child: Text(
            '${quantidadeMensagens ?? 0}',
            style: TextStyle(
              color: Colors.white,
              fontSize: 10.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        );
      case StatusMensagem.enviada:
        return Icon(
          Icons.done_all_rounded,
          color: Colors.redAccent,
          size: 18.sp,
        );
      case StatusMensagem.visualizada:
        return SizedBox(height: 18.h);
    }
  }
}