import 'package:flutter/material.dart';
import 'package:rjs_store/Features/home/views/widgets/vertical_list_view_icon_text.dart';
import 'package:rjs_store/core/utils/device/device_utility.dart';
import '../../../../core/utils/constants/image_strings.dart';

class THomeCategories extends StatelessWidget {
  const THomeCategories({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // Choose a percentage of the total screen height for your list view.
    // Here, we use 10% of the screen height, but adjust this fraction as needed.
    final listViewHeight = TDeviceUtils.getScreenHeight() * 0.1;

    return SizedBox(
      height: listViewHeight,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: categories.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (_, index) {
          final category = categories[index];
          return TVerticalListViewIconText(
            iconImage: category.icon,
            title: category.title,
            onTap: () {},
          );
        },
      ),
    );
  }
}

class Category {
  final String icon;
  final String title;

  Category({required this.icon, required this.title});
}

final List<Category> categories = [
  Category(icon: TImages.sportIcon, title: 'Sports'),
  Category(icon: TImages.clothIcon, title: 'Clothing'),
  Category(icon: TImages.shoeIcon, title: 'Shoes'),
  Category(icon: TImages.cosmeticsIcon, title: 'Cosmetics'),
  Category(icon: TImages.animalIcon, title: 'Animals'),
  Category(icon: TImages.toyIcon, title: 'Toys'),
  Category(icon: TImages.furnitureIcon, title: 'Furnitures'),
  Category(icon: TImages.jeweleryIcon, title: 'Fewelery'),
  Category(icon: TImages.electronicsIcon, title: 'Electronics'),
  // add more as needed...
];
