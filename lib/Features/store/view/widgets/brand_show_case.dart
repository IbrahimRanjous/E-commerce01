import 'package:flutter/material.dart';
import '../../../../core/utils/constants/colors.dart';
import '../../../../core/utils/constants/sizes.dart';
import '../../../../core/utils/helpers/helper_functions.dart';
import '../../../../core/widgets/custom shapes/rounded_container.dart';
import 't_brand_card.dart';
// ignore: depend_on_referenced_packages
import 'package:cloudinary_flutter/image/cld_image.dart';

class TBrandShowCase extends StatelessWidget {
  const TBrandShowCase({
    super.key,
    required this.images,
  });

  final List<String> images;

  @override
  Widget build(BuildContext context) {
    return TRoundedContainer(
      padding: const EdgeInsets.all(TSizes.md),
      borderColor: TColors.darkGrey,
      backgroundColor: Colors.transparent,
      margin: const EdgeInsets.only(bottom: TSizes.spaceBtwItems),
      showBorder: true,
      child: Column(
        children: [
          /// Brand with Products Count
          const TBrandCard(
            showBorder: true,
          ),

          /// Brand Tap 3 Product Images
          Row(
            children: images
                .map((image) => brandTopProductImageWidget(image, context))
                .toList(),
          ),
        ],
      ),
    );
  }
}

Widget brandTopProductImageWidget(String image, context) {
  final double height = THelperFunctions.screenHeight();

  return Expanded(
    child: TRoundedContainer(
        height: 100,
        padding: const EdgeInsets.all(TSizes.md),
        margin: const EdgeInsets.only(right: TSizes.sm),
        showBorder: false,
        backgroundColor: THelperFunctions.isDarkMode(context)
            ? TColors.darkGrey
            : TColors.light,
        child: CldImageWidget(
          publicId: 'trcksuit_parrotgreen_likjgj',
          errorBuilder: (context, error, stackTrace) => Container(
            height: height * 0.2,
            color: Colors.grey.shade300,
            child: const Icon(Icons.broken_image, size: 48),
          ),
        )),
  );
}
