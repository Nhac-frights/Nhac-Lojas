import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ListaFilterTags extends StatefulWidget {
  final List<String> filtros;
  final List<int?>? quantidades;
  final List<IconData?>? icones;
  final ValueChanged<String>? onSelected;
  final int? initialIndex;
  final Color? borderColor;
  final Color? textColor;
  final Color? selectedBorderColor;
  final Color? selectedTextColor;
  final Color? selectedBackgroundColor;
  final Color? iconColor;

  const ListaFilterTags({
    required this.filtros,
    this.quantidades,
    this.icones,
    this.onSelected,
    this.initialIndex,
    this.borderColor,
    this.textColor,
    this.selectedBorderColor,
    this.selectedTextColor,
    this.selectedBackgroundColor,
    this.iconColor,
    super.key,
  });

  @override
  State<ListaFilterTags> createState() => _ListaFilterTagsState();
}

class _ListaFilterTagsState extends State<ListaFilterTags> {
  late int? _indiceSelecionado;

  @override
  void initState() {
    super.initState();
    _indiceSelecionado = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    const Color corTema = Color(0xFFFF6961);

    return SizedBox(
      height: 44.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        itemCount: widget.filtros.length,
        separatorBuilder: (_, _) => SizedBox(width: 8.w),
        itemBuilder: (context, index) {
          final filtroAtual = widget.filtros[index];
          final qtdAtual = (widget.quantidades != null && widget.quantidades!.length > index)
              ? widget.quantidades![index]
              : null;
          final iconeAtual = (widget.icones != null && widget.icones!.length > index)
              ? widget.icones![index]
              : null;
          
          final bool isSelected = _indiceSelecionado == index;

          final effectiveBgColor = isSelected
              ? (widget.selectedBackgroundColor ?? corTema.withValues(alpha: 0.1))
              : const Color.fromARGB(255, 255, 231, 229);

          final effectiveBorderColor = isSelected
              ? (widget.selectedBorderColor ?? widget.borderColor ?? Colors.black)
              : (widget.borderColor ?? Colors.black);

          final effectiveColor = isSelected
              ? (widget.selectedTextColor ?? widget.textColor ?? Colors.black)
              : (widget.textColor ?? Colors.black);

          // Cor fixa dos ícones para Red Accent
          //final Color iconColor = Colors.redAccent;

          return GestureDetector(
            onTap: () {
              setState(() {
                _indiceSelecionado = isSelected ? null : index;
              });
              if (widget.onSelected != null) {
                widget.onSelected!(_indiceSelecionado != null ? filtroAtual : '');
              }
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: effectiveBgColor,
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(
                  color: effectiveBorderColor,
                  width: 1.2.w,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (iconeAtual != null) ...[
                    Icon(
                      iconeAtual,
                      color: widget.iconColor ?? Colors.redAccent, // Ícone atualizado para redAccent
                      size: 18.r,
                    ),
                    SizedBox(width: 8.w),
                  ],
                  Text(
                    filtroAtual,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: effectiveColor,
                    ),
                  ),
                    if (qtdAtual != null)
                      Text(
                        ' · $qtdAtual',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: effectiveColor,
                        ),
                      ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}