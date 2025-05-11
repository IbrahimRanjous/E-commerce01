import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rjs_store/Features/card/view/cart_view.dart';
import '../../../../core/utils/constants/colors.dart';
import '../../../../core/utils/constants/texts.dart';
import '../../../../core/utils/helpers/helper_functions.dart';
import '../../../../core/widgets/Appbar/appbar.dart';
import '../../../../core/widgets/products cart/cart_menu_icon.dart';
import '../../../../core/widgets/user/user_controller.dart';

class THomeAppBar extends StatelessWidget {
  const THomeAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final controller = Get.put(UserController());

    return TAppbar(
      title: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            TTexts.homeAppbarTitle,
            style: Theme.of(context)
                .textTheme
                .labelMedium!
                .apply(color: dark ? TColors.grey : TColors.grey),
            textAlign: TextAlign.start,
          ),
          Obx(
            () => Text(
              controller.user.value.fullName,
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall!
                  .apply(color: dark ? TColors.grey : TColors.light),
              textAlign: TextAlign.start,
            ),
          ),
        ],
      ),
      actions: [
        TCardCounterIcon(
          onPreessed: () {
            Get.to(() => const CartView());
          },
          iconColor: dark ? TColors.darkGrey : TColors.light,
        ),
      ],
    );
  }
}
