import 'package:flutter/material.dart';
 import '../../../../core/projucts_list.dart';
import '../../../../core/utils/constants/sizes.dart';
import 'card_product_item.dart';

class THomeGridView extends StatelessWidget {
  const THomeGridView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true, // Ensures the GridView only occupies necessary space
      physics:
          const NeverScrollableScrollPhysics(), // Disables the GridView's own scrolling
      padding: EdgeInsets.zero,
      itemCount: ProductsList.products.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // Number of items per row
        crossAxisSpacing:
            TSizes.gridViewSpacing, // Horizontal spacing between items
        mainAxisSpacing:
            TSizes.gridViewSpacing, // Vertical spacing between items
        childAspectRatio: MediaQuery.of(context).size.aspectRatio *
            1.4, // Adjust this ratio based on your card layout
      ),
      itemBuilder: (BuildContext context, int index) {
        final product = ProductsList.products[index];
        return ProductCard(
          imageUrl: product['imageUrl']!,
          productTitle: product['productTitle']!,
          brand: product['brand']!,
          priceRange: product['priceRange']!,
          discountText: '75%',
          isVerified: true,
          isFavorite: true,
          quantity: '5',
          onFavoriteTap: () {},
          // Optionally pass other parameters such as discountText, isFavorite, etc.
        );
      },
    );
  }
}
