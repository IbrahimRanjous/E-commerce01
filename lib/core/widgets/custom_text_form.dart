import 'package:flutter/material.dart';

class CustomTextForm extends StatelessWidget {
  final Icon prefixicon;
  final String hintText;

  const CustomTextForm({
    super.key,
    required this.prefixicon,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autocorrect: true,
      expands: false,
      decoration: InputDecoration(
          prefixIcon: prefixicon,
          hintText: hintText,
          hintStyle: Theme.of(context).textTheme.titleSmall),
    );
  }
}
