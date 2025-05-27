import 'package:flutter/material.dart';
import 'package:rjs_store/core/utils/loaders/shimmer_effect.dart';
import '../../utils/helpers/helper_functions.dart';

class TRoundedImage extends StatelessWidget {
  /// The image URL or asset path.
  final String url;

  /// The width and height of the widget.
  final double? imageWidth;
  final double? imageHeight;

  /// The padding inside the container.
  final double padding;

  /// Optional override for background color.
  final Color? backgroundColor;

  /// Optional overlay color applied to the image.
  final Color? overLayColor;

  /// Whether the image is fetched from the network.
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
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        clipBehavior: Clip.antiAlias,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(borderRadius),
          child: Center(
            child: isNetworkImage
                ? Image.network(
                    url,
                    width: imageWidth,
                    height: imageHeight,
                    fit: fit,
                    // Show a shimmer effect while the image is loading.
                    loadingBuilder: (BuildContext context, Widget child,
                        ImageChunkEvent? loadingProgress) {
                      if (loadingProgress == null) return child;
                      return const TShimmerEffect(
                        width: 80,
                        height: 80,
                        radius: 80,
                      );
                    },
                    // Display an error widget in case of failure.
                    errorBuilder: (context, error, stackTrace) => Container(
                      height: height * 0.2,
                      color: Colors.grey.shade300,
                      child: const Icon(Icons.broken_image, size: 48),
                    ),
                  )
                : Image.asset(
                    url,
                    width: imageWidth,
                    height: imageHeight,
                    fit: fit,
                    color: overLayColor,
                    errorBuilder: (context, error, stackTrace) => Container(
                      height: height * 0.2,
                      color: Colors.grey.shade300,
                      child: const Icon(Icons.broken_image, size: 48),
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
