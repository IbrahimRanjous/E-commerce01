import 'package:flutter/material.dart';
import 'package:rjs_store/core/utils/constants/sizes.dart';
import 'package:rjs_store/core/widgets/spacing_styles.dart';
import 'widgets/login_header.dart';
import 'widgets/login_form.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: TSpacingStyl.paddingWithAppBareHeight,
            child: Column(
              children: [
                // Logo , Title & SubTitle
                TLoginHeader(),

                // Form
                TLoginForm(),

                SizedBox(height: TSizes.spaceBtwSections),

                ///////////////////// Additional update for it  /////////////////////////////
                // Divider
                // TFormDivider(
                //   text: TTexts.orLogInWith,
                // ),

                // SizedBox(height: TSizes.spaceBtwSections),

                // Footer
                // TLoginFooter(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
