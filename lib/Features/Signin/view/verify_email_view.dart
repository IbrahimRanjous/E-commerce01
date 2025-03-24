import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rjs_store/Features/Signin/view/success_view.dart';
import 'package:rjs_store/Features/login/views/login_view.dart';
import 'package:rjs_store/Features/login/views/widgets/custom_elevated_button.dart';
import 'package:rjs_store/Features/login/views/widgets/custom_material_button.dart';
import 'package:rjs_store/core/utils/constants/images_strings.dart';
import 'package:rjs_store/core/utils/constants/sizes.dart';
import 'package:rjs_store/core/utils/constants/texts.dart';
import '../../../core/utils/helpers/helper_functions.dart';
import '../../../core/widgets/spacing_styles.dart';

class VerifyEmailView extends StatelessWidget {
  const VerifyEmailView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () => Get.offAll(const LoginView()),
            icon: const Icon(CupertinoIcons.clear),
          )
        ],
      ),
      body: SingleChildScrollView(
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
                    image: const AssetImage(TImages.verifyEmail),
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

              Text("ibrahim.ranjous@gmail.com",
                  style: Theme.of(context).textTheme.labelLarge,
                  textAlign: TextAlign.center),
              const SizedBox(height: TSizes.spaceBtwItems),

              Text(TTexts.confirmEmailSubTitle,
                  style: Theme.of(context).textTheme.labelMedium,
                  textAlign: TextAlign.center),
              const SizedBox(height: TSizes.spaceBtwSections),

              // Buttons
              CustomMaterialButton(
                  onPressed: () {
                    Get.to(
                      () => SuccessView(
                        onPressed: () {
                          Get.offAll(() => const LoginView());
                        },
                        image: TImages.success,
                        title: TTexts.yourAccountCreatedTitle,
                        subTitle: TTexts.yourAccountCreatedSubTitle,
                      ),
                    );
                  },
                  title: TTexts.Continue),
              const SizedBox(height: TSizes.spaceBtwItems),

              CustomElevatedButton(onPressed: () {}, title: TTexts.resendEmail),
            ],
          ),
        ),
      ),
    );
  }
}
