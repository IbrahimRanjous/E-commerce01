import 'package:flutter/material.dart';

class TRoundedContainer extends StatelessWidget {
  /// The widget below this container in the tree.
  final Widget child;

  /// The internal padding of the container.
  final EdgeInsetsGeometry padding;

  /// The border radius of the container.
  final double borderRadius;

  /// The color of the container's border.
  final Color borderColor;

  /// The background color of the container.
  final Color backgroundColor;

  const TRoundedContainer({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(8.0),
    this.borderRadius = 12.0,
    this.borderColor = Colors.grey,
    this.backgroundColor = Colors.transparent,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: backgroundColor,
        border: Border.all(color: borderColor),
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: child,
    );
  }
}
