// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:rjs_store/core/widgets/grid%20layout/t_grid_lay_out_body.dart';
// import 'package:rjs_store/core/widgets/text/my_text.dart';
// import 'package:rjs_store/core/widgets/user/user_controller.dart';
// import '../../../../core/utils/constants/sizes.dart';
// import '../../../../core/widgets/products cart/vertical_product_card.dart';

// class TGridView extends StatelessWidget {
//   const TGridView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final controller = UserController.instance;

//     return StreamBuilder<bool>(
//       initialData: true,
//       stream: Connectivity()
//           .onConnectivityChanged
//           // ignore: unrelated_type_equality_checks
//           .map<bool>((result) => result != ConnectivityResult.none),
//       builder: (context, snapshot) {
//         // While waiting for the connectivity event, show a loader.
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const Center(child: CircularProgressIndicator());
//         }

//         // If there’s an error or no connectivity, display "Offline."
//         if (snapshot.hasError || !(snapshot.data ?? false)) {
//           return const Center(
//             child: Text(
//               "Offline",
//               style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//             ),
//           );
//         }
//         // Otherwise, build the grid view using Obx to listen to state changes.
//         return Obx(() {
//           // Retrieve the products list from the user's data.
//           final products = controller.user.value.products;
//           if (products.isEmpty) {
//             return Center(
//               child: MyText(text: 'No Products'),
//             );
//           }
//           return Padding(
//             padding: const EdgeInsets.symmetric(horizontal: TSizes.sm),
//             child: TGridLayoutBody(
//               itemCount: products.length,
//               itemBuilder: (BuildContext context, int index) {
//                 bool isFavorite = controller.user.value.favoriteList
//                         ?.contains(products[index].objectId) ??
//                     false;
//                 return TVerticalProductCard(
//                   imageUrl: products[index].image,
//                   productTitle: products[index].title,
//                   brand: products[index].brand,
//                   priceRange: products[index].priceRange,
//                   discountText: products[index].discount,
//                   isVerified: products[index].isVerified,
//                   isFavorite: isFavorite,
//                   onFavoriteTap: () {
//                     controller.updateFavoriteList(products[index]);
//                   },
//                 );
//               },
//             ),
//           );
//         });
//       },
//     );
//   }
// }
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rjs_store/core/widgets/grid%20layout/t_grid_lay_out_body.dart';
import 'package:rjs_store/core/widgets/text/my_text.dart';
import 'package:rjs_store/core/widgets/user/user_controller.dart';
import 'package:rjs_store/core/utils/constants/sizes.dart';
import 'package:rjs_store/core/widgets/products%20cart/vertical_product_card.dart';

class TGridView extends StatelessWidget {
  const TGridView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;

    return StreamBuilder<bool>(
      // Listen to connectivity changes, mapping to a bool.
      initialData: true,
      stream: Connectivity()
          .onConnectivityChanged
          .map<bool>((result) => result != ConnectivityResult.none),
      builder: (context, snapshot) {
        bool isConnected = snapshot.data ?? true;

        return Column(
          children: [
            // Show an offline banner if connectivity is lost.
            if (!isConnected)
              Container(
                width: double.infinity,
                color: Colors.red,
                padding: const EdgeInsets.all(8),
                child: const Text(
                  'Offline: Showing cached data',
                  style: TextStyle(color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ),
            // Always display the grid of products from your reactive user variable.
            Expanded(
              child: Obx(() {
                // Using the reactive user variable here.
                final products = controller.user.value.products;
                final fav = controller.user.value.favoriteList;
                if (products.isEmpty) {
                  return Center(child: MyText(text: 'No Products'));
                }
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: TSizes.sm),
                  child: TGridLayoutBody(
                    itemCount: products.length,
                    itemBuilder: (BuildContext context, int index) {
                      // Determine if the product is a favorite using the reactive favoriteList.
                      bool isFavorite =
                          fav?.contains(products[index].objectId) ?? false;

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
              }),
            ),
          ],
        );
      },
    );
  }
}
