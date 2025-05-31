import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rjs_store/core/widgets/grid%20layout/t_grid_lay_out_body.dart';
import 'package:rjs_store/core/widgets/stored_data_parse.dart';
import 'package:rjs_store/core/widgets/text/my_text.dart';
import 'package:rjs_store/core/widgets/user/user_controller.dart';
import '../../../../core/product_model.dart';
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
        // Show a loader while connectivity status is being checked.
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        // If there's an error or we're offline, show a message.
        if (snapshot.hasError || !(snapshot.data ?? false)) {
          return const Center(
            child: Text(
              "Offline",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          );
        } else {
          // Use Obx to rebuild when the reactive variable changes.
          return Obx(() {
            final storedData = controller.storedDataRx.value;
            if (storedData == null) {
              return Center(child: MyText(text: 'No data found.'));
            }

            // Get the products list stored locally.
            final List<ProductModel> products =
                StoredDataParser.getProducts(storedData);

            // Get the favorite list stored locally.
            final List<String> favoriteList =
                StoredDataParser.getFavoriteListOfObjectId(storedData);

            if (products.isEmpty) {
              return Center(child: MyText(text: 'No Products'));
            } else {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: TSizes.sm),
                child: TGridLayoutBody(
                  itemCount: products.length,
                  itemBuilder: (BuildContext context, int index) {
                    final product = products[index];
                    final bool isFavorite =
                        favoriteList.contains(product.objectId);
                    return TVerticalProductCard(
                      imageUrl: product.image,
                      productTitle: product.title,
                      brand: product.brand,
                      priceRange: product.priceRange,
                      discountText: product.discount,
                      isVerified: product.isVerified,
                      isFavorite: isFavorite,
                      quantity: product.instock.toString(),
                      onFavoriteTap: () {
                        controller.updateFavoriteList(product);
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
