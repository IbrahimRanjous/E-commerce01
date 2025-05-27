import 'package:flutter/material.dart';
import 'package:rjs_store/core/utils/constants/sizes.dart';
import '../../../core/widgets/section_heading.dart';
import '../../../core/widgets/user/user_controller.dart';
import 'widgets/home_app_bar.dart';
import 'widgets/home_body_heading.dart';
import 'widgets/home_categories.dart';
import 'widgets/grid_view.dart';
import 'widgets/primary_header_container.dart';
import 'widgets/search_container.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            // Call the fetch function to refresh user data.
            final controller = UserController.instance;
            await controller.fetchUserRecord();
          },
          child: CustomScrollView(
            physics:
                const AlwaysScrollableScrollPhysics(), // Ensures pull-to-refresh works
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    // -- Header Section
                    TPrimaryHeaderContainer(
                      child: Column(
                        children: [
                          THomeAppBar(),
                          SizedBox(height: TSizes.defaultSpace),
                          TSearchContainer(text: 'Search In Store'),
                          SizedBox(height: TSizes.defaultSpace),
                          Padding(
                            padding: EdgeInsets.only(left: TSizes.defaultSpace),
                            child: Column(
                              children: [
                                TSectionHeading(text: 'Popular Categories'),
                                SizedBox(height: TSizes.spaceBtwItems),
                                THomeCategories(),
                              ],
                            ),
                          ),
                          SizedBox(height: TSizes.spaceBtwSections),
                        ],
                      ),
                    ),
                    SizedBox(height: TSizes.spaceBtwSections),
                    // -- Products Heading
                    THomeBodyHeading(),
                    SizedBox(height: TSizes.spaceBtwSections),
                  ],
                ),
              ),
              // Wrap TGridView with a SliverToBoxAdapter to integrate it into the scroll view.
              SliverToBoxAdapter(
                child: TGridView(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
