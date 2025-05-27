import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:iconsax/iconsax.dart';
import 'package:rjs_store/Features/card/view/cart_view.dart';
import 'package:rjs_store/Features/home/views/widgets/primary_header_container.dart';
import 'package:rjs_store/Features/login/views/widgets/custom_material_button.dart';
import 'package:rjs_store/Features/settings/view/profile_view.dart';
import 'package:rjs_store/Features/settings/view/user_addressed_view.dart';
import 'package:rjs_store/Features/settings/view/widgets/settings_menu_tile.dart';
import 'package:rjs_store/core/utils/constants/colors.dart';
import 'package:rjs_store/core/utils/constants/sizes.dart';
import 'package:rjs_store/core/utils/constants/texts.dart';
import 'package:rjs_store/core/widgets/Appbar/appbar.dart';
import 'package:rjs_store/core/widgets/section_heading.dart';
import '../../../core/utils/popups/loaders.dart';
import '../../../core/utils/repositories/authentication_repository.dart';
import 'orders_view.dart';
import 'widgets/user_profile_tile.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    final localeData = GetStorage();
    RxBool isGeolocation =
        RxBool(localeData.read(TTexts.kisGeolocation) ?? false);
    RxBool isSafeMode = RxBool(localeData.read(TTexts.kisSafeMode) ?? false);
    RxBool isHDImageQuality =
        RxBool(localeData.read(TTexts.kisHDImageQuality) ?? false);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              /// -- Header -- ///
              TPrimaryHeaderContainer(
                child: Column(
                  children: [
                    /// AppBar
                    TAppbar(
                      title: Text(
                        'Settings',
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium!
                            .apply(color: TColors.white),
                      ),
                    ),
                    const SizedBox(height: TSizes.spaceBtwSections),

                    /// User Profile Card
                    TUserProfileTile(
                      onPressed: () => Get.to(() => const ProfileView()),
                    ),
                    const SizedBox(height: TSizes.spaceBtwSections),
                  ],
                ),
              ),

              /// -- Body
              Padding(
                padding: const EdgeInsets.all(TSizes.defaultSpace),
                child: Column(
                  children: [
                    /// -- Account Settings
                    const TSectionHeading(text: 'Account Settings'),
                    const SizedBox(height: TSizes.spaceBtwItems),
                    TSettingsMenuTile(
                      icon: Iconsax.safe_home,
                      title: 'My Addresses',
                      subTitle: 'Set shopping delivery address',
                      onTap: () {
                        Get.to(() => const UserAddressedView());
                      },
                    ),
                    TSettingsMenuTile(
                      icon: Iconsax.shopping_cart,
                      title: 'My Cart',
                      subTitle: 'Add, remove products and move to checkout',
                      onTap: () {
                        Get.to(() => const CartView());
                      },
                    ),
                    TSettingsMenuTile(
                      icon: Iconsax.bag_tick,
                      title: 'My Orders',
                      subTitle: 'In-progress and Completed Orders',
                      onTap: () {
                        Get.to(() => const OrdersView());
                      },
                    ),
                    const TSettingsMenuTile(
                      icon: Iconsax.bank,
                      title: 'Bank Account',
                      subTitle: 'Withdraw balance to registered bank account',
                    ),
                    const TSettingsMenuTile(
                      icon: Iconsax.discount_shape,
                      title: 'My Coupons',
                      subTitle: 'List of all the discounted coupons',
                    ),
                    const TSettingsMenuTile(
                      icon: Iconsax.notification,
                      title: 'Notifications',
                      subTitle: 'Set any kind of notification message',
                    ),
                    const TSettingsMenuTile(
                      icon: Iconsax.security_card,
                      title: 'Account Privacy',
                      subTitle: 'Manage data usage and connected accounts',
                    ),

                    /// -- App Settings
                    const SizedBox(height: TSizes.spaceBtwSections),
                    const TSectionHeading(text: 'App Settings'),
                    const SizedBox(height: TSizes.spaceBtwItems),
                    TSettingsMenuTile(
                      onTap: () {},
                      icon: Iconsax.document_upload,
                      title: 'Load Data',
                      subTitle: 'Upload Data to your Cloud Firebase',
                    ),

                    Obx(
                      () => TSettingsMenuTile(
                        icon: Iconsax.location,
                        title: 'Geolocation',
                        subTitle: 'Set recommendation based on location',
                        trailing: Switch(
                            value: isGeolocation.value,
                            onChanged: (value) {
                              isGeolocation.value = value;
                              localeData.write(
                                  TTexts.kisGeolocation, isGeolocation.value);
                            }),
                      ),
                    ),
                    Obx(
                      () => TSettingsMenuTile(
                        icon: Iconsax.security_user,
                        title: 'Safe Mode',
                        subTitle: 'Search result is safe for all ages',
                        trailing: Switch(
                            value: isSafeMode.value,
                            onChanged: (value) {
                              isSafeMode.value = value;
                              localeData.write(
                                  TTexts.kisSafeMode, isSafeMode.value);
                            }),
                      ),
                    ),
                    Obx(
                      () => TSettingsMenuTile(
                        icon: Iconsax.image,
                        title: 'HD Image Quality',
                        subTitle: 'Set image quality to be seen',
                        trailing: Switch(
                            value: isHDImageQuality.value,
                            onChanged: (value) {
                              isHDImageQuality.value = value;
                              localeData.write(TTexts.kisHDImageQuality,
                                  isHDImageQuality.value);
                            }),
                      ),
                    ),

                    /// -- Logout Button

                    const SizedBox(height: TSizes.spaceBtwSections),
                    CustomMaterialButton(
                        onPressed: () {
                          try {
                            AuthenticationRepository.Instance.logout();
                          } catch (e) {
                            TLoaders.errorSnackBar(
                                title: 'Error', message: 'Loggout problem');
                          }
                        },
                        title: 'Log Out'),
                    const SizedBox(height: TSizes.spaceBtwSections * 2.5),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
