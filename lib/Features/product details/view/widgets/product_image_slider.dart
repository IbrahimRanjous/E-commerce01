import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../core/utils/constants/colors.dart';
import '../../../../core/utils/constants/sizes.dart';
import '../../../../core/utils/helpers/helper_functions.dart';
import '../../../../core/widgets/Appbar/appbar.dart';
import '../../../../core/widgets/Icons/t_circular_icon.dart';
import '../../../../core/widgets/custom shapes/curved_edges_widget.dart';
import '../../../../core/widgets/images/t_rounded_image.dart';

class TProductImageSlider extends StatelessWidget {
  const TProductImageSlider({
    super.key,
    this.onFavoriteTap,
    required this.imageUrl,
    required this.isFavorite,
  });
  final void Function()? onFavoriteTap;

  /// URL for the product image.
  final String imageUrl;

  /// Whether the product is currently favorited.
  final RxBool isFavorite;

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
              child: Center(
                child: Image(
                  image: NetworkImage(imageUrl),
                  fit: BoxFit.fill,
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
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () {},
                      child: TRoundedImage(
                        url: imageUrl,
                        isNetworkImage: true,
                        backgroundColor: isDark ? TColors.dark : TColors.light,
                        border: Border.all(color: TColors.primary),
                        padding: TSizes.sm,
                        imageHeight: TSizes.imageThumbSize,
                        imageWidth: TSizes.imageThumbSize,
                      ),
                    );
                  },
                ),
              ),
            ),

            /// Appbar Icons
            TAppbar(
              showBackArrow: true,
              actions: [
                Obx(
                  () => GestureDetector(
                    onTap: onFavoriteTap,
                    child: TCircularIcon(
                      icon: Iconsax.heart5,
                      size: 28,
                      width: 35,
                      height: 35,
                      color: isFavorite.value
                          ? Colors.red
                          : isDark
                              ? TColors.white
                              : TColors.darkerGrey,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
