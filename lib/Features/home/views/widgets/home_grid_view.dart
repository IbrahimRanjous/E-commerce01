import 'package:flutter/material.dart';
import '../../../../core/productsList.dart';
import '../../../../core/widgets/grid layout/t_grid_lay_out.dart';
import 'card_product_item.dart';

class THomeGridViewBody extends StatelessWidget {
  const THomeGridViewBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TGridLayout(
      itemCount: ProductsList.products.length,
      itemBuilder: (BuildContext context, int index) {
        final product = ProductsList.products[index];
        return VerticalProductCard(
          imageUrl: product['imageUrl']!,
          productTitle: product['productTitle']!,
          brand: product['brand']!,
          priceRange: product['priceRange']!,
          discountText: '75%',
          isVerified: true,
          isFavorite: true,
          quantity: '5',
          onFavoriteTap: () {},
          onTap: () {},
          // Optionally pass other parameters such as discountText, isFavorite, etc.
        );
      },
    );
  }
}
