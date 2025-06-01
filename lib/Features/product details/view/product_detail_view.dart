import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:rjs_store/Features/login/views/widgets/custom_material_button.dart';
import 'package:rjs_store/Features/product%20details/view/reviews_ratings_view.dart';
import 'package:rjs_store/Features/product%20details/view/widgets/product_attributs.dart';
import 'package:rjs_store/Features/product%20details/view/widgets/product_meta_data.dart';
import 'package:rjs_store/core/utils/constants/sizes.dart';
import 'package:rjs_store/core/widgets/section_heading.dart';
import 'widgets/bottom_add_to_card.dart';
import 'widgets/product_image_slider.dart';
import 'widgets/rating_and_share.dart';
import 'widgets/read_more_text.dart';

class ProductDetailView extends StatelessWidget {
  ProductDetailView(
      {super.key,
      required this.imageUrl,
      required this.discount,
      required this.isFavorite,
      this.onFavoriteTap,
      required this.productTitle,
      required this.brand,
      required this.isVerified,
      required this.priceRange,
      required this.quantity,
      required this.rating,
      required this.status,
      required this.reviews,
      required this.price,
      required this.description});

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
  final int reviews;
  final bool status;

  final GlobalKey _captureKey = GlobalKey();
  // Expose the key so that we can use it outside or pass it via constructor if needed.
  GlobalKey get captureKey => _captureKey;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const BottomAddToCard(),
      body: RepaintBoundary(
        key: _captureKey,
        child: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              children: [
                /// -- Product Image Slider -- ///
                TProductImageSlider(
                  imageUrl: imageUrl,
                  isFavorite: isFavorite.obs,
                  onFavoriteTap: onFavoriteTap,
                ),

                /// -- Product Details --///
                Padding(
                  padding: const EdgeInsets.only(
                      right: TSizes.defaultSpace,
                      left: TSizes.defaultSpace,
                      bottom: TSizes.defaultSpace),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// - Rating & Share
                      TRatingAndShare(
                        rating: rating,
                        reviews: reviews,
                        captureKey: captureKey,
                      ),

                      /// - Price , Title , Stack , Brand
                      TProductMetaData(
                        productTitle: productTitle,
                        brand: brand,
                        isVerified: isVerified,
                        price: price,
                        quantity: quantity,
                        status: status,
                        discount: discount,
                      ),

                      /// -- Attributes
                      TProductAttributs(
                        discount: discount,
                        price: price,
                        quantity: quantity,
                        status: status,
                        description: description,
                      ),
                      const SizedBox(height: TSizes.spaceBtwSections),

                      /// -- Chekout Button
                      CustomMaterialButton(onPressed: () {}, title: 'Checkout'),
                      const SizedBox(height: TSizes.spaceBtwSections),

                      /// - Description
                      const TSectionHeading(text: 'Description'),
                      const SizedBox(height: TSizes.spaceBtwItems),
                      TReadMoreText(
                        description: description,
                      ),

                      /// - Reviews
                      const Divider(),
                      const SizedBox(height: TSizes.spaceBtwItems),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TSectionHeading(text: 'Reviews($reviews)'),
                          IconButton(
                            onPressed: () {
                              Get.to(() => ReviewsRatingsView(
                                    description: description,
                                    rating: rating,
                                    reviews: reviews,
                                  ));
                            },
                            icon: const Icon(
                              Iconsax.arrow_right_3,
                              size: 18,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: TSizes.spaceBtwItems),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
