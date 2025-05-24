import 'package:flutter/material.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:iconsax/iconsax.dart';
import '../../utils/constants/colors.dart';
import '../../utils/helpers/helper_functions.dart';
import '../Icons/t_circular_icon.dart';

class FavoriteIcon extends StatelessWidget {
  /// Create a [FavoriteIcon] with customizable sizes.
  ///
  /// [isFavorite] toggles between two icon types.
  /// [iconSize] controls the size of the heart icon.
  /// [containerSize] controls the overall dimensions of the circular container.
  /// [top] and [right] allow repositioning if needed.
  const FavoriteIcon({
    super.key,
    required this.isFavorite,
    this.iconSize = 16.0, // default small icon size
    this.containerSize = 32.0, // default small container size
    this.top = 4.0,
    this.right = 4.0,
    this.onTap,
  });

  final Rx<bool> isFavorite; // Use RxBool to track state dynamically
  final void Function()? onTap;
  final double iconSize;
  final double containerSize;
  final double top;
  final double right;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Positioned(
      top: top,
      right: right,
      child: GestureDetector(
        onTap: onTap,
        child: TCircularIcon(
          width: containerSize,
          height: containerSize,
          icon: isFavorite.value ? Iconsax.heart5 : Iconsax.heart,
          size: iconSize,
          color: isFavorite.value
              ? Colors.red
              : dark
                  ? TColors.light
                  : TColors.dark,
        ),
      ),
    );
  }
}
