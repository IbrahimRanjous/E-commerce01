import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/productsList.dart';
import '../../../../core/utils/constants/colors.dart';
import '../../../../core/utils/constants/sizes.dart';
import '../../../../core/widgets/products cart/horizontal_product_card.dart';
import '../../../../core/widgets/section_heading.dart';
import '../../../product details/view/product_detail_view.dart';

class TSubCategories extends StatelessWidget {
  const TSubCategories({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const TSectionHeading(
          text: 'Sport shoes',
          showActionButton: true,
          buttonColor: TColors.primary,
        ),
        const SizedBox(height: TSizes.spaceBtwItems),
        SizedBox(
          height: 120,
          child: ListView.separated(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: ProductsList.products.length,
            separatorBuilder: (_, __) =>
                const SizedBox(width: TSizes.spaceBtwItems / 4),
            itemBuilder: (BuildContext context, int index) {
              final product = ProductsList.products[index];

              return THorizontalProductCard(
                imageUrl: product['imageUrl']!,
                productTitle: product['productTitle']!,
                brand: product['brand']!,
                priceRange: product['priceRange']!,
                discountText: '75%',
                isVerified: true,
                isFavorite: true,
                // quantity: '5',
                onFavoriteTap: () {},
                onTap: () {
                  Get.to(() => const ProductDetailView());
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
