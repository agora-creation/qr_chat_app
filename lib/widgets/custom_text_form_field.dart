import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController? controller;
  final bool? obscureText;
  final TextInputType? keyboardType;
  final String? labelText;
  final IconData? iconData;

  const CustomTextFormField({
    this.controller,
    this.obscureText,
    this.keyboardType,
    this.labelText,
    this.iconData,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText ?? false,
      keyboardType: keyboardType,
      maxLines: 1,
      style: const TextStyle(
        color: Color(0xFF333333),
        fontSize: 14,
      ),
      cursorColor: const Color(0xFFE0E0E0),
      decoration: InputDecoration(
        labelText: labelText,
        fillColor: const Color(0xFFE0E0E0),
        prefixIcon: iconData != null
            ? Icon(
                iconData,
                size: 18,
                color: const Color(0xFF333333),
              )
            : null,
        filled: true,
        enabledBorder: UnderlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        labelStyle: const TextStyle(color: Color(0xFF333333)),
        focusColor: const Color(0xFF333333),
      ),
    );
  }
}
