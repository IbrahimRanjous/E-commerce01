import 'package:flutter/material.dart';
import 'package:rjs_store/Features/onBoarding/views/onboarding_controler.dart';
import 'package:rjs_store/core/utils/device/device_utility.dart';

import '../../../../core/utils/constants/sizes.dart';

class OnboardingSkip extends StatelessWidget {
  const OnboardingSkip({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: TDeviceUtils.getAppBarHeight(),
      right: TSizes.defaultSpace,
      child: TextButton(
        onPressed: () {
          OnboardingControler.instance.skipPage();
        },
        child: const Text('Skip'),
      ),
    );
  }
}
