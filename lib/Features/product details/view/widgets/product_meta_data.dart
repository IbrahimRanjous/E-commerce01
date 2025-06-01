import 'package:flutter/material.dart';
import 'package:rjs_store/core/widgets/text/product_price_text.dart';
import 'package:rjs_store/core/widgets/text/product_title_text.dart';
import 'package:rjs_store/core/utils/constants/colors.dart';
import 'package:rjs_store/core/utils/constants/enums.dart';
import 'package:rjs_store/core/utils/constants/image_strings.dart';
import 'package:rjs_store/core/utils/constants/sizes.dart';
import 'package:rjs_store/core/utils/helpers/helper_functions.dart';
import 'package:rjs_store/core/widgets/custom%20shapes/rounded_container.dart';
import 'package:rjs_store/core/widgets/images/t_rounded_image.dart';
import 'package:rjs_store/core/widgets/text/brand_title_with_verified_icon.dart';

class TProductMetaData extends StatelessWidget {
  const TProductMetaData(
      {super.key,
      required this.productTitle,
      required this.brand,
      required this.isVerified,
      required this.price,
      required this.quantity,
      required this.status,
      required this.discount});

  /// Discount text, for example "78%" or an empty string if not applicable.
  final int discount;

  /// The title of the product.
  final String productTitle;

  /// The brand of the product.
  final String brand;

  /// Whether the brand is verified.
  final bool isVerified;

  /// The price for the product.
  final String price;

  /// The quantity indicator (could show available stock, etc.)
  final String quantity;

  final bool status;

  @override
  Widget build(BuildContext context) {
    final darkMode = THelperFunctions.isDarkMode(context);
    final cleanedPrice = price.replaceAll(RegExp(r'[^0-9.]'), '');
    final originalPrice = double.parse(cleanedPrice);
    final discountedPrice = originalPrice - (originalPrice * discount / 100);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Price & Sale price
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            /// Sale Tap
            if (discount != 0)
              TRoundedContainer(
                borderRadius: TSizes.sm,
                backgroundColor: TColors.secondary.withValues(alpha: 0.8),
                padding: const EdgeInsets.symmetric(
                    horizontal: TSizes.sm, vertical: TSizes.xs),
                showBorder: true,
                child: Text(
                  '$discount %',
                  style: Theme.of(context)
                      .textTheme
                      .labelLarge!
                      .apply(color: TColors.black),
                ),
              ),
            if (discount != 0) const SizedBox(width: TSizes.spaceBtwItems),

            /// Price
            if (discount != 0)
              TProductPriceText(
                price: originalPrice.toString(),
                lineThrough: true,
              ),
            if (discount != 0) const SizedBox(width: TSizes.spaceBtwItems),

            /// The Final price
            TProductPriceText(price: discountedPrice.toString(), isLarge: true),
          ],
        ),
        const SizedBox(width: TSizes.spaceBtwItems / 2),

        /// Title
        TProductTitleText(title: productTitle),
        const SizedBox(width: TSizes.spaceBtwItems / 1.5),

        /// Stock Status
        Row(
          children: [
            const TProductTitleText(title: 'Status'),
            const SizedBox(width: TSizes.spaceBtwItems),
            Text(
              status ? 'In Stock' : 'Out Of Stock',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),
        const SizedBox(width: TSizes.spaceBtwItems / 1.5),

        /// Brand
        Row(
          children: [
            TRoundedImage(
              url: TImages.shoeIcon,
              isNetworkImage: false,
              imageWidth: 32,
              imageHeight: 32,
              overLayColor: darkMode ? TColors.white : TColors.black,
            ),
            TBrandTitleWithVerifiedIcon(
              title: brand,
              isVerified: isVerified,
              brandTextSize: TextSizes.medium,
            ),
          ],
        ),
      ],
    );
  }
}
