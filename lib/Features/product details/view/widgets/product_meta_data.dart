import 'package:flutter/material.dart';
import 'package:rjs_store/Features/product%20details/view/widgets/product_price_text.dart';
import 'package:rjs_store/core/utils/constants/colors.dart';
import 'package:rjs_store/core/utils/constants/sizes.dart';
import 'package:rjs_store/core/utils/helpers/helper_functions.dart';
import 'package:rjs_store/core/widgets/custom%20shapes/rounded_container.dart';
import 'package:rjs_store/core/widgets/text/my_text.dart';

class TProductMetaData extends StatelessWidget {
  const TProductMetaData({super.key});

  @override
  Widget build(BuildContext context) {
    final darkMode = THelperFunctions.isDarkMode(context);
    return Column(
      children: [
        /// Price & Sale price
        Row(
          children: [
            /// Sale Tap
            TRoundedContainer(
              borderRadius: TSizes.sm,
              backgroundColor: TColors.secondary.withOpacity(0.8),
              padding: const EdgeInsets.symmetric(
                  horizontal: TSizes.sm, vertical: TSizes.xs),
              showBorder: true,
              child: Text(
                '25%',
                style: Theme.of(context)
                    .textTheme
                    .labelLarge!
                    .apply(color: TColors.black),
              ),
            ),
            const SizedBox(width: TSizes.spaceBtwItems),

            /// Price
            const TProductPriceText(price: '250', lineThrough: true),
            const SizedBox(width: TSizes.spaceBtwItems),

            const TProductPriceText(price: '175', isLarge: true),
          ],
        ),

        /// Title
        /// Stock Status
        /// Brand
      ],
    );
  }
}
