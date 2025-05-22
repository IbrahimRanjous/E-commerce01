import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rjs_store/Features/Signin/data/repo/user_repository.dart';
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
      if (products == null || products.isEmpty) {
        return const TShimmerGrid();
      } else {
        // Otherwise, display the grid with the Vertical Product Cards.
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: TSizes.sm),
          child: TGridLayoutBody(
            // Use the length of the list for the grid
            itemCount: products.length,
            itemBuilder: (BuildContext context, int index) {
              // Here you may choose to make each card reactive if its internal state is updated.
              // In this example, we'll simply use the product's own properties.
              return TVerticalProductCard(
                imageUrl: products[index].image,
                productTitle: products[index].title,
                brand: products[index].brand,
                priceRange: products[index].priceRange,
                discountText: products[index].discount,
                isVerified: products[index].isVerified,
                isFavorite: products[index].isFavorite,
                onFavoriteTap: () {
                  // Toggle the isFavorite value locally for this product.
                  products[index].isFavorite = !products[index].isFavorite;
                  // Refresh the controller's user observable so that the UI rebuilds.
                  UserRepository.instance.update();
                  controller.user.refresh();
                },
              );
            },
          ),
        );
      }
    });
  }
}
