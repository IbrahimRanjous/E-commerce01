import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rjs_store/core/utils/constants/colors.dart';
import 'package:rjs_store/core/utils/helpers/helper_functions.dart';
import '../../../Features/product details/view/product_detail_view.dart';
import 'details_horizontal_widget.dart';
import 'thumbnail.dart';

class THorizontalProductCard extends StatelessWidget {
  /// URL for the product image.
  final String imageUrl;

  /// Discount text (for example "78%") or an empty string if not applicable.
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

  /// Creates a reusable horizontal product card widget.
  const THorizontalProductCard({
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
    final dark = THelperFunctions.isDarkMode(context);
    final cardWidth = THelperFunctions.screenWidth() * 0.75;

    // Define fixed dimensions for the left image area.
    const imageWidth = 100.0;
    const imageHeight = 100.0;
    return GestureDetector(
      onTap: () {
        Get.to(() => const ProductDetailView());
      },
      child: SizedBox(
        width: cardWidth,
        child: Card(
          color: dark ? TColors.darkerGrey : TColors.softGrey,
          elevation: 4,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Left Section: Image with overlay elements.
              SizedBox(
                width: imageWidth,
                height: imageHeight,
                /////// -- Thumbnail -- ///////

                child: TThumbnail(
                    imageUrl: imageUrl,
                    discountText: discountText,
                    isFavorite: isFavorite.obs),
              ),
              /////// -- Details -- ///////
              DetailsHorizontalWidget(
                  productTitle: productTitle,
                  brand: brand,
                  isVerified: isVerified,
                  priceRange: priceRange,
                  quantity: quantity),
            ],
          ),
        ),
      ),
    );
  }
}
