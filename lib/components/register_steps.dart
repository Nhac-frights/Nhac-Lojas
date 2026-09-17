import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum PassoCadastrar { dados, endereco, entrega, horarios, pagamento, revisar }

class RegisterSteps extends StatelessWidget {
  final PassoCadastrar passoAtual;

  const RegisterSteps({super.key, required this.passoAtual});

  static const List<_StepData> _etapasPadrao = [
    _StepData(status: PassoCadastrar.dados, titulo: 'Dados', icon: Icons.badge),
    _StepData(status: PassoCadastrar.endereco, titulo: 'Endereço', icon: Icons.location_on_outlined),
    _StepData(status: PassoCadastrar.entrega, titulo: 'Entrega', icon: Icons.motorcycle_outlined),
    _StepData(status: PassoCadastrar.horarios, titulo: 'Horários', icon: Icons.access_time),
    _StepData(status: PassoCadastrar.pagamento, titulo: 'Pagamento', icon: Icons.credit_card),
    _StepData(status: PassoCadastrar.revisar, titulo: 'Revisar', icon: Icons.check_box_outlined),
  ];

  @override
  Widget build(BuildContext context) {
    final int indexAtual = passoAtual.index;

    return Row(
      children: List.generate(_etapasPadrao.length, (index) {
        final etapa = _etapasPadrao[index];
        final bool isCompleted = index < indexAtual;
        final bool isCurrent = index == indexAtual;
        final bool isFirst = index == 0;
        final bool isLast = index == _etapasPadrao.length - 1;

        return Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Linha do topo: conector esquerdo + bolinha + conector direito
              Row(
                children: [
                  // Linha conectora da esquerda
                  Expanded(
                    child: Container(
                      height: 2.h,
                      color: isFirst
                          ? Colors.transparent
                          : (index <= indexAtual
                              ? const Color(0xFFFF6961)
                              : const Color(0xFFE0E0E0)),
                    ),
                  ),
                  // Círculo/Ícone central
                  _buildStatusIcon(
                    isCompleted: isCompleted,
                    isCurrent: isCurrent,
                    icon: etapa.icon,
                  ),
                  // Linha conectora da direita
                  Expanded(
                    child: Container(
                      height: 2.h,
                      color: isLast
                          ? Colors.transparent
                          : (isCompleted
                              ? const Color(0xFFFF6961)
                              : const Color(0xFFE0E0E0)),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 6.h),
              // Texto da etapa abaixo da bolinha
              Text(
                etapa.titulo,
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontWeight: isCurrent ? FontWeight.bold : FontWeight.w500,
                  fontSize: 11.sp,
                  color: isCurrent || isCompleted
                      ? const Color(0xFFFF6961)
                      : const Color(0xFF9E9E9E),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildStatusIcon({
    required bool isCompleted,
    required bool isCurrent,
    required IconData icon,
  }) {
    if (isCompleted) {
      return Container(
        width: 28.r,
        height: 28.r,
        decoration: const BoxDecoration(
          color: Colors.redAccent,
          shape: BoxShape.circle,
        ),
        child: Icon(Icons.check, size: 16.sp, color: Colors.white),
      );
    } else if (isCurrent) {
      return Container(
        width: 36.r,
        height: 36.r,
        decoration: const BoxDecoration(
          color: Colors.redAccent,
          shape: BoxShape.circle,
        ),
        child: Icon(icon, size: 18.sp, color: Colors.white),
      );
    } else {
      return Container(
        width: 28.r,
        height: 28.r,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          border: Border.all(color: const Color(0xFFE0E0E0), width: 1.5.w),
        ),
        child: Icon(icon, size: 14.sp, color: const Color(0xFF9E9E9E)),
      );
    }
  }
}

class _StepData {
  final PassoCadastrar status;
  final String titulo;
  final IconData icon;

  const _StepData({
    required this.status,
    required this.titulo,
    required this.icon,
  });
}