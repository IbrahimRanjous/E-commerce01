import 'package:flutter/material.dart';
import 'package:rjs_store/core/utils/device/device_utility.dart';
import '../../../../core/utils/constants/colors.dart';
import '../../../../core/utils/constants/sizes.dart';
import '../../../../core/utils/constants/texts.dart';
import '../../../../core/utils/helpers/helper_functions.dart';

class PrivacyPolicyAndTermsofUse extends StatelessWidget {
  const PrivacyPolicyAndTermsofUse({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: TDeviceUtils.getScreenWidth(context) * 0.05,
      ),
      child: Row(
        children: [
          SizedBox(
            height: 24,
            width: 24,
            child: Checkbox(value: true, onChanged: (value) {}),
          ),
          const SizedBox(
            width: TSizes.spaceBtwItems,
          ),
          Flexible(
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                      text: '${TTexts.agreeTo} ',
                      style: Theme.of(context).textTheme.bodySmall),
                  TextSpan(
                    text: TTexts.privacyPolicy,
                    style: Theme.of(context).textTheme.bodyMedium!.apply(
                        color: dark ? TColors.light : TColors.primary,
                        decoration: TextDecoration.underline,
                        decorationColor:
                            dark ? TColors.light : TColors.primary),
                  ),
                  TextSpan(
                      text: ' and ',
                      style: Theme.of(context).textTheme.bodySmall),
                  TextSpan(
                    text: '${TTexts.termsOfUse} ',
                    style: Theme.of(context).textTheme.bodyMedium!.apply(
                        color: dark ? TColors.light : TColors.primary,
                        decoration: TextDecoration.underline,
                        decorationColor:
                            dark ? TColors.light : TColors.primary),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
