import 'package:flutter/material.dart';

class TRoundedContainer extends StatelessWidget {
  /// The widget below this container in the tree.
  final Widget? child;

  /// The internal padding of the container.
  final EdgeInsetsGeometry? padding;

  /// The margin around the container.
  final EdgeInsetsGeometry? margin;

  /// The border radius of the container.
  final double borderRadius;

  /// The color of the container's border.
  final Color borderColor;

  /// The background color of the container.
  final Color backgroundColor;

  /// The container's height.
  final double? height;

  /// The container's width.
  final double? width;

  // Show the border or Not
  final bool showBorder;

  const TRoundedContainer({
    super.key,
    this.child,
    this.padding = const EdgeInsets.all(8.0),
    this.borderRadius = 12.0,
    this.borderColor = Colors.grey,
    this.backgroundColor = Colors.transparent,
    this.margin,
    this.height,
    this.width,
    this.showBorder = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
        color: backgroundColor,
        border: showBorder
            ? Border.all(color: borderColor)
            : Border.all(color: Colors.transparent),
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: child,
    );
  }
}
