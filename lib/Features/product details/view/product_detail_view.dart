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
  const ProductDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const BottomAddToCard(),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              /// -- Product Image Slider -- ///
              const TProductImageSlider(),

              /// -- Product Details --///
              Padding(
                padding: const EdgeInsets.only(
                    right: TSizes.defaultSpace,
                    left: TSizes.defaultSpace,
                    bottom: TSizes.defaultSpace),
                child: Column(
                  children: [
                    /// - Rating & Share
                    const TRatingAndShare(),

                    /// - Price , Title , Stack , Brand
                    const TProductMetaData(),

                    /// -- Attributes
                    const TProductAttributs(),
                    const SizedBox(height: TSizes.spaceBtwSections),

                    /// -- Chekout Button
                    CustomMaterialButton(onPressed: () {}, title: 'Checkout'),
                    const SizedBox(height: TSizes.spaceBtwSections),

                    /// - Description
                    const TSectionHeading(text: 'Description'),
                    const SizedBox(height: TSizes.spaceBtwItems),
                    const TReadMoreText(),

                    /// - Reviews
                    const Divider(),
                    const SizedBox(height: TSizes.spaceBtwItems),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const TSectionHeading(text: 'Reviews(199)'),
                        IconButton(
                          onPressed: () {
                            Get.to(() => const ReviewsRatingsView());
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
    );
  }
}
