import 'package:flutter/material.dart';
import 'package:rjs_store/Features/home/views/widgets/grid_view.dart';
import 'package:rjs_store/core/widgets/section_heading.dart';
import '../../../core/utils/constants/sizes.dart';
import '../../../core/widgets/Appbar/appbar.dart';
import '../../veiw all/view/widgets/custom_drop_down_button.dart';
import 'widgets/t_brand_card.dart';

class BrandViewDetails extends StatelessWidget {
  const BrandViewDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> itemsList = [
      'Name',
      'Higher Price',
      'Lower Price',
      'Sale',
      'Newest',
      'Popularity',
    ];
    return Scaffold(
      appBar: const TAppbar(
        title: Text('Brand'),
        showBackArrow: true,
      ),
      body: StreamBuilder<Object>(
          stream: null,
          builder: (context, snapshot) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: TSizes.defaultSpace),
                    child: Column(
                      children: [
                        SizedBox(height: TSizes.appBarHeight / 2),

                        /// Brand Card
                        TBrandCard(showBorder: true),
                        SizedBox(height: TSizes.spaceBtwSections),

                        /// Header Section
                        TSectionHeading(text: 'Products'),
                        SizedBox(height: TSizes.spaceBtwItems),
                      ],
                    ),
                  ),

                  /// -- Filter Button
                  CustomDropDownButton(
                    itemsList: itemsList,
                  ),
                  const SizedBox(height: TSizes.spaceBtwSections),
                  const TGridView(),
                ],
              ),
            );
          }),
    );
  }
}
