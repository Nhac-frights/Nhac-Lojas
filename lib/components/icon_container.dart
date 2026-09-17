import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class IconContainer extends StatelessWidget {
  final IconData icon;

  const IconContainer({required this.icon, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40.r,
      height: 40.r,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.6),
        shape: BoxShape.circle,
      ),
      child: Icon(
        icon,
        color: const Color(0xFF5D201C),
        size: 20.sp,
      ),
    );
  }
}