import 'package:flutter/material.dart';
import '../../utils/constants/colors.dart';
import '../../utils/helpers/helper_functions.dart';

class MyText extends StatelessWidget {
  const MyText({
    super.key,
    required this.text,
    this.color,
    this.maxLines = 1,
    this.overflow = TextOverflow.ellipsis,
    this.fontWeight,
    this.style,
    this.fontSize,
  });

  final String text;
  final Color? color;
  final int maxLines;
  final TextOverflow? overflow;
  final FontWeight? fontWeight;
  final TextStyle? style;
  final double? fontSize;

  @override
  Widget build(BuildContext context) {
    final noColor =
        THelperFunctions.isDarkMode(context) ? TColors.light : TColors.dark;
    return FittedBox(
      fit: BoxFit.contain,
      child: Text(text,
          style: style ??
              TextStyle(
                  fontWeight: fontWeight,
                  color: color ?? noColor,
                  fontSize: fontSize),
          maxLines: maxLines,
          overflow: overflow),
    );
  }
}
