import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:rjs_store/Features/Signin/view/signup_view.dart';
import '../../../../core/utils/constants/colors.dart';
import '../../../../core/utils/constants/sizes.dart';
import '../../../../core/utils/constants/texts.dart';
import '../../../../core/utils/helpers/helper_functions.dart';
import '../../../../core/widgets/custom_text_form.dart';
import 'custom_elevated_button.dart';
import 'custom_material_button.dart';

class TForm extends StatelessWidget {
  const TForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    return Column(
      children: [
        Form(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: TSizes.spaceBtwSections),
            child: Column(
              children: [
                // Email
                const CustomTextForm(
                  prefixicon: Icon(Iconsax.direct_right),
                  hintText: TTexts.email,
                ),

                const SizedBox(height: TSizes.spaceBtwInputFields),

                // Password
                TextFormField(
                  autocorrect: true,
                  decoration: InputDecoration(
                      prefixIcon: const Icon(Iconsax.password_check),
                      suffixIcon: const Icon(Iconsax.eye_slash),
                      hintText: TTexts.password,
                      hintStyle: Theme.of(context).textTheme.titleSmall),
                ),

                const SizedBox(height: TSizes.spaceBtwInputFields / 2),
              ],
            ),
          ),
        ),
        // Remember me & Forget Password

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Remember me
            Row(
              children: [
                Checkbox(value: true, onChanged: (value) {}),
                const Text(TTexts.rememberMe),
              ],
            ),
            // Forget Password
            TextButton(
              onPressed: () {},
              child: Text(
                TTexts.forgetPassword,
                style: TextStyle(color: dark ? TColors.white : TColors.black),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: TSizes.spaceBtwSections,
        ),
        // Sign In
        CustomMaterialButton(
          text: TTexts.signIn,
          onPressed: () {},
        ),
        const SizedBox(
          height: TSizes.spaceBtwItems,
        ),
        // Create Account
        CustomElevatedButton(
          onPressed: () {
            Get.to(const SignupView());
          },
          title: TTexts.createAccount,
        ),
      ],
    );
  }
}
