import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rjs_store/Features/Signin/data/controllers/signup_controller.dart';
import 'package:rjs_store/core/utils/constants/sizes.dart';
import 'package:rjs_store/core/utils/constants/texts.dart';
import 'widgets/sign_up_form.dart';

class SignupView extends StatelessWidget {
  const SignupView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SignupController());
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          // Form
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Title
              Text(TTexts.signUpTitle,
                  textAlign: TextAlign.start,
                  overflow: TextOverflow.clip,
                  style: Theme.of(context).textTheme.headlineMedium),
              const SizedBox(height: TSizes.spaceBtwSections),

              const TSingUpForm(),
              ///////////////////// Additional update for it  /////////////////////////////

              // Divider
              // const TFormDivider(text: TTexts.orSignUpWith),
              // const SizedBox(height: TSizes.spaceBtwItems),

              // Footer
              // const TSignInFooter(),
              // const SizedBox(height: TSizes.spaceBtwSections),
            ],
          ),
        ),
      ),
    );
  }
}
