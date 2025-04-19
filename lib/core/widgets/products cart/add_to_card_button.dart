import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../utils/constants/colors.dart';
import '../../utils/constants/sizes.dart';

class TAddToCardButton extends StatelessWidget {
  const TAddToCardButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        decoration: const BoxDecoration(
          color: TColors.dark,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(TSizes.cardRadiusMd),
            bottomRight: Radius.circular(TSizes.productImageRadius),
          ), // BorderRadius.only
        ), // BoxDecoration
        child: const SizedBox(
          width: TSizes.iconLg,
          height: TSizes.iconLg,
          child: Center(child: Icon(Iconsax.add, color: TColors.white)),
        ),
      ),
    );
  }
}
