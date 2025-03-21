import 'package:flutter/material.dart';

import '../../../../core/utils/constants/images_strings.dart';
import '../../../../core/utils/constants/sizes.dart';
import '../../../../core/utils/constants/texts.dart';
import '../../../../core/utils/helpers/helper_functions.dart';

class TLoginHeader extends StatelessWidget {
  const TLoginHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(TSizes.cardRadiusSm),
          child: Image(
            height: 150,
            image:
                AssetImage(dark ? TImages.lightAppLogo : TImages.darkAppLogo),
          ),
        ),
        const SizedBox(
          height: TSizes.spaceBtwItems,
        ),
        Text(
          TTexts.loginTitle,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(
          height: TSizes.spaceBtwItems,
        ),
        Text(
          TTexts.loginSubTitle,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ],
    );
  }
}
