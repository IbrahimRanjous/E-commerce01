// ignore: dangling_library_doc_comments
/////////////////// Home Header Design ///////////////////

import 'package:flutter/material.dart';
import '../../../../core/utils/constants/colors.dart';

class TCircularContainer extends StatelessWidget {
  const TCircularContainer({
    super.key,
    this.width = 400,
    this.height = 400,
    this.borderRadius = 400,
    this.padding = 0,
    this.color = TColors.light,
    this.child,
  });
  final double? width, height;
  final double borderRadius;
  final double padding;
  final Color? color;
  final Widget? child;
  @override
  Widget build(BuildContext context) {
    return Container(
      
      width: width,
      height: height,
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        color: color,
        
      ),
      child: child,
    );
  }
}
