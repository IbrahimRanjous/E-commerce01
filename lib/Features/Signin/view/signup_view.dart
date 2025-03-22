import 'package:flutter/material.dart';
import 'package:rjs_store/Features/login/views/widgets/login_divider.dart';
import 'package:rjs_store/Features/login/views/widgets/login_footer.dart';
import 'package:rjs_store/core/utils/constants/sizes.dart';
import 'package:rjs_store/core/utils/constants/texts.dart';
import 'widgets/sign_up_form.dart';

class SignupView extends StatelessWidget {
  const SignupView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(TSizes.defaultSpace),
          // Form
          child: Column(
            children: [
              // Title
              Text(TTexts.signUpTitle,
                  textAlign: TextAlign.start,
                  overflow: TextOverflow.clip,
                  style: Theme.of(context).textTheme.headlineMedium),
              const SizedBox(height: TSizes.spaceBtwSections),

              TSingUpForm(),
              // Divider
              TFormDivider(text: TTexts.orSignUpWith),
              const SizedBox(height: TSizes.spaceBtwItems),

              // Footer
              TFooter(),
              const SizedBox(height: TSizes.spaceBtwSections),
            ],
          ),
        ),
      ),
    );
  }
}
