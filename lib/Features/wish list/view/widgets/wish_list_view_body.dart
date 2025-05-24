import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rjs_store/core/product_model.dart';
import 'package:rjs_store/core/utils/constants/sizes.dart';
import 'package:rjs_store/core/widgets/grid%20layout/t_grid_lay_out_body.dart';
import 'package:rjs_store/core/widgets/products%20cart/vertical_product_card.dart';
import 'package:rjs_store/core/widgets/text/my_text.dart';
import 'package:rjs_store/core/widgets/user/user_controller.dart';
import 'package:rjs_store/core/utils/network/network_manager.dart';

class WishListViewBody extends StatelessWidget {
  const WishListViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;

    return FutureBuilder<bool>(
      future: NetworkManager.instance.isConnected(),
      builder: (context, snapshot) {
        // While the connectivity check is in progress, show a loader.
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        // If there's no connection or an error occurred, display "Offline".
        if (!snapshot.hasData || snapshot.data == false) {
          return const Center(
            child: Text(
              "Offline",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
        }

        // Otherwise, when there is connectivity, build the wishlist grid.
        return Obx(() {
          // Retrieve the full products list and the favorites list from the user.
          final List<ProductModel> products = controller.user.value.products;
          final List<String> favoriteList =
              controller.user.value.favoriteList ?? [];

          // Filter to only favorite products.
          final List<ProductModel> favoriteProducts = products
              .where((product) => favoriteList.contains(product.objectId))
              .toList();

          // If no favorites remain, show a placeholder message.
          if (favoriteProducts.isEmpty) {
            return Center(child: MyText(text: 'No favorite products found.'));
          }

          // Display the grid with favorite products.
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: TSizes.sm),
            child: TGridLayoutBody(
              itemCount: favoriteProducts.length,
              itemBuilder: (BuildContext context, int index) {
                final product = favoriteProducts[index];
                // We know it's a favorite, so isFavorite is true.
                bool isFavorite = true;
                return TVerticalProductCard(
                  imageUrl: product.image,
                  productTitle: product.title,
                  brand: product.brand,
                  priceRange: product.priceRange,
                  discountText: product.discount,
                  isVerified: product.isVerified,
                  isFavorite: isFavorite,
                  onFavoriteTap: () {
                    // Toggle favorite status: this should update your controller.
                    controller.updateFavoriteList(product);
                  },
                );
              },
            ),
          );
        });
      },
    );
  }
}
