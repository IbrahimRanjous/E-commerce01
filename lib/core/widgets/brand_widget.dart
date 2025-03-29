import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../utils/constants/colors.dart';
import '../utils/constants/sizes.dart';
import 'text/my_text.dart';

class BrandWidget extends StatelessWidget {
  const BrandWidget({
    super.key,
    required this.brand,
    this.isVerified = false,
  });

  final String brand;
  final bool isVerified;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        MyText(
          text: brand,
          color: TColors.darkGrey,
        ),
        if (isVerified) ...[
          const SizedBox(width: 4),
          const Icon(
            Iconsax.verify5,
            color: Colors.blue,
            size: TSizes.iconSm,
          ),
        ] else
          ...[],
      ],
    );
  }
}
