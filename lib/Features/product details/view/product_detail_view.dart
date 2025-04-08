import 'package:flutter/material.dart';
import 'package:rjs_store/Features/product%20details/view/widgets/product_attributs.dart';
import 'package:rjs_store/Features/product%20details/view/widgets/product_meta_data.dart';
import 'package:rjs_store/core/utils/constants/sizes.dart';
import 'widgets/product_image_slider.dart';
import 'widgets/rating_and_share.dart';

class ProductDetailView extends StatelessWidget {
  const ProductDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              /// -- Product Image Slider -- ///
              TProductImageSlider(),

              /// -- Product Details --///
              Padding(
                padding: EdgeInsets.only(
                    right: TSizes.defaultSpace,
                    left: TSizes.defaultSpace,
                    bottom: TSizes.defaultSpace),
                child: Column(
                  children: [
                    /// - Rating & Share
                    TRatingAndShare(),

                    /// - Price , Title , Stack , Brand
                    TProductMetaData(),

                    /// -- Attributes
                    TProductAttributs(),

                    /// -- Chekout Button
                    /// - Description
                    /// - Reviews
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
