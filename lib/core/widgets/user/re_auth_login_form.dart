import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../utils/constants/sizes.dart';
import '../../utils/constants/texts.dart';
import '../../utils/validators/validation.dart';
import 'user_controller.dart';

class ReAuthLoginForm extends StatelessWidget {
  const ReAuthLoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    return Scaffold(
      appBar: AppBar(title: const Text('Re-Authenticate User')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Form(
          key: controller.reAuthFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Email Field
              TextFormField(
                controller: controller.verifyEmail,
                validator: TValidator.validateEmail,
                decoration: InputDecoration(
                    prefixIcon: Icon(Iconsax.direct_right),
                    labelText: TTexts.email,
                    hintStyle: Theme.of(context).textTheme.titleSmall),
              ),
              const SizedBox(height: TSizes.spaceBtwInputFields),

              // Password Field with reactive show/hide password feature
              Obx(
                () => TextFormField(
                  obscureText: controller.hidePassword.value,
                  controller: controller.verifyPassword,
                  validator: (value) =>
                      TValidator.validateEmptyText('Password', value),
                  decoration: InputDecoration(
                      labelText: TTexts.password,
                      prefixIcon: const Icon(Iconsax.password_check),
                      suffixIcon: IconButton(
                        onPressed: () => controller.hidePassword.value =
                            !controller.hidePassword.value,
                        icon: controller.hidePassword.value
                            ? const Icon(Iconsax.eye_slash)
                            : const Icon(Iconsax.eye),
                      ),
                      hintStyle: Theme.of(context).textTheme.titleSmall),
                ),
              ),
              const SizedBox(height: TSizes.spaceBtwSections),

              // Verify Button triggers re-authentication logic
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () =>
                      controller.reAuthenticateEmailAndPasswordUser(),
                  child: const Text('Verify'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
