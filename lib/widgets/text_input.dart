import 'package:flutter/material.dart';

class CustomTextInput extends StatelessWidget {
  final TextEditingController controller;
  final int maxLines;
  final String hintText;
  final TextInputType keyboardType;
  final String? Function(String?) onSaved;
  final String? Function(String?) validator;
  final bool obscureText;
  final IconData icon;
  final bool prefixIcon;
  //
  const CustomTextInput({
    super.key,
    required this.controller,
    this.maxLines = 1,
    required this.hintText,
    required this.keyboardType,
    required this.onSaved,
    required this.validator,
    this.obscureText = false,
    this.icon = Icons.person,
    this.prefixIcon = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.multiline,
      obscureText: obscureText,
      maxLines: maxLines,
      decoration: InputDecoration(
        hintText: hintText,
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            width: 1,
          ),
        ),
        border: const OutlineInputBorder(
          borderSide: BorderSide(
            width: 1,
          ),
        ),
        prefixIcon: prefixIcon
            ? Icon(
                icon,
                color: Colors.pinkAccent.withOpacity(0.4),
              )
            : null,
      ),
      controller: controller,
      onSaved: onSaved,
      validator: validator,
    );
  }
}
