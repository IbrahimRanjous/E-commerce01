import 'package:flutter/material.dart';
import '../../../../core/utils/constants/colors.dart';
import '../../../../core/utils/constants/texts.dart';
import '../../../../core/utils/helpers/helper_functions.dart';
import '../../../../core/widgets/Appbar/appbar.dart';
import '../../../../core/widgets/products cart/cart_menu_icon.dart';

class THomeAppBar extends StatelessWidget {
  const THomeAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    return TAppbar(
      title: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            TTexts.homeAppbarTitle,
            style: Theme.of(context)
                .textTheme
                .labelMedium!
                .apply(color: dark ? TColors.grey : TColors.grey),
            textAlign: TextAlign.start,
          ),
          Text(
            TTexts.homeAppbarSubTitle,
            style: Theme.of(context)
                .textTheme
                .headlineSmall!
                .apply(color: dark ? TColors.grey : TColors.light),
            textAlign: TextAlign.start,
          ),
        ],
      ),
      actions: [
        TCardCounterIcon(
          onPreessed: () {},
          iconColor: dark ? TColors.darkGrey : TColors.light,
        ),
      ],
    );
  }
}
