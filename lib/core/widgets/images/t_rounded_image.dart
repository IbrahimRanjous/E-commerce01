import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:rjs_store/core/utils/loaders/shimmer_effect.dart';
import '../../utils/helpers/helper_functions.dart';

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

//your_cloud_name
  // final String cloudName;
  // final String fileExtension;
  // final String publicId;

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
                ? CachedNetworkImage(
                    imageUrl: url,
                    height: imageHeight,
                    width: imageWidth,
                    fit: fit,
                    placeholder: (context, url) => const TShimmerEffect(
                      width: 80,
                      height: 80,
                      radius: 80,
                    ),
                    errorWidget: (context, url, error) => Container(
                      height: height * 0.2,
                      color: Colors.grey.shade300,
                      child: const Icon(Icons.broken_image, size: 48),
                    ),
                  )
                : Image(
                    width: imageWidth,
                    height: imageHeight,
                    fit: fit,
                    color: overLayColor,
                    image: isNetworkImage
                        ? NetworkImage(url)
                        : AssetImage(url) as ImageProvider,
                  ),
          ),
        ),
      ),
    );
  }
}
