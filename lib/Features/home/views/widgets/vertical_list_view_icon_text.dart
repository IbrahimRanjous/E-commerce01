import 'package:flutter/material.dart';
import '../../../../core/utils/constants/colors.dart';
import '../../../../core/utils/constants/sizes.dart';
import '../../../../core/utils/helpers/helper_functions.dart';

class TVerticalListViewIconText extends StatelessWidget {
  const TVerticalListViewIconText({
    super.key,
    required this.iconImage,
    required this.title,
    this.textColor = TColors.light,
    this.backgroundColor = TColors.light,
    this.onTap,
  });

  final String iconImage, title;
  final Color textColor;
  final Color? backgroundColor;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    // Calculate a scaling factor based on a base width of 375.0.
    // This means on a device with a 375.0 width, the factor will be 1.0.
    // Adjust this base value to suit your design specifications.
    final scaleFactor = MediaQuery.of(context).size.width / 375.0;

    // Responsive dimensions determined by the scale factor.
    final circleDiameter = 56.0 * scaleFactor;
    final iconPadding = TSizes.sm * scaleFactor;
    final spacing = (TSizes.spaceBtwItems / 2) * scaleFactor;
    final rightPadding = TSizes.spaceBtwItems * scaleFactor;

    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.only(
          right: rightPadding,
        ),
        child: Column(
          children: [
            /// Responsive Circular Icon
            Container(
              width: circleDiameter,
              height: circleDiameter,
              padding: EdgeInsets.all(iconPadding),
              decoration: BoxDecoration(
                color: backgroundColor ?? (dark ? TColors.dark : TColors.light),
                borderRadius: BorderRadius.circular(circleDiameter / 2),
              ),
              child: Center(
                child: Image(
                  image: AssetImage(iconImage),
                  fit: BoxFit.cover,
                  color: TColors.dark,
                ),
              ),
            ),
            SizedBox(height: spacing),

            /// Responsive Text
            FittedBox(
              fit: BoxFit.contain,
              child: Text(
                title,
                style: Theme.of(context)
                    .textTheme
                    .labelMedium!
                    .apply(color: textColor),
                overflow: TextOverflow.ellipsis,
                softWrap: true,
                maxLines: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
