import 'package:flutter/material.dart';
import 'package:rjs_store/Features/onBoarding/data/controllers/onboarding_controler.dart';
import 'package:rjs_store/core/utils/constants/colors.dart';
import 'package:rjs_store/core/utils/device/device_utility.dart';
import 'package:rjs_store/core/utils/helpers/helper_functions.dart';

import '../../../../core/utils/constants/sizes.dart';

class OnboardingSkip extends StatelessWidget {
  const OnboardingSkip({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Positioned(
      top: TDeviceUtils.getAppBarHeight(),
      right: TSizes.defaultSpace,
      child: TextButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: dark ? TColors.buttonPrimary : TColors.dark),
        onPressed: () {
          OnboardingControler.instance.skipPage();
        },
        child: const Text(
          'Skip',
          style: TextStyle(color: TColors.light),
        ),
      ),
    );
  }
}
