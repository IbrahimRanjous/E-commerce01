import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:rjs_store/core/utils/constants/image_strings.dart';
import 'package:rjs_store/core/utils/constants/sizes.dart';
import 'package:rjs_store/core/widgets/Appbar/appbar.dart';
import 'package:rjs_store/core/widgets/images/t_circular_image.dart';
import 'package:rjs_store/core/widgets/section_heading.dart';
import 'widgets/t_profile_menu.dart';

class AccountView extends StatelessWidget {
  const AccountView({super.key});

  @override
  Widget build(BuildContext context) {
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
                    const TCircularImage(
                      url: TImages.user,
                      isNetworkImage: false,
                      imageWidth: 100,
                      imgaeHeight: 100,
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

              TProfileMenu(title: 'Name', value: 'Ibrahim', onPressed: () {}),
              TProfileMenu(
                  title: 'User Name', value: 'ibrahim_rjs', onPressed: () {}),

              const SizedBox(height: TSizes.spaceBtwItems / 2),
              const Divider(),
              const SizedBox(height: TSizes.spaceBtwItems),

              /// Heaeding Personal Info
              const TSectionHeading(
                  text: 'Personal Information', showActionButton: false),
              const SizedBox(height: TSizes.spaceBtwItems),

              TProfileMenu(
                  title: 'User ID',
                  value: '12345',
                  icon: Iconsax.copy,
                  onPressed: () {}),
              TProfileMenu(
                  title: 'E-Mail',
                  value: 'ibrahim.ranjous@gmail.com',
                  onPressed: () {}),
              TProfileMenu(
                  title: 'Phone Number',
                  value: '00963994758255',
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
                    onPressed: () {},
                    child: const Text('Close Account',
                        style: TextStyle(color: Colors.red))),
              )
            ],
          ),
        ),
      ),
    );
  }
}
