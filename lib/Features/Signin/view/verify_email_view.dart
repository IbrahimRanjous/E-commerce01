import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rjs_store/Features/Signin/data/cubit/verify_email_controller.dart';
import 'package:rjs_store/Features/login/views/widgets/custom_elevated_button.dart';
import 'package:rjs_store/Features/login/views/widgets/custom_material_button.dart';
import 'package:rjs_store/core/utils/constants/sizes.dart';
import 'package:rjs_store/core/utils/constants/texts.dart';
import 'package:rjs_store/core/utils/repositories/authentication_repository.dart';
import '../../../core/utils/constants/image_strings.dart';
import '../../../core/utils/helpers/helper_functions.dart';
import '../../../core/widgets/spacing_styles.dart';

class VerifyEmailView extends StatelessWidget {
  const VerifyEmailView({super.key, this.email});

  final String? email;
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(VerifyEmailController());
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () => AuthenticationRepository.Instance.logout(),
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
                      image: const AssetImage(TImages.verifyIllustration),
                      width: THelperFunctions.screenWidth() * 0.6,
                    ),
                  ),
                ),
                const SizedBox(height: TSizes.spaceBtwSections),

                // Title & SubTitle
                Text(TTexts.confirmEmailTitle,
                    style: Theme.of(context).textTheme.headlineMedium,
                    textAlign: TextAlign.center),
                const SizedBox(height: TSizes.spaceBtwItems),

                Text(email ?? '',
                    style: Theme.of(context).textTheme.labelLarge,
                    textAlign: TextAlign.center),
                const SizedBox(height: TSizes.spaceBtwItems),

                Text(TTexts.confirmEmailSubTitle,
                    style: Theme.of(context).textTheme.labelMedium,
                    textAlign: TextAlign.center),
                const SizedBox(height: TSizes.spaceBtwSections),

                // Buttons
                CustomMaterialButton(
                    onPressed: () => controller.checkEmailVerificationStatus(),
                    title: TTexts.Continue),
                const SizedBox(height: TSizes.spaceBtwItems),

                CustomElevatedButton(
                    onPressed: () {
                      controller.sendEmailVerification();
                    },
                    title: TTexts.resendEmail),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
