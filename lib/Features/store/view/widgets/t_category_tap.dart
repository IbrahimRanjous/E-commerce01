import 'package:flutter/material.dart';
import '../../../../core/utils/constants/sizes.dart';
import '../../../../core/widgets/section_heading.dart';
import 'grid_view_categories.dart';

class TCategoryTap extends StatelessWidget {
  const TCategoryTap({
    super.key,
    required this.categoryFilter,
  });
  final String categoryFilter;

  @override
  Widget build(BuildContext context) {
    return ListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(TSizes.defaultSpace),
                child: Column(
                  children: [
                    /// -- Brands
                    // const TBrandShowCase(images: [
                    //   TImages.productImage1,
                    //   TImages.productImage3,
                    //   TImages.productImage2
                    // ]),

                    /// -- Products
                    TSectionHeading(
                      text: 'You might like',
                    ),
                    const SizedBox(height: TSizes.spaceBtwItems),
                  ],
                ),
              ),
              TGridViewCategories(
                categoryFilter: categoryFilter,
              ),
            ],
          ),
        ]);
  }
}
