import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:rjs_store/core/utils/constants/image_strings.dart';
import 'package:rjs_store/core/utils/constants/sizes.dart';
import 'package:rjs_store/core/widgets/Appbar/appbar.dart';
import 'package:rjs_store/core/widgets/grid%20layout/t_grid_lay_out.dart';
import '../../home/views/widgets/card_product_item.dart';

class WhishListView extends StatelessWidget {
  const WhishListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppbar(
        title: Text(
          'Whishlist',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        actions: const [Icon(Iconsax.add)],
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: TGridLayout(
            itemCount: 6,
            itemBuilder: (BuildContext context, int index) {
              return const TVerticalProductCard(
                imageUrl: TImages.productImage1,
                productTitle: 'Green Nike Sports Shoe',
                brand: 'Nike',
                priceRange: '\$122.6 - \$334.0',
                isFavorite: true,
                isVerified: true,
                quantity: '4',
              );
            }),
      )),
    );
  }
}
