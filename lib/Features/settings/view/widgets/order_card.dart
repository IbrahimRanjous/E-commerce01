import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:rjs_store/core/utils/constants/colors.dart';
import 'package:rjs_store/core/utils/helpers/helper_functions.dart';
import 'package:rjs_store/core/widgets/custom%20shapes/rounded_container.dart';

class TOrderCard extends StatelessWidget {
  const TOrderCard({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return TRoundedContainer(
      showBorder: true,
      backgroundColor: dark ? TColors.dark : TColors.light,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          /// -- Row 1
          ListTile(
            leading: const Icon(Iconsax.ship),
            title: const Text(
              'Processing',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            subtitle: const Text(
              '07 Nov 2023',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            trailing: const Icon(Icons.navigate_next),
            onTap: () {},
          ),

          /// -- Row 2
          Row(
            children: [
              Expanded(
                child: ListTile(
                  leading: const Icon(Iconsax.tag),
                  title: Text(
                    'Order',
                    style: Theme.of(context).textTheme.labelMedium,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  subtitle: Text(
                    '#1daOd',
                    style: Theme.of(context).textTheme.titleMedium,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              const Expanded(
                child: ListTile(
                  leading: Icon(Iconsax.calendar),
                  title: Text(
                    'Shipping Date',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  subtitle: Text(
                    '07 Nov 2023',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
