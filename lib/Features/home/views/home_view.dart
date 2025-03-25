import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:rjs_store/core/utils/constants/colors.dart';
import 'package:rjs_store/core/utils/constants/sizes.dart';
import 'package:rjs_store/core/utils/device/device_utility.dart';
import 'widgets/home_app_bar.dart';
import 'widgets/primary_header_container.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
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
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: TSizes.defaultSpace),
                    child: Container(
                      width: TDeviceUtils.getScreenWidth(context),
                      padding: const EdgeInsets.all(TSizes.md),
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(TSizes.cardRadiusLg),
                        border: Border.all(color: TColors.grey),
                      ),
                      child: const Row(
                        children: [
                          Icon(
                            Iconsax.search_normal,
                            color: TColors.grey,
                          ),
                        ],
                      ),
                    ),
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
