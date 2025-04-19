import 'package:flutter/material.dart';

import '../../utils/constants/sizes.dart';
import '../text/my_text.dart';

class TQuantityItems extends StatelessWidget {
  const TQuantityItems({
    super.key,
    required this.quantity,
  });

  final String quantity;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(TSizes.cardRadiusSm),
        ),
        child: MyText(
          text: quantity,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
