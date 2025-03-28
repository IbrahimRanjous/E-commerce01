import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:rjs_store/core/utils/constants/colors.dart';
import 'package:rjs_store/core/utils/constants/sizes.dart';
import 'package:rjs_store/core/utils/device/device_utility.dart';
import 'package:rjs_store/core/utils/helpers/helper_functions.dart';

class ProductCard extends StatelessWidget {
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
  const ProductCard({
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
    // Using Card for material elevation and rounded corners.
    return Card(
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
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.yellow,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(discountText,
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis),
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
                            ? TColors.white
                            : TColors.black,
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
                Text(productTitle,
                    style: TextStyle(
                      fontSize: TDeviceUtils.getScreenWidth(context) * 0.038,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis),
                const SizedBox(height: 4),
                // Display the brand and an optional verified check icon.
                Row(
                  children: [
                    Text(brand,
                        style: TextStyle(
                          fontSize:
                              TDeviceUtils.getScreenWidth(context) * 0.035,
                          color: TColors.darkerGrey,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis),
                    if (isVerified) ...[
                      const SizedBox(width: 4),
                      const Icon(
                        Iconsax.verify5,
                        color: Colors.blue,
                        size: TSizes.iconSm,
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Display the price range.
                    Text(priceRange,
                        style: TextStyle(
                          fontSize: TDeviceUtils.getScreenWidth(context) * 0.03,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis),
                    // Display the quantity indicator if provided.
                    if (quantity.isNotEmpty)
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius:
                              BorderRadius.circular(TSizes.cardRadiusSm),
                        ),
                        child: Text(quantity,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: TDeviceUtils.getScreenWidth(context) *
                                    0.03),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis),
                      ),
                  ],
                )
              ],
            ),
          ),
        ],
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
