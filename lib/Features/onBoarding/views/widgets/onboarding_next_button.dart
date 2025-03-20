import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:rjs_store/Features/onBoarding/views/onboarding_controler.dart';
import 'package:rjs_store/core/utils/constants/colors.dart';
import 'package:rjs_store/core/utils/helpers/helper_functions.dart';

import '../../../../core/utils/constants/sizes.dart';
import '../../../../core/utils/device/device_utility.dart';

class OnboardingNextButton extends StatelessWidget {
  const OnboardingNextButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: TDeviceUtils.getBottomNavigationBarHeight(),
      right: TSizes.defaultSpace,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            shape: const CircleBorder(),
            shadowColor: Colors.white,
            backgroundColor: THelperFunctions.isDarkMode(context)
                ? TColors.primary
                : TColors.dark),
        onPressed: () {
          OnboardingControler.instance.nextPage();
        },
        child: const Icon(
          Iconsax.arrow_right_34,
        ),
      ),
    );
  }
}
