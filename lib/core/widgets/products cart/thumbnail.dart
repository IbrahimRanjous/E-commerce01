import 'package:flutter/material.dart';
import '../../../Features/home/views/widgets/custom_image.dart';
import '../../utils/constants/colors.dart';
import '../../utils/constants/sizes.dart';
import '../text/my_text.dart';
import 'favorite_icon.dart';

class TThumbnail extends StatelessWidget {
  const TThumbnail({
    super.key,
    required this.imageUrl,
    required this.discountText,
    required this.isFavorite,
  });

  final String imageUrl;
  final String discountText;
  final bool isFavorite;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.vertical(
              top: Radius.circular(TSizes.cardRadiusMd)),
          child: CustomImage(
            imageUrl: imageUrl,
            isNetworkImage: true,
          ),
        ),
        /////// -- Discount -- ///////
        if (discountText.isNotEmpty)
          Positioned(
            top: 8,
            left: 8,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.yellow.withValues(alpha: 0.7),
                borderRadius: BorderRadius.circular(12),
              ),
              child: MyText(
                text: discountText,
                fontWeight: FontWeight.bold,
                color: TColors.black,
              ),
            ),
          ),
        /////// -- Favorite -- ///////
        FavoriteIcon(
          isFavorite: isFavorite,
          iconSize: 30.0,
          containerSize: 35.0,
          top: 2.0,
          right: 2.0,
        )
      ],
    );
  }
}
