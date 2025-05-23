import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:rjs_store/Features/home/views/home_view.dart';
import 'package:rjs_store/Features/settings/view/settings_view.dart';
import 'package:rjs_store/Features/store/view/store_view.dart';
import 'package:rjs_store/Features/wish%20list/view/whish_list_view.dart';
import 'package:rjs_store/core/utils/constants/colors.dart';
import 'package:rjs_store/core/utils/helpers/helper_functions.dart';

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());
    final darkMode = THelperFunctions.isDarkMode(context);

    return Scaffold(
      bottomNavigationBar: Obx(
        () => NavigationBar(
          height: 80,
          elevation: 0,
          selectedIndex: controller.selectedIndex.value,
          onDestinationSelected: (index) =>
              controller.selectedIndex.value = index,
          backgroundColor: darkMode ? TColors.dark : TColors.light,
          indicatorColor: darkMode
              ? TColors.light.withValues(alpha: 0.1)
              : TColors.dark.withValues(alpha: 0.1),
          destinations: const [
            NavigationDestination(
              icon: Icon(Iconsax.home),
              label: "Home",
            ),
            NavigationDestination(
              icon: Icon(Iconsax.shop),
              label: "Store",
            ),
            NavigationDestination(
              icon: Icon(Iconsax.heart),
              label: "Whish List",
            ),
            NavigationDestination(
              icon: Icon(Iconsax.user),
              label: "Settings",
            ),
          ],
        ),
      ),
      body: Obx(
        () => IndexedStack(
          index: controller.selectedIndex.value,
          children: controller.screens,
        ),
      ),
    );
  }
}

class NavigationController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;
  final List<Widget> screens = const [
    HomeView(),
    StoreView(),
    WhishListView(),
    SettingsView(),
  ];
}
