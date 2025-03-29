import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:rjs_store/core/utils/constants/colors.dart';
import 'package:rjs_store/core/utils/constants/sizes.dart';
import 'package:rjs_store/core/utils/helpers/helper_functions.dart';

import '../../../../core/widgets/brand_widget.dart';
import '../../../../core/widgets/text/my_text.dart';

class VerticalProductCard extends StatelessWidget {
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

  /// The Action when you click on the card
  final void Function()? onTap;

  /// Creates a reusable product card widget.
  const VerticalProductCard({
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
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // Using Card for material elevation and rounded corners.
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image with overlay elements: discount badge and favorite icon.
            Stack(
              children: [
                // Display the product image.
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(TSizes.cardRadiusMd)),
                  child: CustomImage(
                    imageUrl: imageUrl,
                    isNetworkImage: false,
                  ),
                ),
                // Discount badge positioned on the top-left.
                if (discountText.isNotEmpty)
                  Positioned(
                    top: 8,
                    left: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.yellow.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: MyText(
                        text: discountText,
                        fontWeight: FontWeight.bold,
                        color: TColors.black,
                      ),
                    ),
                  ),
                // Favorite button positioned on the top-right.
                Positioned(
                  top: 4,
                  right: 4,
                  child: IconButton(
                    color: TColors.buttonPrimary,
                    icon: Icon(
                      isFavorite ? Iconsax.heart5 : Iconsax.heart,
                      color: isFavorite
                          ? Colors.red
                          : THelperFunctions.isDarkMode(context)
                              ? TColors.light
                              : TColors.dark,
                    ),
                    onPressed: onFavoriteTap,
                  ),
                ),
              ],
            ),
            // Product details section.
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Display the product title.
                  MyText(
                    text: productTitle,
                    fontWeight: FontWeight.bold,
                  ),

                  const SizedBox(height: 4),
                  // Display the brand and an optional verified check icon.
                  BrandWidget(brand: brand, isVerified: isVerified),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Display the price range.
                      MyText(
                        text: priceRange,
                        fontWeight: FontWeight.bold,
                      ),

                      // Display the quantity indicator if provided.
                      if (quantity.isNotEmpty)
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 4, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius:
                                BorderRadius.circular(TSizes.cardRadiusSm),
                          ),
                          child: MyText(
                            text: quantity,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomImage extends StatelessWidget {
  const CustomImage({
    super.key,
    required this.imageUrl,
    this.isNetworkImage = false,
  });

  final String imageUrl;
  final bool isNetworkImage;

  @override
  Widget build(BuildContext context) {
    return isNetworkImage
        ? Image.network(
            imageUrl,
            height: 150,
            width: double.infinity,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => Container(
              height: THelperFunctions.screenHeight() * 0.2,
              color: Colors.grey.shade300,
              child: const Icon(Icons.broken_image, size: 48),
            ),
          )
        : Image.asset(
            imageUrl,
            height: THelperFunctions.screenHeight() * 0.2,
            width: double.infinity,
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) => Container(
              height: 200,
              color: Colors.grey.shade300,
              child: const Icon(Icons.broken_image, size: 48),
            ),
          );
  }
}
