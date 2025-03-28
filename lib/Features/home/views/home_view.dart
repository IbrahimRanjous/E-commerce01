import 'package:flutter/material.dart';
import 'package:rjs_store/Features/home/views/widgets/custom_carousel_slider.dart';
import 'package:rjs_store/core/utils/constants/sizes.dart';
import '../../../core/widgets/section_heading.dart';
import 'widgets/home_app_bar.dart';
import 'widgets/home_body_heading.dart';
import 'widgets/home_categories.dart';
import 'widgets/home_grid_view.dart';
import 'widgets/primary_header_container.dart';
import 'widgets/search_container.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

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
                  TSearchContainer(
                    text: 'Search In Store',
                  ),
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
                ],
              ),
            ),

///////////////////////////////////////////// Body Home Screen //////////////////////////////////////////////////////
            MySliderImage(),
            SizedBox(height: TSizes.spaceBtwSections),

            // -- Products
            THomeBodyHeading(),
            SizedBox(height: TSizes.spaceBtwSections),

            THomeGridView(),
////////////////////////////////////////////////////////////////////////////////////////////////////
          ],
        ),
      ),
    );
  }
}
