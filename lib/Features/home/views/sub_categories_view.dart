import 'package:flutter/material.dart';
import 'package:rjs_store/core/utils/constants/image_strings.dart';
import 'package:rjs_store/core/utils/constants/sizes.dart';
import 'package:rjs_store/core/widgets/Appbar/appbar.dart';
import '../../../core/widgets/images/t_rounded_image.dart';
import 'widgets/sub_categoris.dart';

class SubCategoriesView extends StatelessWidget {
  const SubCategoriesView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: TAppbar(
        title: Text('Sports shirts'),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          children: [
            /// Banner
            TRoundedImage(
              url: TImages.banner1,
              isNetworkImage: false,
              borderRadius: TSizes.cardRadiusLg,
              fit: BoxFit.cover,
            ),
            SizedBox(height: TSizes.spaceBtwItems),

            /// Sub-Categories
            TSubCategories(),
          ],
        ),
      ),
    );
  }
}
