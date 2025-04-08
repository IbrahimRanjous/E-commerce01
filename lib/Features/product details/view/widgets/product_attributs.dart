import 'package:flutter/material.dart';
import 'package:rjs_store/core/utils/constants/colors.dart';
import 'package:rjs_store/core/utils/constants/sizes.dart';
import 'package:rjs_store/core/utils/helpers/helper_functions.dart';
import 'package:rjs_store/core/widgets/custom%20shapes/rounded_container.dart';
import 'package:rjs_store/core/widgets/section_heading.dart';
import 'package:rjs_store/core/widgets/text/product_price_text.dart';
import 'package:rjs_store/core/widgets/text/product_title_text.dart';
import 'choice_chip.dart';

class TProductAttributs extends StatefulWidget {
  const TProductAttributs({super.key});

  @override
  State<TProductAttributs> createState() => _TProductAttributsState();
}

class _TProductAttributsState extends State<TProductAttributs> {
  List<String> listColors = [];
  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Column(
      children: [
        /// -- Selected Attribute Pricing & Description
        TRoundedContainer(
          backgroundColor: dark ? TColors.darkGrey : TColors.grey,
          child: Column(
            children: [
              /// Title , Price and Stock Status
              Row(
                children: [
                  const TSectionHeading(text: 'Variation'),
                  const SizedBox(width: TSizes.spaceBtwItems),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          TProductTitleText(title: 'Price : ', smallSize: true),

                          /// Actual Price
                          TProductPriceText(price: '25', lineThrough: true),
                          SizedBox(width: TSizes.spaceBtwItems),

                          /// Sale Price
                          TProductPriceText(price: '20'),
                        ],
                      ),

                      /// Stock
                      Row(
                        children: [
                          const TProductTitleText(
                              title: 'Stock : ', smallSize: true),
                          Text(
                            'In Stock',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),

              /// Variation Description
              const TProductTitleText(
                title:
                    'This is the Description of the Pruduct and it can go up to max tines.',
                smallSize: true,
                maxLines: 4,
              ),
            ],
          ),
        ),

        const SizedBox(height: TSizes.spaceBtwItems),

        /// -- Attributes
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TSectionHeading(text: 'Colors'),
            const SizedBox(height: TSizes.spaceBtwItems / 2),
            Wrap(
              spacing: 8,
              children: [
                TChoiceChip(
                    text: 'red',
                    onSelected: (value) {
                      setState(() {
                        if (value) {
                          listColors.add('red');
                        } else {
                          listColors.remove('red');
                        }
                      });
                    },
                    selected: listColors.contains('red')),
                TChoiceChip(
                    text: 'green',
                    onSelected: (value) {
                      setState(() {
                        if (value) {
                          listColors.add('green');
                        } else {
                          listColors.remove('green');
                        }
                      });
                    },
                    selected: listColors.remove('green')),
                TChoiceChip(
                    text: 'yellow',
                    onSelected: (value) {
                      if (value) {
                        listColors.add('yellow');
                      } else {
                        listColors.remove('yellow');
                      }
                    },
                    selected: listColors.contains('yellow')),
              ],
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TSectionHeading(text: 'Sizes'),
            const SizedBox(height: TSizes.spaceBtwItems / 2),
            Wrap(
              spacing: 8,
              children: [
                TChoiceChip(
                    text: 'EU 34', selected: true, onSelected: (value) {}),
                TChoiceChip(
                    text: 'EU 36', selected: false, onSelected: (value) {}),
                TChoiceChip(
                    text: 'EU 38', selected: false, onSelected: (value) {}),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
