import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/product_model.dart';
import '../../../../core/widgets/grid layout/t_grid_lay_out_body.dart';
import '../../../../core/widgets/stored_data_parse.dart';
import '../../../../core/widgets/text/my_text.dart';
import '../../../../core/widgets/user/user_controller.dart';
import '../brand_view_details.dart';
import 't_brand_card.dart';

class TStoreGridViewbody extends StatelessWidget {
  const TStoreGridViewbody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;

    final storedData = controller.storedDataRx.value;
    if (storedData == null) {
      return Center(child: MyText(text: 'No Brands found.'));
    }

    // Get the products list stored locally.
    final List<ProductModel> products =
        StoredDataParser.getProducts(storedData);

    // Create a map to track unique brands.
    // The first ProductModel encountered for each brand is used as its representative.
    final Map<String, ProductModel> uniqueBrandMap = {};
    for (var product in products) {
      if (!uniqueBrandMap.containsKey(product.brand)) {
        uniqueBrandMap[product.brand] = product;
      }
    }

    // Extract the unique brand names and their associated products.
    final List<String> uniqueBrands = uniqueBrandMap.keys.toList();
    final List<ProductModel> uniqueProducts = uniqueBrandMap.values.toList();

    final List<String> urls = products.map((product) => product.image).toList();

// Determine the number of items to display (only up to 4)
    final int count = math.min(4, uniqueBrands.length);

    return TGridLayoutBody(
      itemCount: count,
      mainAxisExtent: 80,
      itemBuilder: (_, index) {
        return TBrandCard(
          url: urls[index],
          brandName: uniqueProducts[index].brand,
          product: products[index],
          onTap: () => Get.to(() => BrandViewDetails(
                url: uniqueProducts[index].image,
                brandName: uniqueBrands[index],
                product: uniqueProducts[index],
              )),
          showBorder: false,
        );
      },
    );
  }
}
