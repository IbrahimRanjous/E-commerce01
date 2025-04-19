import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rjs_store/core/utils/constants/colors.dart';
import 'package:rjs_store/core/utils/constants/image_strings.dart';
import 'package:rjs_store/core/utils/constants/sizes.dart';
import 'package:rjs_store/core/widgets/Appbar/appbar.dart';
import 'package:rjs_store/core/widgets/section_heading.dart';
import '../../../core/productsList.dart';
import '../../../core/widgets/images/t_rounded_image.dart';
import '../../../core/widgets/products cart/horizontal_product_card.dart';
import '../../product details/view/product_detail_view.dart';

class SubCategoriesView extends StatelessWidget {
  const SubCategoriesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TAppbar(
        title: Text('Sports shirts'),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          children: [
            /// Banner
            const TRoundedImage(
              url: TImages.banner3,
              isNetworkImage: false,
              borderRadius: TSizes.cardRadiusLg,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: TSizes.spaceBtwItems),

            /// Sub-Categories
            const TSectionHeading(
              text: 'Sport shoes',
              showActionButton: true,
              buttonColor: TColors.primary,
            ),
            const SizedBox(height: TSizes.spaceBtwItems),

            SizedBox(
              height: 120,
              child: ListView.separated(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: ProductsList.products.length,
                separatorBuilder: (_, __) =>
                    const SizedBox(width: TSizes.spaceBtwItems / 4),
                itemBuilder: (BuildContext context, int index) {
                  final product = ProductsList.products[index];

                  return THorizontalProductCard(
                    imageUrl: product['imageUrl']!,
                    productTitle: product['productTitle']!,
                    brand: product['brand']!,
                    priceRange: product['priceRange']!,
                    discountText: '75%',
                    isVerified: true,
                    isFavorite: true,
                    // quantity: '5',
                    onFavoriteTap: () {},
                    onTap: () {
                      Get.to(() => const ProductDetailView());
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
