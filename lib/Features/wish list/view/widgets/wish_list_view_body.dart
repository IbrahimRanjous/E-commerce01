import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:rjs_store/core/product_model.dart';
import 'package:rjs_store/core/utils/constants/sizes.dart';
import 'package:rjs_store/core/widgets/grid%20layout/t_grid_lay_out_body.dart';
import 'package:rjs_store/core/widgets/products%20cart/vertical_product_card.dart';
import 'package:rjs_store/core/widgets/text/my_text.dart';
import 'package:rjs_store/core/widgets/user/user_controller.dart';

class WishListViewBody extends StatelessWidget {
  const WishListViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;

    // Convert the connectivity stream of ConnectivityResult into a bool stream.
    return StreamBuilder<bool>(
      initialData: true,
      stream: Connectivity()
          .onConnectivityChanged
          // ignore: unrelated_type_equality_checks
          .map<bool>((result) => result != ConnectivityResult.none),
      builder: (context, snapshot) {
        // If waiting for the connectivity event, show a loader.
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        // If no connectivity or an error occurs, display "Offline".
        final bool isConnected = snapshot.data ?? false;
        if (!isConnected) {
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

        // Otherwise, build your UI using the reactive Obx block.
        return Obx(() {
          // Retrieve the full products list and the favorites list.
          final List<ProductModel> products = controller.user.value.products;
          final List<String> favoriteList =
              controller.user.value.favoriteList ?? [];

          // Filter, if any, to include only favorite products.
          final List<ProductModel> favoriteProducts = products
              .where((product) => favoriteList.contains(product.objectId))
              .toList();

          // If there are no favorite products, show a placeholder message.
          if (favoriteProducts.isEmpty) {
            return Center(child: MyText(text: 'No favorite products found.'));
          }

          // Otherwise, show a grid view with the favorite products.
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: TSizes.sm),
            child: TGridLayoutBody(
              itemCount: favoriteProducts.length,
              itemBuilder: (BuildContext context, int index) {
                final product = favoriteProducts[index];
                // This card is definitely a favorite.
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
