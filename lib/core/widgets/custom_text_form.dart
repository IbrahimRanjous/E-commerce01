import 'package:flutter/material.dart';

class CustomTextForm extends StatelessWidget {
  final Icon prefixicon;
  final String hintText;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  const CustomTextForm({
    super.key,
    required this.prefixicon,
    required this.hintText,
    this.validator,
    this.controller,
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
