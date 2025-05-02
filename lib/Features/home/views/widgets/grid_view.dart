import 'package:flutter/material.dart';
import 'package:rjs_store/core/widgets/grid%20layout/t_grid_lay_out_body.dart';
import '../../../../core/productsList.dart';
import '../../../../core/utils/constants/sizes.dart';
import '../../../../core/widgets/products cart/vertical_product_card.dart';

class TGridView extends StatelessWidget {
  const TGridView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: TSizes.sm),
      child: TGridLayoutBody(
        itemCount: 10,
        itemBuilder: (BuildContext context, int index) {
          final product = ProductsList.products[index];
          return TVerticalProductCard(
            imageUrl: product['imageUrl']!,
            productTitle: product['productTitle']!,
            brand: product['brand']!,
            priceRange: product['priceRange']!,
            discountText: '75%',
            isVerified: true,
            isFavorite: true,
            // quantity: '5',
            onFavoriteTap: () {},
            // Optionally pass other parameters such as discountText, isFavorite, etc.
          );
        },
      ),
    );
  }
}
