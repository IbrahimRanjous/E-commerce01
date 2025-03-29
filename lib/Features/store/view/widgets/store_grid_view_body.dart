import 'package:flutter/material.dart';
import '../../../../core/utils/constants/colors.dart';
import '../../../../core/utils/constants/image_strings.dart';
import '../../../../core/utils/constants/sizes.dart';
import '../../../../core/utils/helpers/helper_functions.dart';
import '../../../../core/widgets/brand_widget.dart';
import '../../../../core/widgets/custom shapes/rounded_container.dart';
import '../../../../core/widgets/grid layout/t_grid_lay_out.dart';
import '../../../../core/widgets/images/t_circular_image.dart';
import '../../../../core/widgets/text/my_text.dart';

class TStoreGridViewbody extends StatelessWidget {
  const TStoreGridViewbody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TGridLayout(
      itemCount: 4,
      mainAxisExtent: 80,
      itemBuilder: (_, index) {
        return GestureDetector(
          onTap: () {},
          child: TRoundedContainer(
            padding: const EdgeInsets.all(TSizes.sm),
            child: Row(
              children: [
                ///  -- Icon
                Flexible(
                  child: TCircularImage(
                    size: THelperFunctions.screenWidth() * 0.135,
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
                      const BrandWidget(
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
      },
    );
  }
}
