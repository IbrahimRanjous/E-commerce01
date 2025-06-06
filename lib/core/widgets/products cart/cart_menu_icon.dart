import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../utils/constants/colors.dart';

class TCardCounterIcon extends StatelessWidget {
  const TCardCounterIcon({
    super.key,
    required this.onPreessed,
    this.iconColor,
  });

  final VoidCallback onPreessed;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        IconButton(
          onPressed: onPreessed,
          icon: Icon(
            Iconsax.shopping_bag,
            color: iconColor,
          ),
        ),
        Positioned(
          right: 0,
          child: Container(
            width: 18,
            height: 18,
            decoration: BoxDecoration(
              color: TColors.error,
              borderRadius: BorderRadius.circular(100),
            ),
            child: Center(
              child: Text(
                '2',
                style: Theme.of(context)
                    .textTheme
                    .labelLarge!
                    .apply(color: TColors.light, fontSizeFactor: 0.8),
              ),
            ),
          ),
        )
      ],
    );
  }
}
