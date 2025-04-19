import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rjs_store/Features/store/view/widgets/t_brand_card.dart';
import 'package:rjs_store/core/utils/constants/image_strings.dart';
import 'package:rjs_store/core/utils/constants/sizes.dart';
import 'package:rjs_store/core/utils/helpers/helper_functions.dart';
import 'package:rjs_store/core/widgets/Appbar/appbar.dart';
import '../../../core/widgets/grid layout/t_grid_lay_out_body.dart';
import 'brand_view_details.dart';

class BrandView extends StatelessWidget {
  const BrandView({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = THelperFunctions.screenWidth();
    return Scaffold(
      appBar: const TAppbar(
        title: Text('Brand'),
        showBackArrow: true,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) => SingleChildScrollView(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Brands',
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.start,
              ),
              const SizedBox(height: TSizes.spaceBtwInputFields),
              TGridLayoutBody(
                  mainAxisExtent: screenWidth * 0.2,
                  itemCount: TImages.brandIcons.length,
                  itemBuilder: (_, index) {
                    final url = TImages.brandIcons[index];
                    return GestureDetector(
                        onTap: () => Get.to(() => const BrandViewDetails()),
                        child: TBrandCard(showBorder: true, url: url));
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
