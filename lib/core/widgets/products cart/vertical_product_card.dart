import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rjs_store/core/utils/helpers/helper_functions.dart';
import '../../../Features/product details/view/product_detail_view.dart';
import 'details_vertical_widget.dart';
import 'favorite_icon.dart';
import 'thumbnail_vertical_product.dart';

class TVerticalProductCard extends StatelessWidget {
  /// URL for the product image.
  final String imageUrl;

  /// Discount text, for example "78%" or an empty string if not applicable.
  final int discount;

  /// Whether the product is currently favorited.
  final bool isFavorite;

  /// Callback when the favorite icon is tapped.
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

  /// Creates a reusable product card widget.
  const TVerticalProductCard({
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
    required this.price,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    THelperFunctions.isDarkMode(context);
    // Using Card for material elevation and rounded corners.
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Stack(
        children: [
          GestureDetector(
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
            child: Container(
              color: Colors.transparent,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /////// -- Thumbnail -- ///////
                  TThumbnailVerticalProduct(
                      onTap: onFavoriteTap,
                      imageUrl: imageUrl,
                      discount: discount,
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
          ),
          /////// -- Favorite -- ///////
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
    );
  }
}
