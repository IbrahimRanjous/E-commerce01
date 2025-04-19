import 'package:flutter/material.dart';
import 'package:rjs_store/Features/veiw%20all/view/widgets/custom_drop_down_button.dart';
import 'package:rjs_store/core/utils/constants/sizes.dart';
import 'package:rjs_store/core/widgets/Appbar/appbar.dart';
import '../../home/views/widgets/grid_view.dart';

class ViewAllView extends StatelessWidget {
  const ViewAllView({super.key});

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
    // String? hint = 'Sort by';
    return Scaffold(
      appBar: const TAppbar(
        title: Text('Popular Products'),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            /// -- Filter Button
            CustomDropDownButton(
              itemsList: itemsList,
            ),
            const SizedBox(height: TSizes.spaceBtwSections),

            /// -- Filtered Items
            const TGridView(),
          ],
        ),
      ),
    );
  }
}
