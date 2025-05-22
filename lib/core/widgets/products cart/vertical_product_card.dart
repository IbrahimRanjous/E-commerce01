import 'package:flutter/material.dart';
import 'package:rjs_store/core/utils/helpers/helper_functions.dart';
import 'details_vertical_widget.dart';
import 'thumbnail.dart';

class TVerticalProductCard extends StatelessWidget {
  /// URL for the product image.
  final String imageUrl;

  /// Discount text, for example "78%" or an empty string if not applicable.
  final String discountText;

  /// Whether the product is currently favorited.
  final bool isFavorite;

  /// Callback when the favorite icon is tapped.
  final VoidCallback? onFavoriteTap;

  /// The title of the product.
  final String productTitle;

  /// The brand of the product.
  final String brand;

  /// Whether the brand is verified.
  final bool isVerified;

  /// The price range for the product.
  final String priceRange;

  /// The quantity indicator (could show available stock, etc.)
  final String quantity;

  /// Creates a reusable product card widget.
  const TVerticalProductCard({
    super.key,
    required this.imageUrl,
    this.discountText = '',
    this.isFavorite = false,
    this.onFavoriteTap,
    required this.productTitle,
    required this.brand,
    this.isVerified = false,
    required this.priceRange,
    this.quantity = '',
  });

  @override
  Widget build(BuildContext context) {
    THelperFunctions.isDarkMode(context);
    // Using Card for material elevation and rounded corners.
    return GestureDetector(
      // onTap: () {
      //   Get.to(() => const ProductDetailView());
      // },
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /////// -- Thumbnail -- ///////
            TThumbnail(
                imageUrl: imageUrl,
                discountText: discountText,
                isFavorite: isFavorite),
            /////// -- Details -- ///////
            DetailsVerticalWidget(
                productTitle: productTitle,
                brand: brand,
                isVerified: isVerified,
                priceRange: priceRange,
                quantity: quantity),
          ],
        ),
      ),
    );
  }
}
