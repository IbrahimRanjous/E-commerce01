import 'package:flutter/material.dart';
import 'package:rjs_store/Features/home/views/widgets/search_container.dart';
import 'package:rjs_store/core/utils/constants/colors.dart';
import 'package:rjs_store/core/utils/constants/sizes.dart';
import 'package:rjs_store/core/utils/helpers/helper_functions.dart';
import 'package:rjs_store/core/widgets/Appbar/appbar.dart';
import 'package:rjs_store/core/widgets/products%20cart/cart_menu_icon.dart';
import 'package:rjs_store/core/widgets/section_heading.dart';
import 'widgets/store_grid_view_body.dart';

class StoreView extends StatelessWidget {
  const StoreView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// -- AppBar -- //
      appBar: TAppbar(
        title: Text(
          'Store',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        actions: [TCardCounterIcon(onPreessed: () {})],
      ),
      body: SafeArea(
        child: NestedScrollView(
          ///////// ----- Header ----- /////////
          headerSliverBuilder: (_, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                automaticallyImplyLeading: false,
                pinned: true,
                floating: true,
                backgroundColor: THelperFunctions.isDarkMode(context)
                    ? TColors.dark
                    : TColors.light,
                expandedHeight: 440,
                flexibleSpace: Padding(
                  padding: const EdgeInsets.all(TSizes.defaultSpace),
                  child: ListView(
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      // -- Search Bar
                      const SizedBox(height: TSizes.spaceBtwItems),
                      const TSearchContainer(
                          text: 'Search In Store',
                          showBorder: true,
                          showBackground: false,
                          padding: EdgeInsets.zero),
                      const SizedBox(height: TSizes.spaceBtwSections),

                      // -- Featured Brands
                      TSectionHeading(
                          text: 'Featured Brands',
                          showActionButton: true,
                          buttonColor: TColors.buttonPrimary,
                          onPressed: () {}),
                      const SizedBox(height: TSizes.spaceBtwItems / 2),
                      // -- Brand Grid
                      const TStoreGridViewbody(),
                    ],
                  ),
                ),
              ),
            ];
          },
          body: Container(),
        ),
      ),
    );
  }
}
