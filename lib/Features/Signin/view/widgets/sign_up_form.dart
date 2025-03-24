import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:rjs_store/Features/Signin/view/verify_email_view.dart';
import '../../../../core/utils/constants/sizes.dart';
import '../../../../core/utils/constants/texts.dart';
import '../../../../core/widgets/custom_text_form.dart';
import '../../../login/views/widgets/custom_material_button.dart';
import 'privace_and_terms_form.dart';

class TSingUpForm extends StatelessWidget {
  const TSingUpForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // First Name & Last Name
          const Row(
            children: [
              Expanded(
                child: CustomTextForm(
                    prefixicon: Icon(Iconsax.user), hintText: TTexts.firstName),
              ),
              SizedBox(
                width: TSizes.spaceBtwInputFields,
              ),
              Expanded(
                child: CustomTextForm(
                    prefixicon: Icon(Iconsax.user), hintText: TTexts.lastName),
              ),
            ],
          ),
          const SizedBox(height: TSizes.spaceBtwInputFields),

          // Username
          const CustomTextForm(
              prefixicon: Icon(Iconsax.user_edit), hintText: TTexts.username),

          const SizedBox(height: TSizes.spaceBtwInputFields),
          // E-Mail
          const CustomTextForm(
              prefixicon: Icon(Iconsax.direct), hintText: TTexts.email),

          const SizedBox(height: TSizes.spaceBtwInputFields),

          // Phone Number
          const CustomTextForm(
              prefixicon: Icon(Iconsax.call), hintText: TTexts.phoneNu),
          const SizedBox(height: TSizes.spaceBtwInputFields),

          // Password
          TextFormField(
            autocorrect: true,
            obscureText: true,
            decoration: InputDecoration(
                prefixIcon: const Icon(Iconsax.password_check),
                suffixIcon: const Icon(Iconsax.eye_slash),
                hintText: TTexts.password,
                hintStyle: Theme.of(context).textTheme.titleSmall),
          ),
          const SizedBox(height: TSizes.spaceBtwSections),

          // Privacy Policy & Terms of use
          const PrivacyPolicyAndTermsofUse(),
          const SizedBox(height: TSizes.spaceBtwSections),

          // Create Account Button
          CustomMaterialButton(
            onPressed: () {
              Get.to(() => const VerifyEmailView());
            },
            title: TTexts.createAccount,
          ),
          const SizedBox(height: TSizes.spaceBtwSections),
        ],
      ),
    );
  }
}
