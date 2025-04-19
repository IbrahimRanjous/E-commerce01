import 'package:flutter/material.dart';

class TRoundedImage extends StatelessWidget {
  /// The image URL path.
  final String url;

  /// The width and height of the widget.
  final double? imageWidth;
  final double? imageHeight;

  /// The padding inside the container.
  final double padding;

  /// Optional override for background color.
  final Color? backgroundColor;

  /// Optional override for overlay color.
  final Color? overLayColor;

  /// Check if the image is from the internet or assets.
  final bool isNetworkImage;

  final BoxFit? fit;
  final BoxBorder? border;
  final void Function()? onTap;

  /// The border radius for rounding corners.
  final double borderRadius;

  const TRoundedImage({
    super.key,
    required this.url,
    this.padding = 0,
    required this.isNetworkImage,
    this.fit,
    this.backgroundColor = Colors.transparent,
    this.overLayColor,
    this.imageWidth,
    this.imageHeight,
    this.onTap,
    this.border,
    this.borderRadius = 16.0, // Default border radius value.
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: imageWidth,
        height: imageHeight,
        padding: EdgeInsets.all(padding),
        decoration: BoxDecoration(
          color: backgroundColor,
          border: border,
          // Use borderRadius to create rounded corners.
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        // Adding clipBehavior ensures the child is clipped to the rounded shape.
        clipBehavior: Clip.antiAlias,
        child: Image(
          width: imageWidth,
          height: imageHeight,
          fit: fit,
          color: overLayColor,
          image: isNetworkImage
              ? NetworkImage(url)
              : AssetImage(url) as ImageProvider,
        ),
      ),
    );
  }
}
