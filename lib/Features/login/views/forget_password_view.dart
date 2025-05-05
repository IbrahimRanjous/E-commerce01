import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:rjs_store/Features/login/views/widgets/custom_material_button.dart';
import 'package:rjs_store/core/utils/constants/texts.dart';
import 'package:rjs_store/core/widgets/spacing_styles.dart';
import '../../../core/utils/constants/sizes.dart';
import '../../../core/widgets/custom_text_form.dart';
import 'password_reset_view.dart';

class ForgetPasswordView extends StatelessWidget {
  const ForgetPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: TSpacingStyl.paddingWithAppBareHeight,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Title & SubTitle
              Text(TTexts.forgetPasswordTitle,
                  style: Theme.of(context).textTheme.headlineMedium,
                  textAlign: TextAlign.start),
              const SizedBox(height: TSizes.spaceBtwItems),

              Text(TTexts.forgetPasswordSubTitle,
                  style: Theme.of(context).textTheme.labelLarge,
                  textAlign: TextAlign.start),

              const SizedBox(height: TSizes.spaceBtwSections),
              // Text Field
              const CustomTextForm(
                prefixicon: Icon(Iconsax.direct_right),
                hintText: TTexts.email,
              ),
              const SizedBox(height: TSizes.spaceBtwItems),

              // Submit Button
              CustomMaterialButton(
                  title: TTexts.submit,
                  onPressed: () {
                    Get.to(const PasswordResetView());
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
