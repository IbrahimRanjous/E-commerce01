import 'package:flutter/material.dart';
import '../../../../core/utils/constants/colors.dart';
import '../../../../core/widgets/section_heading.dart';

class TShippingAddressSection extends StatelessWidget {
  const TShippingAddressSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TSectionHeading(
          text: 'Shipping Address',
          showActionButton: true,
          buttonText: 'Change',
          buttonColor: TColors.primary,
          onPressed: () {},
        ),
        Text(
          'RJS Store',
          style: Theme.of(context).textTheme.bodySmall,
        ),
        const ListTile(
          leading: Icon(Icons.phone),
          title: Text('+963994758255'),
        ),
        const ListTile(
          leading: Icon(Icons.person),
          title: Text('south liana , Maine 87695, USA'),
        ),
      ],
    );
  }
}
