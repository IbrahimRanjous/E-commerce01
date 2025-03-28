import 'package:flutter/material.dart';
import '../../../../core/utils/constants/colors.dart';
import '../../../../core/utils/constants/sizes.dart';
import '../../../../core/widgets/section_heading.dart';

class THomeBodyHeading extends StatelessWidget {
  const THomeBodyHeading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(
        horizontal: TSizes.defaultSpace,
      ),
      child: TSectionHeading(
        text: 'Popular Products',
        buttonText: 'View all',
        showActionButton: true,
        buttonColor: TColors.primary,
      ),
    );
  }
}
