import 'package:flutter/material.dart';
import '../../../../core/utils/constants/sizes.dart';
import 'checkout_title_price.dart';

class TOrderPriceSection extends StatelessWidget {
  const TOrderPriceSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const TCheckoutTitlePrice(title: 'Subtotal', price: 1464.0),
        const TCheckoutTitlePrice(title: 'Shipping Fee', price: 5.0),
        const TCheckoutTitlePrice(title: 'Tax Fee', price: 146.40),
        const SizedBox(height: TSizes.spaceBtwItems),
        TCheckoutTitlePrice(
          title: 'Order Total',
          price: 1615.4,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ],
    );
  }
}
