import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:rjs_store/Features/settings/view/change_email.dart';
import 'package:rjs_store/Features/settings/view/change_phone.dart';
import 'package:rjs_store/Features/settings/view/change_d_o_b.dart';
import 'package:rjs_store/core/utils/constants/image_strings.dart';
import 'package:rjs_store/core/utils/constants/sizes.dart';
import 'package:rjs_store/core/widgets/Appbar/appbar.dart';
import 'package:rjs_store/core/widgets/images/t_rounded_image.dart';
import 'package:rjs_store/core/widgets/section_heading.dart';
import '../../../core/widgets/user/user_controller.dart';
import 'change_name.dart';
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

              Obx(
                () => TProfileMenu(
                    title: 'Name',
                    value: controller.user.value.fullName,
                    onPressed: () {
                      Get.to(() => ChangeName());
                    }),
              ),

              TProfileMenu(
                  icon: Iconsax.copy,
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
              Obx(
                () => TProfileMenu(
                    title: 'E-Mail',
                    value: controller.user.value.email,
                    onPressed: () {
                      // Add some logic for authentication + changing the account on firebase
                      Get.to(() => const ChangeEmail());
                    }),
              ),
              Obx(
                () => TProfileMenu(
                    title: 'Phone Number',
                    value: '+963 ${controller.user.value.phoneNumber}',
                    onPressed: () {
                      Get.to(() => ChangePhone());
                    }),
              ),
              TProfileMenu(
                  title: 'Gender', value: 'Not selected', onPressed: () {}),
              Obx(
                () => TProfileMenu(
                  title: 'Date Of Birth',
                  value: DateFormat('dd/MM/yyyy').format(
                      controller.user.value.dateOfBirth?.toLocal() ??
                          DateTime.now()),
                  onPressed: () {
                    Get.to(() => const ChangeDOB());
                  },
                ),
              ),
              const Divider(),

              const SizedBox(height: TSizes.spaceBtwItems),

              Center(
                child: TextButton(
                    onPressed: () => controller..deleteAccountWarningPopup(),
                    child: const Text('Delete Account',
                        style: TextStyle(color: Colors.red))),
              )
            ],
          ),
        ),
      ),
    );
  }
}
