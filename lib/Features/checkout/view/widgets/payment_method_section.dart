import 'package:flutter/material.dart';
import 'package:rjs_store/core/utils/constants/image_strings.dart';
import 'package:rjs_store/core/utils/constants/sizes.dart';
import 'package:rjs_store/core/utils/helpers/helper_functions.dart';
import 'package:rjs_store/core/widgets/custom%20shapes/rounded_container.dart';
import '../../../../core/utils/constants/colors.dart';
import '../../../../core/widgets/section_heading.dart';

class TPaymentMethodSection extends StatelessWidget {
  const TPaymentMethodSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TSectionHeading(
          text: 'Payment Method',
          showActionButton: true,
          buttonText: 'Change',
          buttonColor: TColors.primary,
          onPressed: () {},
        ),
        const SizedBox(height: TSizes.spaceBtwItems / 2),
        Row(
          children: [
            TRoundedContainer(
              width: 60,
              height: 35,
              backgroundColor: THelperFunctions.isDarkMode(context)
                  ? TColors.light
                  : TColors.white,
              padding: const EdgeInsets.all(TSizes.sm),
              child: const Image(
                image: AssetImage(TImages.paypal),
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(width: TSizes.spaceBtwItems / 2),
            Text(
              'Paypal',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
      ],
    );
  }
}
