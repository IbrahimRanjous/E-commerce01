import 'package:flutter/material.dart';
import 'package:rjs_store/Features/home/views/widgets/grid_view.dart';
import '../../../../core/utils/constants/image_strings.dart';
import '../../../../core/utils/constants/sizes.dart';
import '../../../../core/widgets/section_heading.dart';
import 'brand_show_case.dart';

class TCategoryTap extends StatelessWidget {
  const TCategoryTap({
    super.key,
  });

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
                    const TBrandShowCase(images: [
                      TImages.productImage1,
                      TImages.productImage3,
                      TImages.productImage2
                    ]),

                    /// -- Products
                    TSectionHeading(
                      text: 'You might like',
                      onPressed: () {},
                    ),
                    const SizedBox(height: TSizes.spaceBtwItems),
                  ],
                ),
              ),
              const TGridView(),
            ],
          ),
        ]);
  }
}
