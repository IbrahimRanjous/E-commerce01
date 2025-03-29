import 'package:flutter/material.dart';
import '../../../../core/utils/constants/colors.dart';
import '../../../../core/utils/helpers/helper_functions.dart';

class TFormDivider extends StatelessWidget {
  final String text;
  const TFormDivider({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
          child: Divider(
            color: dark ? TColors.darkGrey : TColors.dark,
            thickness: 0.7,
            indent: 10,
            endIndent: 5,
          ),
        ),
        Text(
          text,
          style: Theme.of(context).textTheme.labelMedium,
        ),
        Flexible(
          child: Divider(
            color: dark ? TColors.darkGrey : TColors.dark,
            thickness: 0.7,
            indent: 5,
            endIndent: 10,
          ),
        ),
      ],
    );
  }
}
