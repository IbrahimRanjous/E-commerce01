import 'package:flutter/material.dart';
import 'package:rjs_store/Features/login/data/cubit/login_controller.dart';
import '../../../../core/utils/constants/colors.dart';
import '../../../../core/utils/constants/image_strings.dart';
import '../../../../core/utils/constants/sizes.dart';

class TLoginFooter extends StatelessWidget {
  const TLoginFooter({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = LoginController.instance;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: TColors.grey),
            borderRadius: BorderRadius.circular(100),
          ),
          child: IconButton(
            onPressed: () {
              controller.loginWithGoogle();
            },
            icon: const Image(
              width: TSizes.iconLg,
              height: TSizes.iconLg,
              image: AssetImage(TImages.google),
            ),
          ),
        ),
        // const SizedBox(
        //   width: TSizes.spaceBtwItems,
        // ),
        // Container(
        //   decoration: BoxDecoration(
        //     border: Border.all(color: TColors.grey),
        //     borderRadius: BorderRadius.circular(100),
        //   ),
        //   child: IconButton(
        //     onPressed: () {},
        //     icon: const Image(
        //       width: TSizes.iconLg,
        //       height: TSizes.iconLg,
        //       image: AssetImage(TImages.facebook),
        //     ),
        //   ),
        // ),
      ],
    );
  }
}
