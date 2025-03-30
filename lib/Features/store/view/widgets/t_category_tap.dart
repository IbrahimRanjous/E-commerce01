import 'package:flutter/material.dart';

import '../../../../core/utils/constants/image_strings.dart';
import '../../../../core/utils/constants/sizes.dart';
import '../../../../core/widgets/grid layout/t_grid_lay_out.dart';
import '../../../../core/widgets/section_heading.dart';
import '../../../home/views/widgets/card_product_item.dart';
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

                TGridLayout(
                    itemCount: 6,
                    itemBuilder: (_, index) => const TVerticalProductCard(
                        imageUrl: TImages.productImage10,
                        productTitle: 'Green Nike Air shoes',
                        brand: 'Nike',
                        priceRange: '\$120-\$130')),
              ],
            ),
          ),
        ]);
  }
}
