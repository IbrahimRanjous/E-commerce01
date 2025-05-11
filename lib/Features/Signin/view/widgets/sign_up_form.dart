import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:rjs_store/core/utils/validators/validation.dart';
import '../../../../core/utils/constants/sizes.dart';
import '../../../../core/utils/constants/texts.dart';
import '../../../../core/widgets/custom_text_form.dart';
import '../../../login/views/widgets/custom_material_button.dart';
import '../../data/cubit/signup_controller.dart';
import 'privace_and_terms_form.dart';

class TSingUpForm extends StatelessWidget {
  const TSingUpForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = SignupController.instance;
    return Form(
      key: controller.signupFormKey,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        // First Name & Last Name
        Row(children: [
          Expanded(
            child: CustomTextForm(
                controller: controller.firstName,
                validator: (value) =>
                    TValidator.validateEmptyText('First Name', value),
                prefixicon: const Icon(Iconsax.user),
                hintText: TTexts.firstName),
          ),
          const SizedBox(
            width: TSizes.spaceBtwInputFields,
          ),
          Expanded(
            child: CustomTextForm(
                controller: controller.lastName,
                validator: (value) =>
                    TValidator.validateEmptyText('Last Name', value),
                prefixicon: const Icon(Iconsax.user),
                hintText: TTexts.lastName),
          ),
        ]),
        const SizedBox(height: TSizes.spaceBtwInputFields),

        // Username
        CustomTextForm(
            controller: controller.userName,
            validator: (value) =>
                TValidator.validateEmptyText('User Name', value),
            prefixicon: const Icon(Iconsax.user_edit),
            hintText: TTexts.username),

        const SizedBox(height: TSizes.spaceBtwInputFields),
        // E-Mail

        CustomTextForm(
            controller: controller.email,
            validator: (value) => TValidator.validateEmail(value),
            prefixicon: const Icon(Iconsax.direct),
            hintText: TTexts.email),

        const SizedBox(height: TSizes.spaceBtwInputFields),

        // Phone Number
        CustomTextForm(
            controller: controller.phoneNumber,
            validator: (value) => TValidator.validatePhoneNumber(value),
            prefixicon: const Icon(Iconsax.call),
            hintText: TTexts.phoneNu),
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
        const SizedBox(height: TSizes.spaceBtwSections),

        // Privacy Policy & Terms of use
        const PrivacyPolicyAndTermsofUse(),
        const SizedBox(height: TSizes.spaceBtwSections),

        // Create Account Button
        CustomMaterialButton(
          onPressed: () {
            controller.signup();
          },
          title: TTexts.createAccount,
        ),
        const SizedBox(height: TSizes.spaceBtwSections),
      ]),
    );
  }
}
