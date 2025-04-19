import 'package:flutter/material.dart';
import 'package:rjs_store/core/utils/constants/sizes.dart';
import '../../../core/widgets/section_heading.dart';
import 'widgets/home_app_bar.dart';
import 'widgets/home_body_heading.dart';
import 'widgets/home_categories.dart';
import 'widgets/grid_view.dart';
import 'widgets/primary_header_container.dart';
import 'widgets/search_container.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header
            TPrimaryHeaderContainer(
              child: Column(
                children: [
                  // -- Appbar
                  THomeAppBar(),
                  SizedBox(height: TSizes.defaultSpace),

                  // -- Searchbar
                  TSearchContainer(text: 'Search In Store'),
                  SizedBox(height: TSizes.defaultSpace),

                  // -- Categories
                  Padding(
                    padding: EdgeInsets.only(
                      left: TSizes.defaultSpace,
                    ),
                    child: Column(
                      children: [
                        /// -- Heading
                        TSectionHeading(
                          text: 'Popular Categories',
                        ),
                        SizedBox(height: TSizes.spaceBtwItems),

                        /// -- Categories
                        THomeCategories(),
                      ],
                    ),
                  ),

                  SizedBox(height: TSizes.spaceBtwSections),
                ],
              ),
            ),

////////////////////////// Body Home Screen ///////////////////////////
            SizedBox(height: TSizes.spaceBtwSections),

            // -- Products
            THomeBodyHeading(),
            SizedBox(height: TSizes.spaceBtwSections),

            TGridView(),

///////////////////////////////////////////////////////////////////////
          ],
        ),
      ),
    );
  }
}
