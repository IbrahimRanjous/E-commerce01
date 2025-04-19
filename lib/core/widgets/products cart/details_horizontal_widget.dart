import 'package:flutter/material.dart';
import '../../utils/constants/sizes.dart';
import '../brand_widget.dart';
import '../text/product_price_text.dart';
import '../text/product_title_text.dart';
import 'add_to_card_button.dart';
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
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /////// -- product title -- ///////
            TProductTitleText(
              title: productTitle,
              maxLines: 1,
            ),

            const SizedBox(height: 4),
            /////// -- brand and verified check icon-- ///////
            TBrandWidget(brand: brand, isVerified: isVerified),
            const SizedBox(height: 8),
            /////// -- Price Row -- ///////
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Display the price range.
                TProductPriceText(price: priceRange),

                const SizedBox(width: TSizes.xs),
                if (quantity.isEmpty)

                  /// Add to Cart Button
                  const TAddToCardButton(),

                // Display the quantity indicator if provided.
                if (quantity.isNotEmpty) TQuantityItems(quantity: quantity),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
