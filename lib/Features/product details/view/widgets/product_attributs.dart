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
  const TProductAttributs(
      {super.key,
      required this.discount,
      required this.price,
      required this.quantity,
      required this.status,
      required this.description});

  /// Discount text, for example "78%" or an empty string if not applicable.
  final int discount;

  /// The price for the product.
  final String price;

  /// The quantity indicator (could show available stock, etc.)
  final String quantity;
  final String description;

  final bool status;
  @override
  State<TProductAttributs> createState() => _TProductAttributsState();
}

class _TProductAttributsState extends State<TProductAttributs> {
  List<String> listColors = [];

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final cleanedPrice = widget.price.replaceAll(RegExp(r'[^0-9.]'), '');
    final originalPrice = double.parse(cleanedPrice);
    final discountedPrice =
        originalPrice - (originalPrice * widget.discount / 100);

    return Column(
      children: [
        /// -- Selected Attribute Pricing & Description
        TRoundedContainer(
          backgroundColor: dark ? TColors.darkGrey : TColors.grey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Title , Price and Stock Status
              Row(
                children: [
                  const TSectionHeading(text: 'Variation'),
                  const SizedBox(width: TSizes.spaceBtwItems),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          TProductTitleText(title: 'Price : ', smallSize: true),

                          /// Actual Price
                          if (widget.discount != 0)
                            TProductPriceText(
                                price: originalPrice.toString(),
                                lineThrough: true),
                          if (widget.discount != 0)
                            SizedBox(width: TSizes.spaceBtwItems),

                          /// Sale Price
                          TProductPriceText(price: discountedPrice.toString()),
                        ],
                      ),

                      /// Stock
                      Row(
                        children: [
                          const TProductTitleText(
                              title: 'Stock : ', smallSize: true),
                          Text(
                            widget.status ? 'In Stock' : 'Out Of Stock',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),

              /// Variation Description
              TProductTitleText(
                title: widget.description,
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
