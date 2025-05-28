import 'package:flutter/material.dart';
import 'package:rjs_store/core/utils/constants/sizes.dart';
import 'package:rjs_store/core/widgets/user/user_controller.dart';
import '../../../core/widgets/section_heading.dart';
import 'widgets/home_app_bar.dart';
import 'widgets/home_body_heading.dart';
import 'widgets/home_categories.dart';
import 'widgets/grid_view.dart';
import 'widgets/primary_header_container.dart';
import 'widgets/search_container.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  // A simple refresh function.
  Future<void> _onRefresh() async {
    // Add your refresh logic here, such as reloading data.
    await UserController.instance.fetchUserRecord();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: _onRefresh,
          child: SingleChildScrollView(
            // Always allow scroll, so the refresh gesture is always active.
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              children: [
                // Header
                TPrimaryHeaderContainer(
                  child: Column(
                    children: [
                      // -- Appbar
                      const THomeAppBar(),
                      const SizedBox(height: TSizes.defaultSpace),

                      // -- Searchbar
                      const TSearchContainer(text: 'Search In Store'),
                      const SizedBox(height: TSizes.defaultSpace),

                      // -- Categories
                      const Padding(
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

                      const SizedBox(height: TSizes.spaceBtwSections),
                    ],
                  ),
                ),

                ////////////////////////// Body Home Screen ///////////////////////////
                const SizedBox(height: TSizes.spaceBtwSections),

                // -- Products
                const THomeBodyHeading(),
                const SizedBox(height: TSizes.spaceBtwSections),

                const TGridView(),

                /////////////////////////////////////////////////////////////////////
              ],
            ),
          ),
        ),
      ),
    );
  }
}
