import 'package:flutter/material.dart';
import '../../../../core/widgets/grid layout/t_grid_lay_out_body.dart';
import 't_brand_card.dart';

class TStoreGridViewbody extends StatelessWidget {
  const TStoreGridViewbody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TGridLayoutBody(
      itemCount: 4,
      mainAxisExtent: 80,
      itemBuilder: (_, index) {
        return TBrandCard(
          onTap: () {},
          showBorder: true,
        );
      },
    );
  }
}
