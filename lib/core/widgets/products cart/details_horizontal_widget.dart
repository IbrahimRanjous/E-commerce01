// details_horizontal_widget.dart
import 'package:flutter/material.dart';
import '../../utils/constants/sizes.dart';
import '../brand_widget.dart';
import '../text/product_price_text.dart';
import '../text/product_title_text.dart';
import 'quantity_items.dart';

class DetailsHorizontalWidget extends StatelessWidget {
  const DetailsHorizontalWidget({
    super.key,
    required this.productTitle,
    required this.brand,
    required this.isVerified,
    required this.priceRange,
    required this.quantity,
  });

  final String productTitle;
  final String brand;
  final bool isVerified;
  final String priceRange;
  final String quantity;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      // Note: This Expanded is valid if DetailsHorizontalWidget is a direct child of a Row.
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Title
            TProductTitleText(
              title: productTitle,
              maxLines: 1,
            ),
            const SizedBox(height: 4),
            // Brand with verified icon
            TBrandWidget(brand: brand, isVerified: isVerified),
            const SizedBox(height: 8),
            // Price and quantity row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(child: TProductPriceText(price: priceRange)),
                const SizedBox(width: TSizes.xs),
                if (quantity.isNotEmpty) TQuantityItems(quantity: quantity),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
