import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/product_model.dart';
import '../../../../core/utils/constants/colors.dart';
import '../../../../core/utils/constants/sizes.dart';
import '../../../../core/utils/network/network_manager.dart';
import '../../../../core/widgets/products cart/horizontal_product_card.dart';
import '../../../../core/widgets/section_heading.dart';
import '../../../../core/widgets/stored_data_parse.dart';
import '../../../../core/widgets/text/my_text.dart';
import '../../../../core/widgets/user/user_controller.dart';

class TSubCategories extends StatelessWidget {
  const TSubCategories({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;

    return Column(
      children: [
        const TSectionHeading(
          text: 'Sport shoes',
          showActionButton: true,
          buttonColor: TColors.primary,
        ),
        const SizedBox(height: TSizes.spaceBtwItems),
        FutureBuilder(
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
                  return SizedBox(
                    height: 120,
                    child: ListView.separated(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: products.length,
                      separatorBuilder: (_, __) =>
                          const SizedBox(width: TSizes.spaceBtwItems / 4),
                      itemBuilder: (BuildContext context, int index) {
                        final product = products[index];
                        final bool isFavorite =
                            favoriteList.contains(product.objectId);

                        return THorizontalProductCard(
                          imageUrl: product.image,
                          productTitle: product.title,
                          brand: product.brand,
                          priceRange: product.priceRange,
                          price: product.price,
                          discount: product.discount,
                          isVerified: product.isVerified,
                          isFavorite: isFavorite,
                          quantity: product.instock.toString(),
                          rating: product.rating,
                          status: product.status,
                          reviews: product.reviews,
                          description: product.description,
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
        ),
      ],
    );
  }
}
