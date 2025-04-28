import 'package:flutter/material.dart';

class CustomTextForm extends StatelessWidget {
  final Icon prefixicon;
  final String hintText;
  final TextEditingController? controller;
  final String? Function(String?)? validator;

  const CustomTextForm({
    super.key,
    required this.prefixicon,
    required this.hintText,
    this.controller,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      autocorrect: true,
      expands: false,
      decoration: InputDecoration(
          prefixIcon: prefixicon,
          hintText: hintText,
          hintStyle: Theme.of(context).textTheme.titleSmall),
    );
  }
}
