import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rjs_store/core/widgets/grid%20layout/t_grid_lay_out_body.dart';
import 'package:rjs_store/core/widgets/text/my_text.dart';
import 'package:rjs_store/core/widgets/user/user_controller.dart';
import '../../../../core/utils/constants/sizes.dart';
import '../../../../core/utils/network/network_manager.dart';
import '../../../../core/widgets/products cart/vertical_product_card.dart';
 
class TGridView extends StatelessWidget {
  const TGridView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;

    return FutureBuilder<bool>(
      future: NetworkManager.instance.isConnected(),
      builder: (context, snapshot) {
        // While the connection is being checked, show a loader.
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        // If there’s an error, treat it as offline.
        if (snapshot.hasError) {
          return const Center(
            child: Text(
              "Offline",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          );
        }

        // Determine connection status.
        final bool isConnected = snapshot.data ?? false;
        if (!isConnected) {
          return const Center(
            child: Text(
              "Offline",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          );
        } else {
          return Obx(() {
            // Retrieve the products list from the user's data.
            final products = controller.user.value.products;
            if (products.isEmpty) {
              return Center(
                child: MyText(text: 'No Products'),
              );
            } else {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: TSizes.sm),
                child: TGridLayoutBody(
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
      },
    );
  }
}
