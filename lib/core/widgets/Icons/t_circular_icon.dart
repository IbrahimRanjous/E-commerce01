import 'package:flutter/material.dart';
import '../../utils/constants/colors.dart';
import '../../utils/helpers/helper_functions.dart';

class TCircularIcon extends StatelessWidget {
  /// A custom circular icon widget with a background color.
  ///
  /// Allows setting [width] and [height] for the container,
  /// and [size] for the icon itself.
  const TCircularIcon({
    super.key,
    required this.icon,
    this.width = 32.0, // default width
    this.height = 32.0, // default height
    this.size = 16.0, // default icon size for compact usage
    this.color,
    this.onPressed,
    this.backgroundColor,
  });

  final double width, height, size;
  final IconData icon;
  final Color? color;
  final Color? backgroundColor;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: backgroundColor ??
            (THelperFunctions.isDarkMode(context)
                ? TColors.black.withValues(alpha: 0.9)
                : TColors.white.withValues(alpha: 0.9)),
        borderRadius: BorderRadius.circular(100),
      ),
      // Remove the button's default padding & constraints
      child: IconButton(
        padding: EdgeInsets.zero,
        constraints: const BoxConstraints(),
        onPressed: onPressed,
        icon: Icon(icon, color: color, size: size),
      ),
    );
  }
}
