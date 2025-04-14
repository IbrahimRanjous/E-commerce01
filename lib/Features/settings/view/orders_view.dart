import 'package:flutter/material.dart';
import 'package:rjs_store/core/utils/constants/sizes.dart';
import 'package:rjs_store/core/widgets/Appbar/appbar.dart';

import 'widgets/order_card.dart';

class OrdersView extends StatelessWidget {
  const OrdersView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TAppbar(
        title: Text('My Orders'),
        showBackArrow: true,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        itemCount: 5,
        separatorBuilder: (_, __) =>
            const SizedBox(height: TSizes.spaceBtwItems),
        itemBuilder: (_, index) => const TOrderCard(),
      ),
    );
  }
}
