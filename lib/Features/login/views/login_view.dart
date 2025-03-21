import 'package:flutter/material.dart';
import 'package:rjs_store/core/utils/constants/sizes.dart';
import 'package:rjs_store/core/widgets/spacing_styles.dart';
import 'widgets/t_login_header.dart';
import 'widgets/tdivider.dart';
import 'widgets/tfooter.dart';
import 'widgets/tform.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: TSpacingStyl.paddingWithAppBareHeight,
          child: Column(
            children: [
              // Logo , Title & SubTitle
              TLoginHeader(),

              // Form
              TForm(),

              SizedBox(
                height: TSizes.spaceBtwSections,
              ),

              // Divider
              TDivider(),

              SizedBox(
                height: TSizes.spaceBtwSections,
              ),

              // Footer
              TFooter(),
            ],
          ),
        ),
      ),
    );
  }
}
