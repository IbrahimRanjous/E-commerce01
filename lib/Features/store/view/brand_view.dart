import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rjs_store/Features/store/view/widgets/t_brand_card.dart';
import 'package:rjs_store/core/utils/constants/sizes.dart';
import 'package:rjs_store/core/utils/helpers/helper_functions.dart';
import 'package:rjs_store/core/widgets/Appbar/appbar.dart';
import '../../../core/product_model.dart';
import '../../../core/widgets/grid layout/t_grid_lay_out_body.dart';
import '../../../core/widgets/stored_data_parse.dart';
import '../../../core/widgets/text/my_text.dart';
import '../../../core/widgets/user/user_controller.dart';
import 'brand_view_details.dart';

class BrandView extends StatelessWidget {
  const BrandView({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = THelperFunctions.screenWidth();
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

    return Scaffold(
      appBar: const TAppbar(
        title: Text('Brand'),
        showBackArrow: true,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) => SingleChildScrollView(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Brands',
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.start,
              ),
              const SizedBox(height: TSizes.spaceBtwInputFields),
              TGridLayoutBody(
                mainAxisExtent: screenWidth * 0.2,
                itemCount: uniqueBrands.length,
                itemBuilder: (_, index) {
                  return GestureDetector(
                    onTap: () => Get.to(() => BrandViewDetails(
                          url: uniqueProducts[index].image,
                          brandName: uniqueBrands[index],
                          product: uniqueProducts[index],
                        )),
                    child: TBrandCard(
                      showBorder: true,
                      url: uniqueProducts[index].image,
                      brandName: uniqueBrands[index],
                      product: uniqueProducts[index],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
