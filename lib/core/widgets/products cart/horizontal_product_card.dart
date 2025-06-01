// thorizontal_product_card.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rjs_store/core/utils/constants/colors.dart';
import 'package:rjs_store/core/utils/helpers/helper_functions.dart';
import '../../../Features/product details/view/product_detail_view.dart';
import 'add_to_card_button.dart';
import 'details_horizontal_widget.dart';
import 'favorite_icon.dart';
import 'thumbnail_horizontal_product.dart';

class THorizontalProductCard extends StatelessWidget {
  /// URL for the product image.
  final String imageUrl;

  /// Discount text (for example "78%") or an empty string if not applicable.
  final int discount;

  /// Whether the product is currently favorited.
  final bool isFavorite;

  /// funciton when the favorite icon is tapped.
  final void Function()? onFavoriteTap;

  /// The title of the product.
  final String productTitle;

  /// The brand of the product.
  final String brand;

  /// Whether the brand is verified.
  final bool isVerified;

  /// The price range for the product.
  final String priceRange;
  final String price;

  /// The quantity indicator (could show available stock, etc.)
  final String quantity;

  final String description;

  final double rating;
  final bool status;
  final int reviews;

  /// Creates a reusable horizontal product card widget.
  const THorizontalProductCard({
    super.key,
    required this.imageUrl,
    required this.discount,
    this.isFavorite = false,
    this.onFavoriteTap,
    required this.productTitle,
    required this.brand,
    this.isVerified = false,
    required this.priceRange,
    this.quantity = '',
    required this.rating,
    required this.status,
    required this.reviews,
    this.price = 'N/A',
    required this.description,
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
            // Main content arranged in a Row inside an InkWell.
            InkWell(
              onTap: () {
                Get.to(() => ProductDetailView(
                      imageUrl: imageUrl,
                      discount: discount,
                      isFavorite: isFavorite,
                      productTitle: productTitle,
                      brand: brand,
                      isVerified: isVerified,
                      priceRange: priceRange,
                      quantity: quantity,
                      rating: rating,
                      status: status,
                      reviews: reviews,
                      price: price,
                      description: description,
                      onFavoriteTap: onFavoriteTap,
                    ));
              },
              child: Row(
                children: [
                  // Thumbnail image on the left.
                  SizedBox(
                    width: imageWidth,
                    height: imageHeight,
                    child: TThumbnailHorizontalProduct(
                      imageUrl: imageUrl,
                      discount: discount,
                    ),
                  ),
                  // Details widget that uses Expanded internally.
                  DetailsHorizontalWidget(
                    productTitle: productTitle,
                    brand: brand,
                    isVerified: isVerified,
                    priceRange: priceRange,
                    quantity: quantity,
                  ),
                ],
              ),
            ),
            // Overlay: Conditionally display the Add to Cart button.
            if (quantity.isEmpty)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TAddToCardButton(),
              ),
            // Overlay: Favorite icon.
            FavoriteIcon(
              onTap: onFavoriteTap,
              isFavorite: isFavorite,
              iconSize: 30.0,
              containerSize: 35.0,
              top: 2.0,
              right: 2.0,
            ),
          ],
        ),
      ),
    );
  }
}
