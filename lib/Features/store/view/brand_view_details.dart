import 'package:flutter/material.dart';
import 'package:rjs_store/core/widgets/section_heading.dart';
import '../../../core/product_model.dart';
import '../../../core/utils/constants/sizes.dart';
import '../../../core/widgets/Appbar/appbar.dart';
import '../../veiw all/view/widgets/custom_drop_down_button.dart';
import 'widgets/grid_view_brands.dart';
import 'widgets/t_brand_card.dart';

class BrandViewDetails extends StatelessWidget {
  const BrandViewDetails(
      {super.key,
      required this.url,
      required this.brandName,
      required this.product});

  final String url;
  final String brandName;
  final ProductModel product;

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
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: TSizes.defaultSpace),
                    child: Column(
                      children: [
                        SizedBox(height: TSizes.appBarHeight / 2),

                        /// Brand Card
                        TBrandCard(
                          showBorder: true,
                          url: url,
                          brandName: brandName,
                          product: product,
                        ),
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
                  TGridViewFiltered(
                    brandFilter: brandName,
                  ),
                ],
              ),
            );
          }),
    );
  }
}
