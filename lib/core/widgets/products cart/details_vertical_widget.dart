import 'package:flutter/material.dart';
import 'package:rjs_store/core/widgets/text/product_price_text.dart';
import '../../utils/constants/sizes.dart';
import '../brand_widget.dart';
import 'add_to_card_button.dart';
import 'quantity_items.dart';

class DetailsVerticalWidget extends StatelessWidget {
  const DetailsVerticalWidget({
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
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /////// -- product title -- ///////
          Text(
            productTitle,
            style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: TSizes.fontSizeSm,
                overflow: TextOverflow.ellipsis),
          ),

          const SizedBox(height: 4),
          /////// -- brand and verified check icon-- ///////
          TBrandWidget(brand: brand, isVerified: isVerified),
          const SizedBox(height: 8),

          /////// -- Price Row -- ///////
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              // Display the price range.
              Flexible(child: TProductPriceText(price: priceRange)),
              const SizedBox(width: TSizes.xs),
              if (quantity.isEmpty)

                /// Add to Cart Button
                const TAddToCardButton(),

              // Display the quantity indicator if provided.
              if (quantity.isNotEmpty) TQuantityItems(quantity: quantity),
            ],
          )
        ],
      ),
    );
  }
}
