import 'package:flutter/material.dart';
import 'package:rjs_store/core/widgets/spacing_styles.dart';
import '../../../core/utils/constants/sizes.dart';
import '../../../core/utils/constants/texts.dart';
import '../../../core/utils/helpers/helper_functions.dart';
import '../../login/views/widgets/custom_material_button.dart';

class SuccessView extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final image, title, subTitle;
  final VoidCallback onPressed;
  const SuccessView(
      {super.key,
      required this.image,
      required this.title,
      required this.subTitle,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: TSpacingStyl.paddingWithAppBareHeight,
          child: Column(
            children: [
              // Image
              Center(
                child: ClipRRect(
                  clipBehavior: Clip.antiAlias,
                  borderRadius: BorderRadius.circular(TSizes.cardRadiusLg),
                  child: Image(
                    image: AssetImage(image),
                    width: THelperFunctions.screenWidth() * 0.6,
                  ),
                ),
              ),
              const SizedBox(height: TSizes.spaceBtwSections),

              // Title & SubTitle
              Text(title,
                  style: Theme.of(context).textTheme.headlineMedium,
                  textAlign: TextAlign.center),
              const SizedBox(height: TSizes.spaceBtwItems),

              Text(subTitle,
                  style: Theme.of(context).textTheme.labelLarge,
                  textAlign: TextAlign.center),

              const SizedBox(height: TSizes.spaceBtwSections),

              // Buttons
              CustomMaterialButton(onPressed: onPressed, title: TTexts.signIn),
              const SizedBox(height: TSizes.spaceBtwItems),
            ],
          ),
        ),
      ),
    );
  }
}
