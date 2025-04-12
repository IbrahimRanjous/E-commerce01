import 'package:flutter/material.dart';
import 'package:rjs_store/core/utils/constants/sizes.dart';
import 'package:rjs_store/core/widgets/products%20cart/cart_item.dart';
import 'package:rjs_store/core/widgets/text/product_price_text.dart';
import '../../../../core/widgets/products cart/add_remove_button.dart';

class TCartItems extends StatelessWidget {
  const TCartItems({
    super.key,
    this.showAddRemoveButtons = true,
  });

  final bool showAddRemoveButtons;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      separatorBuilder: (_, __) => const SizedBox(height: TSizes.spaceBtwItems),
      itemCount: 8,
      itemBuilder: (context, index) {
        return Column(
          children: [
            /// Cart Item
            const TCartItem(),

            if (showAddRemoveButtons)
              const SizedBox(height: TSizes.spaceBtwItems),

            /// Add Remove Button Row with total price
            if (showAddRemoveButtons)
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      /// Extra Space
                      SizedBox(width: 70),

                      /// Add Remove Buttons
                      TProductQuantityWithAddRemoveButton(),
                    ],
                  ),
                  TProductPriceText(price: '256'),
                ],
              ),
          ],
        );
      },
    );
  }
}
