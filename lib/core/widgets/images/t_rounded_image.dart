import 'package:flutter/material.dart';
import '../../utils/helpers/helper_functions.dart';
import 'timed_network_image.dart';

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
    this.isNetworkImage = false,
    this.fit,
    this.backgroundColor = Colors.transparent,
    this.overLayColor,
    this.imageWidth,
    this.imageHeight,
    this.onTap,
    this.border,
    this.borderRadius = 16.0,
  });

  @override
  Widget build(BuildContext context) {
    final double height = THelperFunctions.screenHeight();

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
        child: ClipRRect(
          borderRadius: BorderRadius.circular(borderRadius),
          child: Center(
              child: isNetworkImage
                  ? TimedNetworkImage(
                      imageUrl: url,
                      height: imageHeight ?? height * 0.18,
                      width: imageWidth ?? double.infinity,
                      fit: fit ?? BoxFit.contain,
                    )
                  : Image.asset(
                      url,
                      height: imageHeight,
                      width: imageWidth,
                      fit: fit,
                      color: overLayColor,
                      errorBuilder: (context, url, error) => Container(
                        height: height * 0.2,
                        color: Colors.grey.shade300,
                        child: const Icon(Icons.broken_image, size: 48),
                      ),
                    )),
        ),
      ),
    );
  }
}
