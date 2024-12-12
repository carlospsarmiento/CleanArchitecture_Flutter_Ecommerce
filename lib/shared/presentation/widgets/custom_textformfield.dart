import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String? hintText;
  final EdgeInsetsGeometry contentPadding;
  final BorderRadius borderRadius;
  final Color? focusedBorderColor;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onChanged;
  final bool obscureText;

  const CustomTextFormField({
    super.key,
    required this.controller,
    this.hintText,
    this.contentPadding = const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    this.borderRadius = const BorderRadius.all(Radius.circular(24)),
    this.focusedBorderColor,
    this.validator,
    this.onChanged,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: hintText,
        contentPadding: contentPadding,
        border: OutlineInputBorder(
          borderRadius: borderRadius,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: borderRadius,
          borderSide: BorderSide(
            color: focusedBorderColor ?? Theme.of(context).colorScheme.primary,
          ),
        ),
      ),
      onChanged: onChanged,
      validator: validator,
    );
  }
}