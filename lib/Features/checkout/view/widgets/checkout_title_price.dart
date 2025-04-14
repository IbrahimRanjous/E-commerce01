import 'package:flutter/material.dart';

class TCheckoutTitlePrice extends StatelessWidget {
  const TCheckoutTitlePrice({
    super.key,
    required this.title,
    required this.price,
    this.style,
  });

  final String title;
  final double price;
  final TextStyle? style;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: style ?? Theme.of(context).textTheme.bodyMedium,
        ),
        Text(
          '\$$price',
          style: style ?? Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }
}
