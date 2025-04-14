import 'package:flutter/material.dart';
import '../../../../core/utils/constants/colors.dart';
import '../../../../core/utils/constants/sizes.dart';
import '../../../../core/utils/helpers/helper_functions.dart';
import '../../../../core/widgets/custom shapes/rounded_container.dart';

class TCouponTextFiled extends StatelessWidget {
  const TCouponTextFiled({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    return TRoundedContainer(
      showBorder: true,
      backgroundColor: dark ? TColors.dark : TColors.white,
      padding: const EdgeInsets.only(
          top: TSizes.sm, bottom: TSizes.sm, right: TSizes.sm, left: TSizes.sm),
      child: Row(
        children: [
          /// Text Field
          Flexible(
            child: TextFormField(
              decoration: InputDecoration(
                hintText: 'Have a promo code ? Enter here',
                hintStyle:
                    TextStyle(color: dark ? TColors.white : TColors.black),
                focusedBorder: InputBorder.none,
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
              ),
            ),
          ),

          /// Button
          SizedBox(
            width: 80,
            child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(),
                child: const Text('Apply')),
          ),
        ],
      ),
    );
  }
}
