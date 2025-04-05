import 'package:flutter/material.dart';

class TCircularImage extends StatelessWidget {
  /// The image url path.
  final String url;

  /// The width and height of the widget.
  final double? imageWidth;
  final double? imgaeHeight;

  /// The padding inside the circular container.
  final double padding;

  /// Optional override for background color .
  final Color? backgroundColor;

  /// Optional override for overlay color .
  final Color? overLayColor;

  /// Check if the image is from the internet or assets
  final bool isNetworkImage;

  final BoxFit? fit;
  final BoxBorder? border;
  final void Function()? onTap;

  const TCircularImage({
    super.key,
    required this.url,
    this.padding = 8.0,
    required this.isNetworkImage,
    this.fit,
    this.backgroundColor = Colors.transparent,
    this.overLayColor,
    this.imageWidth,
    this.imgaeHeight,
    this.onTap,
    this.border,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: imageWidth,
        height: imgaeHeight,
        padding: EdgeInsets.all(padding),
        decoration: BoxDecoration(
            color: backgroundColor, shape: BoxShape.circle, border: border),
        child: Image(
            fit: fit,
            color: overLayColor,
            image: isNetworkImage
                ? NetworkImage(url)
                : AssetImage(url) as ImageProvider),
      ),
    );
  }
}
