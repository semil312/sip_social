// ignore_for_file: must_be_immutable, prefer_if_null_operators

import 'package:flutter/material.dart';
import 'package:sip_social/main.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final int? maxLength;
  final int? maxLines;
  final Widget? prefix;
  final Widget? prefixIcon;
  final TextInputType? keyboardType;
  final EdgeInsetsGeometry? contentPadding;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final void Function()? onTap;

  const CustomTextField({
    Key? key,
    required this.controller,
    this.validator,
    this.prefix,
    this.prefixIcon,
    this.onChanged,
    this.keyboardType,
    this.maxLength,
    this.maxLines = 1,
    this.contentPadding,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            controller: controller,
            validator: validator,
            onChanged: onChanged,
            onTap: onTap,
            keyboardType: keyboardType ?? TextInputType.text,
            cursorColor: $styles.colors.black,
            cursorHeight: 22,
            maxLength: maxLength,
            maxLines: maxLines,
            decoration: InputDecoration(
              filled: true,
              fillColor: $styles.colors.white,
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: BorderSide(
                  color: $styles.colors.error,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: BorderSide(
                  color: $styles.colors.black,
                ),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: BorderSide(
                  color: $styles.colors.black,
                ),
              ),
              prefix: prefix == null ? null : prefix,
              prefixIcon: prefixIcon == null ? null : prefixIcon,
              contentPadding: contentPadding,
            ),
          ),
        ),
      ],
    );
  }
}
