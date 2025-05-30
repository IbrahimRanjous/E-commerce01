import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../utils/constants/colors.dart';
import '../utils/constants/sizes.dart';
import 'text/my_text.dart';

class TBrandWidget extends StatelessWidget {
  const TBrandWidget({
    super.key,
    required this.brand,
    this.isVerified = false,
  });

  final String brand;
  final bool isVerified;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          flex: 0,
          child: MyText(
            text: brand,
            color: TColors.darkGrey,
          ),
        ),
        if (isVerified) ...[
          const SizedBox(width: 4),
          const FittedBox(
            child: Icon(
              Iconsax.verify5,
              color: Colors.blue,
              size: TSizes.iconSm,
            ),
          ),
        ] else
          ...[],
      ],
    );
  }
}
