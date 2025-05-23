import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rjs_store/Features/login/views/login_view.dart';
import 'package:rjs_store/Features/login/views/widgets/custom_elevated_button.dart';
import 'package:rjs_store/Features/login/views/widgets/custom_material_button.dart';
import 'package:rjs_store/core/utils/constants/sizes.dart';
import 'package:rjs_store/core/utils/constants/texts.dart';
import '../../../core/utils/constants/image_strings.dart';
import '../../../core/utils/helpers/helper_functions.dart';
import '../../../core/widgets/spacing_styles.dart';

class PasswordResetView extends StatelessWidget {
  const PasswordResetView({super.key, required this.email});
  final String email;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () => Get.offAll(() => const LoginView()),
            icon: const Icon(CupertinoIcons.clear),
          )
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: TSpacingStyl.paddingWithAppBareHeight,
            child: Column(
              children: [
                // Image
                Center(
                  child: ClipRRect(
                    clipBehavior: Clip.antiAlias,
                    borderRadius: BorderRadius.circular(TSizes.cardRadiusLg),
                    child: Image(
                      image: THelperFunctions.isDarkMode(context)
                          ? const AssetImage(TImages.darkAppLogo)
                          : const AssetImage(TImages.lightAppLogo),
                      width: THelperFunctions.screenWidth() * 0.6,
                    ),
                  ),
                ),
                const SizedBox(height: TSizes.spaceBtwSections),

                // Title & SubTitle
                Text(TTexts.resetPasswordTitle,
                    style: Theme.of(context).textTheme.headlineMedium,
                    textAlign: TextAlign.center),
                const SizedBox(height: TSizes.spaceBtwItems),

                Text(email,
                    style: Theme.of(context).textTheme.labelLarge,
                    textAlign: TextAlign.center),
                const SizedBox(height: TSizes.spaceBtwItems),

                Text(TTexts.resetPasswordSubTitle,
                    style: Theme.of(context).textTheme.labelMedium,
                    textAlign: TextAlign.center),
                const SizedBox(height: TSizes.spaceBtwSections),

                // Buttons
                CustomMaterialButton(
                    onPressed: () {
                      Get.offAll(() => const LoginView());
                    },
                    title: TTexts.done),
                const SizedBox(height: TSizes.spaceBtwItems),

                CustomElevatedButton(
                    onPressed: () {}, title: TTexts.resendEmail),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
