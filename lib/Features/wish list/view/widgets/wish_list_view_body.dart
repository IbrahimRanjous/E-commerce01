import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:rjs_store/core/product_model.dart';
import 'package:rjs_store/core/utils/constants/sizes.dart';
import 'package:rjs_store/core/widgets/grid%20layout/t_grid_lay_out_body.dart';
import 'package:rjs_store/core/widgets/products%20cart/vertical_product_card.dart';
import 'package:rjs_store/core/widgets/text/my_text.dart';
import '../../../../core/widgets/stored_data_parse.dart';
import '../../../../core/widgets/user/user_controller.dart';

class WishListViewBody extends StatelessWidget {
  const WishListViewBody({super.key});

  /// Refresh calls the controller's loadStoredData to update the reactive variable.
  Future<void> _onRefresh() async {
    await UserController.instance.loadStoredData();
  }

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    return StreamBuilder<bool>(
      initialData: true,
      stream: Connectivity()
          .onConnectivityChanged
          // ignore: unrelated_type_equality_checks
          .map<bool>((result) => result != ConnectivityResult.none),
      builder: (context, snapshot) {
        // Show a loader while waiting for connectivity info.
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        final bool isConnected = snapshot.data ?? false;
        if (!isConnected) {
          return const Center(
            child: Text(
              "Offline",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          );
        }
        // Wrap content in RefreshIndicator.
        return RefreshIndicator(
          onRefresh: _onRefresh,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Obx(() {
              final storedData = controller.storedDataRx.value;
              if (storedData == null) {
                return Center(child: MyText(text: 'No user data found.'));
              }

              // Filter to include only favorite products.
              final List<ProductModel> favoriteProducts =
                  StoredDataParser.getFavoriteProducts(storedData);
              if (favoriteProducts.isEmpty) {
                return Center(
                    child: MyText(text: 'No favorite products found.'));
              }
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: TSizes.sm),
                child: TGridLayoutBody(
                  itemCount: favoriteProducts.length,
                  itemBuilder: (BuildContext context, int index) {
                    final product = favoriteProducts[index];
                    return TVerticalProductCard(
                      imageUrl: product.image,
                      productTitle: product.title,
                      brand: product.brand,
                      priceRange: product.priceRange,
                      price: product.price,
                      discount: product.discount,
                      isVerified: product.isVerified,
                      isFavorite: true,
                      quantity: product.instock.toString(),
                      rating: product.rating,
                      reviews: product.reviews,
                      status: product.status,
                      description: product.description,
                      onFavoriteTap: () {
                        controller.updateFavoriteList(product);
                      },
                    );
                  },
                ),
              );
            }),
          ),
        );
      },
    );
  }
}
