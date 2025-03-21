import 'package:flutter/material.dart';
import 'package:rjs_store/core/utils/constants/sizes.dart';
import 'package:rjs_store/core/utils/helpers/helper_functions.dart';

class OnBoardingItem extends StatelessWidget {
  final String image;
  final String title;
  final String subTitle;
  const OnBoardingItem({
    super.key,
    required this.image,
    required this.title,
    required this.subTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(TSizes.defaultSpace),
      child: Column(
        children: [
          const SizedBox(
            height: TSizes.appBarHeight + 40,
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(TSizes.cardRadiusSm),
            child: Image(
              image: AssetImage(image),
              width: THelperFunctions.screenWidth() * 0.8,
            ),
          ),
          const SizedBox(
            height: TSizes.spaceBtwItems,
          ),
          Text(
            title,
            style: Theme.of(context).textTheme.headlineMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: TSizes.spaceBtwItems,
          ),
          Text(
            subTitle,
            style: Theme.of(context).textTheme.headlineSmall,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
