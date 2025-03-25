import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:rjs_store/core/utils/constants/colors.dart';
import 'package:rjs_store/core/utils/constants/sizes.dart';
import 'package:rjs_store/core/utils/device/device_utility.dart';
import 'package:rjs_store/core/utils/helpers/helper_functions.dart';
import 'widgets/home_app_bar.dart';
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

                  // -- Categories
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
