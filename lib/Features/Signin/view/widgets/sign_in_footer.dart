import 'package:flutter/material.dart';
import '../../../../core/utils/constants/colors.dart';
import '../../../../core/utils/constants/image_strings.dart';
import '../../../../core/utils/constants/sizes.dart';

class TSignInFooter extends StatelessWidget {
  const TSignInFooter({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: TColors.grey),
            borderRadius: BorderRadius.circular(100),
          ),
          child: IconButton(
            onPressed: () {},
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
