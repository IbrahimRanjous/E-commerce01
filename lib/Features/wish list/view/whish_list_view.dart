import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:rjs_store/Features/wish%20list/view/widgets/wish_list_view_body.dart';
import 'package:rjs_store/core/utils/constants/sizes.dart';
import 'package:rjs_store/core/widgets/Appbar/appbar.dart';

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
      body: const SafeArea(
          child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: TSizes.sm),
        child: WishListViewBody(),
      )),
    );
  }
}
