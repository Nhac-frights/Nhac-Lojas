import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/services.dart';

class NhacInputField extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final bool obscureText;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final List<TextInputFormatter>? inputFormatters;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final FocusNode? focusNode;
  final String? errorText;
  final TextCapitalization textCapitalization;
  final TextInputAction? textInputAction;
  final void Function(String)? onFieldSubmitted;
  final bool autofocus;
  final bool enabled;
  final String obscuringCharacter;
  final TextStyle? style;
  final bool readOnly;
  final VoidCallback? onTap;
  final int? maxLines; // Permite definir o número máximo de linhas
  final int? minLines; // Permite definir o número mínimo de linhas

  const NhacInputField({
    super.key,
    this.controller,
    this.hintText,
    this.obscureText = false,
    this.keyboardType,
    this.validator,
    this.onChanged,
    this.inputFormatters,
    this.prefixIcon,
    this.suffixIcon,
    this.focusNode,
    this.errorText,
    this.textCapitalization = TextCapitalization.none,
    this.textInputAction,
    this.onFieldSubmitted,
    this.autofocus = false,
    this.enabled = true,
    this.obscuringCharacter = '•',
    this.style,
    this.readOnly = false,
    this.onTap,
    this.maxLines = 1, // Por padrão continua sendo linha única
    this.minLines,
  });

  @override
  Widget build(BuildContext context) {
    const Color primaryColor = Color(0xFF5D201C);
    const Color hintColor = Color(0xFFC9BCBC);
    const Color cursorColor = Color(0xFFFF6961);

    final radius = (maxLines != null && maxLines! > 1) ? 16.r : 50.r;

    final borderStyle = OutlineInputBorder(
      borderRadius: BorderRadius.circular(radius),
      borderSide: const BorderSide(
        color: primaryColor,
        width: 1.0,
      ),
    );

    final focusedBorderStyle = OutlineInputBorder(
      borderRadius: BorderRadius.circular(radius),
      borderSide: const BorderSide(
        color: primaryColor,
        width: 2.0,
      ),
    );

    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      obscuringCharacter: obscuringCharacter,
      keyboardType: keyboardType,
      validator: validator,
      onChanged: onChanged,
      inputFormatters: inputFormatters,
      focusNode: focusNode,
      textCapitalization: textCapitalization,
      textInputAction: textInputAction,
      onFieldSubmitted: onFieldSubmitted,
      autofocus: autofocus,
      enabled: enabled,
      cursorColor: cursorColor,
      readOnly: readOnly,
      onTap: onTap,
      maxLines: maxLines,
      minLines: minLines,
      style: style ??
          TextStyle(
            color: primaryColor,
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w600,
          ),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(
          color: hintColor,
          fontWeight: FontWeight.w400,
        ),
        errorText: errorText,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        contentPadding: EdgeInsets.symmetric(
          horizontal: 24.w,
          vertical: 16.h,
        ),
        filled: false,
        border: borderStyle,
        enabledBorder: borderStyle,
        focusedBorder: focusedBorderStyle,
        errorBorder: borderStyle.copyWith(
          borderSide: const BorderSide(color: Colors.red, width: 1.0),
        ),
        focusedErrorBorder: focusedBorderStyle.copyWith(
          borderSide: const BorderSide(color: Colors.red, width: 2.0),
        ),
      ),
    );
  }
}