import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:rjs_store/Features/Signin/view/signup_view.dart';
import 'package:rjs_store/Features/login/data/cubit/login_controller.dart';
import 'package:rjs_store/Features/login/views/forget_password_view.dart';
import 'package:rjs_store/core/utils/validators/validation.dart';
import '../../../../core/utils/constants/colors.dart';
import '../../../../core/utils/constants/sizes.dart';
import '../../../../core/utils/constants/texts.dart';
import '../../../../core/utils/helpers/helper_functions.dart';
import '../../../../core/widgets/custom_text_form.dart';
import 'custom_elevated_button.dart';
import 'custom_material_button.dart';

class TLoginForm extends StatelessWidget {
  const TLoginForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final controller = Get.put(LoginController());

    return Column(
      children: [
        Form(
          key: controller.loginFormKey,
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: TSizes.spaceBtwSections),
            child: Column(
              children: [
                // Email
                CustomTextForm(
                  controller: controller.email,
                  validator: (value) => TValidator.validateEmail(value),
                  prefixicon: const Icon(Iconsax.direct_right),
                  hintText: TTexts.email,
                ),

                const SizedBox(height: TSizes.spaceBtwInputFields),

                // Password
                Obx(
                  () => TextFormField(
                    autocorrect: true,
                    obscureText: controller.hidePassword.value,
                    controller: controller.password,
                    validator: (value) => TValidator.validatePassword(value),
                    decoration: InputDecoration(
                        prefixIcon: const Icon(Iconsax.password_check),
                        suffixIcon: IconButton(
                            onPressed: () {
                              controller.hidePassword.value =
                                  !controller.hidePassword.value;
                            },
                            icon: controller.hidePassword.value
                                ? const Icon(Iconsax.eye_slash)
                                : const Icon(Iconsax.eye)),
                        hintText: TTexts.password,
                        hintStyle: Theme.of(context).textTheme.titleSmall),
                  ),
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
                Obx(
                  () => Checkbox(
                      value: controller.rememberMe.value,
                      onChanged: (value) {
                        controller.rememberMe.value =
                            !controller.rememberMe.value;
                      }),
                ),
                const Text(TTexts.rememberMe),
              ],
            ),
            // Forget Password
            TextButton(
              style: ElevatedButton.styleFrom(overlayColor: TColors.primary),
              onPressed: () {
                Get.to(() => const ForgetPasswordView());
              },
              child: Text(
                TTexts.forgetPassword,
                style: TextStyle(
                    color: dark ? TColors.light : TColors.buttonSecondary),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: TSizes.spaceBtwSections,
        ),
        // Sign In
        CustomMaterialButton(
          title: TTexts.signIn,
          onPressed: () => controller.emailAndPasswordLogin(),
        ),
        const SizedBox(
          height: TSizes.spaceBtwItems,
        ),
        // Create Account
        CustomElevatedButton(
          onPressed: () {
            Get.to(() => const SignupView());
          },
          title: TTexts.createAccount,
        ),
      ],
    );
  }
}
