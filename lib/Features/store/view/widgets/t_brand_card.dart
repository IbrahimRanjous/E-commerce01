import 'package:flutter/material.dart';
import '../../../../core/utils/constants/colors.dart';
import '../../../../core/utils/constants/image_strings.dart';
import '../../../../core/utils/constants/sizes.dart';
import '../../../../core/utils/helpers/helper_functions.dart';
import '../../../../core/widgets/brand_widget.dart';
import '../../../../core/widgets/custom shapes/rounded_container.dart';
import '../../../../core/widgets/images/t_circular_image.dart';
import '../../../../core/widgets/text/my_text.dart';

class TBrandCard extends StatelessWidget {
  const TBrandCard({
    super.key,
    this.onTap,
    required this.showBorder,
  });
  final void Function()? onTap;
  final bool showBorder;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: TRoundedContainer(
        showBorder: showBorder,
        padding: const EdgeInsets.all(TSizes.sm),
        child: Row(
          children: [
            ///  -- Icon
            Flexible(
              child: TCircularImage(
                imageWidth: THelperFunctions.screenWidth() * 0.135,
                imgaeHeight: THelperFunctions.screenWidth() * 0.135,
                isNetworkImage: false,
                url: TImages.clothIcon,
                overLayColor: THelperFunctions.isDarkMode(context)
                    ? TColors.light
                    : TColors.dark,
              ),
            ),
            const SizedBox(width: TSizes.spaceBtwItems),

            // -- Text
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const TBrandWidget(
                    brand: 'Nike',
                    isVerified: true,
                  ),
                  MyText(
                    text: '256 products',
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
