import 'package:flutter/material.dart';
import 'package:rjs_store/core/utils/constants/colors.dart';

class CustomMaterialButton extends StatelessWidget {
  const CustomMaterialButton({
    super.key,
    required this.text,
    required this.onPressed,
  });
  final String text;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      height: 50,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      minWidth: double.maxFinite,
      color: TColors.buttonPrimary,
      textColor: Colors.white,
      child: Text(
        text,
        style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 17),
      ),
    );
  }
}
