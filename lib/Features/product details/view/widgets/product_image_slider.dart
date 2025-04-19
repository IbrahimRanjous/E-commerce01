import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../core/utils/constants/colors.dart';
import '../../../../core/utils/constants/image_strings.dart';
import '../../../../core/utils/constants/sizes.dart';
import '../../../../core/utils/helpers/helper_functions.dart';
import '../../../../core/widgets/Appbar/appbar.dart';
import '../../../../core/widgets/Icons/t_circular_icon.dart';
import '../../../../core/widgets/custom shapes/curved_edges_widget.dart';
import '../../../../core/widgets/images/t_rounded_image.dart';

class TProductImageSlider extends StatelessWidget {
  const TProductImageSlider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);
    final screenWidth = THelperFunctions.screenWidth();

    return TCurvedEdgeWidget(
      child: Container(
        color: isDark ? TColors.darkerGrey : TColors.light,
        child: Stack(
          children: [
            /// Main Large Image
            Container(
              padding: const EdgeInsets.all(TSizes.productImageRadius),
              height: 400,
              child: const Center(
                child: Image(
                  image: AssetImage(TImages.productImage5),
                ),
              ),
            ),

            /// Image Slider
            Positioned(
              left: screenWidth * 0.05,
              right: screenWidth * 0.05,
              bottom: 35,
              child: SizedBox(
                height: 60,
                child: ListView.separated(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: 6,
                  separatorBuilder: (_, __) =>
                      const SizedBox(width: TSizes.spaceBtwItems),
                  itemBuilder: (BuildContext context, int index) =>
                      TRoundedImage(
                    url: TImages.productImage1,
                    isNetworkImage: false,
                    backgroundColor: isDark ? TColors.dark : TColors.light,
                    border: Border.all(color: TColors.primary),
                    padding: TSizes.sm,
                    imageHeight: TSizes.imageThumbSize,
                    imageWidth: TSizes.imageThumbSize,
                  ),
                ),
              ),
            ),

            /// Appbar Icons
            const TAppbar(
              showBackArrow: true,
              actions: [
                TCircularIcon(
                  icon: Iconsax.heart5,
                  color: Colors.red,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
