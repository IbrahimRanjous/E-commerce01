import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:rjs_store/Features/Signin/data/repo/user_repository.dart';
import 'package:rjs_store/core/utils/constants/image_strings.dart';
import 'package:rjs_store/core/utils/constants/sizes.dart';
import 'package:rjs_store/core/utils/popups/loaders.dart';
import 'package:rjs_store/core/utils/repositories/authentication_repository.dart';
import 'package:rjs_store/core/widgets/Appbar/appbar.dart';
import 'package:rjs_store/core/widgets/images/t_rounded_image.dart';
import 'package:rjs_store/core/widgets/section_heading.dart';
import '../../../core/widgets/user/user_controller.dart';
import 'change_name.dart';
import 'widgets/custom_popup_dialog.dart';
import 'widgets/t_profile_menu.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    return Scaffold(
      appBar: const TAppbar(
        showBackArrow: true,
        title: Text('Profile'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              /// Profile Picture
              SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    const TRoundedImage(
                      url: TImages.user,
                      isNetworkImage: false,
                      imageWidth: 100,
                      imageHeight: 100,
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text('Change Profile Picture'),
                    ),
                  ],
                ),
              ),

              /// Detials
              const SizedBox(height: TSizes.spaceBtwItems / 2),
              const Divider(),
              const SizedBox(height: TSizes.spaceBtwItems),
              const TSectionHeading(
                  text: 'Profile Information', showActionButton: false),
              const SizedBox(height: TSizes.spaceBtwItems),

              TProfileMenu(
                  title: 'Name',
                  value: controller.user.value.fullName,
                  onPressed: () {
                    Get.to(() => ChangeName());
                  }),
              TProfileMenu(
                  title: 'User Name',
                  value: controller.user.value.userName,
                  onPressed: () {}),

              const SizedBox(height: TSizes.spaceBtwItems / 2),
              const Divider(),
              const SizedBox(height: TSizes.spaceBtwItems),

              /// Heaeding Personal Info
              const TSectionHeading(
                  text: 'Personal Information', showActionButton: false),
              const SizedBox(height: TSizes.spaceBtwItems),

              TProfileMenu(
                  title: 'User ID',
                  value: controller.user.value.id,
                  icon: Iconsax.copy,
                  onPressed: () {}),
              TProfileMenu(
                  title: 'E-Mail',
                  value: controller.user.value.email,
                  onPressed: () {}),
              TProfileMenu(
                  title: 'Phone Number',
                  value: '+963 ${controller.user.value.phoneNumber}',
                  onPressed: () {}),
              TProfileMenu(title: 'Gender', value: 'Male', onPressed: () {}),
              TProfileMenu(
                  title: 'Date Of Birth',
                  value: '14 , jan , 2004',
                  onPressed: () {}),
              const Divider(),

              const SizedBox(height: TSizes.spaceBtwItems),

              Center(
                child: TextButton(
                    onPressed: () => showCustomPopupDialog(context),
                    child: const Text('Delete Account',
                        style: TextStyle(color: Colors.red))),
              )
            ],
          ),
        ),
      ),
    );
  }

  void showCustomPopupDialog(BuildContext context) {
    showDialog<bool>(
      context: context,
      builder: (BuildContext context) => CustomPopupDialog(
        title: 'Delete Account',
        content:
            'We will delete all your stored data and your account from our service, Are you sure about that ?',
        onPressedCancel: () {
          Get.back();
        },
        onPressedOK: () {
          try {
            UserRepository.instance.removeUserRecord();
            AuthenticationRepository.Instance.logout();
            AuthenticationRepository.Instance.deleteFirebaseUser();
          } catch (e) {
            TLoaders.errorSnackBar(title: 'Ops!', message: e.toString());
          }
        },
      ),
    ).then((result) {
      // The result will be true if OK was pressed, false otherwise.
      if (result != null) {
        if (result) {
          // Handle action when OK was tapped.
          if (kDebugMode) {
            print('OK pressed!');
          }
        } else {
          // Handle action when Cancel was tapped.
          if (kDebugMode) {
            print('Cancel pressed!');
          }
        }
      }
    });
  }
}
