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
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: imageWidth,
      height: imgaeHeight,
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        color: backgroundColor,
        shape: BoxShape.circle,
      ),
      child: Image(
          fit: fit,
           color: overLayColor,
          image: isNetworkImage
              ? NetworkImage(url)
              : AssetImage(url) as ImageProvider),
    );
  }
}
