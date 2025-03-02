import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String hintText;
  final String? Function(String?)? validator;
  final AutovalidateMode autovalidateMode;

  const CustomTextFormField({
    super.key,
    required this.controller,
    required this.labelText,
    this.validator,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: autovalidateMode,
      controller: controller,
      validator: validator,

      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(
          vertical: 15.0,
          horizontal: 20.0,
        ),
        labelText: labelText,
        hintText: hintText,
        labelStyle: const TextStyle(color: Colors.black),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(100.0), // Rounded corners
        ),
      ),
    );
  }
}
