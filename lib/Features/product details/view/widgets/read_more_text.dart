import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';

class TReadMoreText extends StatelessWidget {
  const TReadMoreText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const ReadMoreText(
      'This is a product description for blue nike seeve less vest.',
      trimLines: 2,
      trimMode: TrimMode.Line,
      trimCollapsedText: 'Show more',
      trimExpandedText: 'Less',
      moreStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
      lessStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
    );
  }
}
