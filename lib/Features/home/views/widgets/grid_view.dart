import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rjs_store/core/widgets/grid%20layout/t_grid_lay_out_body.dart';
import 'package:rjs_store/core/widgets/user/user_controller.dart';
import '../../../../core/utils/constants/sizes.dart';
import '../../../../core/widgets/products cart/vertical_product_card.dart';
import 'shimmer_grid.dart';

class TGridView extends StatelessWidget {
  const TGridView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;

    // Wrapping the whole widget tree inside an Obx makes sure that
    // any change in the reactive user's products will trigger a rebuild.
    return Obx(() {
      // Retrieve the products list from the user's data.
      final products = controller.user.value.products;

      // If the products list is null or empty, display a shimmer (or loading) widget.
      if (products.isEmpty) {
        return const TShimmerGrid();
      } else {
        // Otherwise, display the grid with the Vertical Product Cards.
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: TSizes.sm),
          child: TGridLayoutBody(
            // Use the length of the list for the grid
            itemCount: products.length,
            itemBuilder: (BuildContext context, int index) {
              bool isFavorite = controller.user.value.favoriteList
                      ?.contains(products[index].objectId) ??
                  false;

              return TVerticalProductCard(
                imageUrl: products[index].image,
                productTitle: products[index].title,
                brand: products[index].brand,
                priceRange: products[index].priceRange,
                discountText: products[index].discount,
                isVerified: products[index].isVerified,
                isFavorite: isFavorite,
                onFavoriteTap: () {
                  controller.updateFavoriteList(products[index]);
                },
              );
            },
          ),
        );
      }
    });
  }
}
