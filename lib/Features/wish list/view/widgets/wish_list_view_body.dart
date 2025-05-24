import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/product_model.dart';
import '../../../../core/utils/constants/sizes.dart';
import '../../../../core/widgets/grid layout/t_grid_lay_out_body.dart';
import '../../../../core/widgets/products cart/vertical_product_card.dart';
import '../../../../core/widgets/text/my_text.dart';
import '../../../../core/widgets/user/user_controller.dart';
import '../../../home/views/widgets/shimmer_grid.dart';

class WishListViewBody extends StatelessWidget {
  const WishListViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;

    // Wrapping the widget tree inside Obx so changes to the reactive user will trigger a rebuild.
    return Obx(() {
      // Retrieve the full products list and the favorites list from the user.
      final List<ProductModel> products = controller.user.value.products;
      final List<String> favoriteList =
          controller.user.value.favoriteList ?? [];

      // First, check if there are any products.
      if (products.isEmpty) {
        return const TShimmerGrid();
      }

      // Filter the products to only those whose objectId appears in the favorites list.
      final List<ProductModel> favoriteProducts = products
          .where((product) => favoriteList.contains(product.objectId))
          .toList();

      // If the filtered favorites list is empty, show a placeholder message.
      if (favoriteProducts.isEmpty) {
        return Center(child: MyText(text: 'No favorite products found.'));
      }

      // Otherwise, display the grid with the favorite products.
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: TSizes.sm),
        child: TGridLayoutBody(
          itemCount: favoriteProducts.length,
          itemBuilder: (BuildContext context, int index) {
            final product = favoriteProducts[index];
            bool isFavorite = true; // We already filtered only favorites

            return TVerticalProductCard(
              imageUrl: product.image,
              productTitle: product.title,
              brand: product.brand,
              priceRange: product.priceRange,
              discountText: product.discount,
              isVerified: product.isVerified,
              isFavorite: isFavorite,
              onFavoriteTap: () {
                // This toggles the favorite state (removes the product, then refreshes).
                controller.updateFavoriteList(product);
              },
            );
          },
        ),
      );
    });
  }
}
