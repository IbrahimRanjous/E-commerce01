import 'package:flutter/material.dart';
import 'package:rjs_store/core/utils/constants/sizes.dart';
import 'package:rjs_store/core/widgets/spacing_styles.dart';
import '../../../core/utils/constants/texts.dart';
import 'widgets/login_header.dart';
import 'widgets/login_divider.dart';
import 'widgets/login_footer.dart';
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
                TForm(),

                SizedBox(height: TSizes.spaceBtwSections),

                // Divider
                TFormDivider(
                  text: TTexts.orSignInWith,
                ),

                SizedBox(height: TSizes.spaceBtwSections),

                // Footer
                TFooter(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
