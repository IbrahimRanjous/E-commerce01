import 'package:flutter/material.dart';
import 'package:rjs_store/core/utils/constants/sizes.dart';
import 'package:rjs_store/core/widgets/spacing_styles.dart';
import '../../../core/utils/constants/image_strings.dart';
import '../../../core/utils/constants/texts.dart';
import 'widgets/login_header.dart';
import 'widgets/login_divider.dart';
import 'widgets/login_footer.dart';
import 'widgets/login_form.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    for (var path in TImages.productReviewImages) {
      precacheImage(AssetImage(path), context);
    }
    for (var path in TImages.categoryIcons) {
      precacheImage(AssetImage(path), context);
    }
    for (var path in TImages.brandIcons) {
      precacheImage(AssetImage(path), context);
    }
    for (var path in TImages.banners) {
      precacheImage(AssetImage(path), context);
    }
  }

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
