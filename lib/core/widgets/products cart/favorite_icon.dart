import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../utils/constants/colors.dart';
import '../../utils/helpers/helper_functions.dart';
import '../Icons/t_circular_icon.dart';

class FavoriteIcon extends StatelessWidget {
  const FavoriteIcon({
    super.key,
    required this.isFavorite,
  });

  final bool isFavorite;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    return Positioned(
      top: 4,
      right: 4,
      child: TCircularIcon(
        icon: isFavorite ? Iconsax.heart5 : Iconsax.heart,
        color: isFavorite
            ? Colors.red
            : dark
                ? TColors.light
                : TColors.dark,
      ),
    );
  }
}
