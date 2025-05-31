import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rjs_store/core/utils/constants/colors.dart';
import 'package:rjs_store/core/utils/helpers/helper_functions.dart';
import 'package:rjs_store/core/widgets/products%20cart/thumbnail_horizontal_product.dart';
import '../../../Features/product details/view/product_detail_view.dart';
import 'add_to_card_button.dart';
import 'details_horizontal_widget.dart';
import 'favorite_icon.dart';

class THorizontalProductCard extends StatelessWidget {
  /// URL for the product image.
  final String imageUrl;

  /// Discount text (for example "78%") or an empty string if not applicable.
  final String discountText;

  /// Whether the product is currently favorited.
  final Rx<bool> isFavorite;

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

  /// Creates a reusable horizontal product card widget.
  const THorizontalProductCard({
    super.key,
    required this.imageUrl,
    this.discountText = '',
    required this.isFavorite,
    this.onFavoriteTap,
    required this.productTitle,
    required this.brand,
    this.isVerified = false,
    required this.priceRange,
    this.quantity = '',
  });

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final cardWidth = THelperFunctions.screenWidth() * 0.75;

    // Define fixed dimensions for the thumbnail image.
    const imageWidth = 100.0;
    const imageHeight = 100.0;

    return SizedBox(
      width: cardWidth,
      child: Card(
        color: dark ? TColors.darkerGrey : TColors.softGrey,
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Stack(
          children: [
            // Thumbnail image positioned at the left.
            InkWell(
              onTap: () => Get.to(() => const ProductDetailView()),
              child: Row(
                children: [
                  Positioned(
                    left: 0,
                    top: 0,
                    bottom: 0,
                    child: SizedBox(
                      width: imageWidth,
                      height: imageHeight,
                      child: TThumbnailHorizontalProduct(
                        imageUrl: imageUrl,
                        discountText: discountText,
                      ),
                    ),
                  ),
                  // Details widget positioned to start after the thumbnail.
                  // This widget should have its internal Expanded removed so that it respects the given bounds.
                  Positioned(
                    left: imageWidth, // starts right after the thumbnail
                    top: 0,
                    right: 0,
                    bottom: 0,
                    child: DetailsHorizontalWidget(
                      productTitle: productTitle,
                      brand: brand,
                      isVerified: isVerified,
                      priceRange: priceRange,
                      quantity: quantity,
                    ),
                  ),
                ],
              ),
            ),
            // Conditionally display the Add to Cart button.
            if (quantity.isEmpty)
              Positioned(
                bottom: 5,
                right: 5,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: const TAddToCardButton(),
                ),
              ),
            // Favorite icon positioned at the top-right.
            Positioned(
              top: 5,
              right: 8,
              child: FavoriteIcon(
                onTap: onFavoriteTap,
                isFavorite: isFavorite,
                iconSize: 30.0,
                containerSize: 35.0,
                top: 2.0,
                right: 2.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
