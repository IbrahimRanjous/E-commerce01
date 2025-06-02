import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rjs_store/Features/home/views/widgets/search_container.dart';
import 'package:rjs_store/Features/store/view/brand_view.dart';
import 'package:rjs_store/core/utils/constants/colors.dart';
import 'package:rjs_store/core/utils/constants/sizes.dart';
import 'package:rjs_store/core/utils/helpers/helper_functions.dart';
import 'package:rjs_store/core/widgets/Appbar/appbar.dart';
import 'package:rjs_store/core/widgets/Appbar/tabbar.dart';
import 'package:rjs_store/core/widgets/products%20cart/cart_menu_icon.dart';
import 'package:rjs_store/core/widgets/section_heading.dart';
import 'widgets/store_grid_view_body.dart';
import 'widgets/t_category_tap.dart';

class StoreView extends StatelessWidget {
  const StoreView({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
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
                          onPressed: () => Get.to(() => const BrandView()),
                        ),
                        const SizedBox(height: TSizes.spaceBtwItems / 2),
                        // -- Brand Grid
                        const TStoreGridViewbody(),
                      ],
                    ),
                  ),
                  ///////// ----- Tabs ----- /////////
                  bottom: const TTabBar(
                    tabs: [
                      Tab(child: Text('Sports')),
                      Tab(child: Text('Furniture')),
                      Tab(child: Text('Electronics')),
                      Tab(child: Text('Clothes')),
                      Tab(child: Text('Cosmetics')),
                    ],
                  ),
                ),
              ];
            },
            body: const TabBarView(
              children: [
                TCategoryTap(
                  categoryFilter: 'Sports',
                ),
                TCategoryTap(
                  categoryFilter: 'Furniture',
                ),
                TCategoryTap(
                  categoryFilter: 'Electronics',
                ),
                TCategoryTap(
                  categoryFilter: 'Clothes',
                ),
                TCategoryTap(
                  categoryFilter: 'Cosmetics',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
