import 'package:flutter/material.dart';

import '../../../../core/utils/constants/colors.dart';
import '../../../../core/utils/constants/texts.dart';
import '../../../../core/utils/helpers/helper_functions.dart';

class TDivider extends StatelessWidget {
  const TDivider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
          child: Divider(
            color: dark ? TColors.darkGrey : TColors.black,
            thickness: 0.7,
            indent: 10,
            endIndent: 5,
          ),
        ),
        Text(
          TTexts.orSignInWith,
          style: Theme.of(context).textTheme.labelMedium,
        ),
        Flexible(
          child: Divider(
            color: dark ? TColors.darkGrey : TColors.black,
            thickness: 0.7,
            indent: 5,
            endIndent: 10,
          ),
        ),
      ],
    );
  }
}
