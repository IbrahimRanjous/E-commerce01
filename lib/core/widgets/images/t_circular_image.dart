import 'package:flutter/material.dart';

class TCircularImage extends StatelessWidget {
  /// The image url path.
  final String url;

  /// The width and height of the widget.
  final double size;
  final double? width;
  final double? height;

  /// The padding inside the circular container.
  final double padding;

  /// Optional override for background color .
  final Color? backgroundColor;

  /// Optional override for overlay color .
  final Color? overLayColor;

  /// Check if the image is from the internet or assets
  final bool isNetworkImage;

  final BoxFit? fit;

  const TCircularImage({
    super.key,
    required this.url,
    this.size = 56.0,
    this.padding = 8.0,
    required this.isNetworkImage,
    this.fit,
    this.backgroundColor = Colors.transparent,
    this.overLayColor,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        color: backgroundColor,
        shape: BoxShape.circle,
      ),
      child: Image(
          fit: fit,
          width: width,
          height: height,
          color: overLayColor,
          image: isNetworkImage
              ? NetworkImage(url)
              : AssetImage(url) as ImageProvider),
    );
  }
}
