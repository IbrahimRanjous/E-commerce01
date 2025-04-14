import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rjs_store/Features/Signin/view/success_view.dart';
import 'package:rjs_store/Features/card/view/widgets/cart_items.dart';
import 'package:rjs_store/core/utils/constants/colors.dart';
import 'package:rjs_store/core/utils/constants/image_strings.dart';
import 'package:rjs_store/core/utils/constants/sizes.dart';
import 'package:rjs_store/core/utils/helpers/helper_functions.dart';
import 'package:rjs_store/core/widgets/custom%20shapes/rounded_container.dart';
import 'package:rjs_store/navigation_menu.dart';
import '../../../core/widgets/Appbar/appbar.dart';
import '../../login/views/widgets/custom_material_button.dart';
import 'widgets/coupon_text_filed.dart';
import 'widgets/order_price_section.dart';
import 'widgets/payment_method_section.dart';
import 'widgets/shipping_address_section.dart';

class CheckoutView extends StatelessWidget {
  const CheckoutView({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: TAppbar(
        showBackArrow: true,
        title: Text(
          'Order Review',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          children: [
            /// Items in Cart
            const TCartItems(
              showAddRemoveButtons: false,
            ),
            const SizedBox(height: TSizes.spaceBtwSections),

            /// -- Coupon TextField
            const TCouponTextFiled(),
            const SizedBox(height: TSizes.spaceBtwSections),

            /// -- Billing Section
            TRoundedContainer(
              padding: const EdgeInsets.all(TSizes.md),
              showBorder: true,
              backgroundColor: dark ? TColors.dark : TColors.light,
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ///  Order Price
                  TOrderPriceSection(),

                  /// Divider
                  Divider(thickness: 2),

                  ///  Payment Method
                  TPaymentMethodSection(),

                  ///  Shipping Address
                  TShippingAddressSection(),
                ],
              ),
            ),
          ],
        ),
      ),

      /// Checkout Button
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: CustomMaterialButton(
          onPressed: () {
            Get.to(
              () => SuccessView(
                  image: TImages.successfulPaymentIcon,
                  title: 'Payment Success!',
                  buttonTitle: 'Continue Shopping',
                  subTitle: 'Your item will be shipped soon',
                  onPressed: () => Get.offAll(() => const NavigationMenu())),
            );
          },
          title: 'Checkout \$256.0',
        ),
      ),
    );
  }
}
