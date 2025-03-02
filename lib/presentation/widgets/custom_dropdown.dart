import 'package:flutter/material.dart';

class CustomDropdownFormField extends StatelessWidget {
  final String labelText;
  final String? Function(String?)? validator;
  final void Function(String?)? onChanged;
  final String? value;
  final List<DropdownMenuItem<String>>? dropdownItems;

  const CustomDropdownFormField({
    super.key,
    required this.labelText,
    this.validator,
    this.onChanged,
    this.value,
    this.dropdownItems,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: value,
      onChanged: onChanged,
      validator: validator,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(
          vertical: 15.0,
          horizontal: 20.0,
        ),
        labelText: labelText,
        labelStyle: const TextStyle(color: Colors.black),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(100.0), // Rounded corners
        ),
      ),
      items: dropdownItems ?? [], // Replace with your dropdown items
    );
  }
}
