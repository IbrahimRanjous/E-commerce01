import 'package:flutter/material.dart';
import 'package:rjs_store/core/widgets/images/timed_network_image.dart';
import '../../../../core/utils/helpers/helper_functions.dart';

class CustomImage extends StatelessWidget {
  const CustomImage({
    super.key,
    required this.imageUrl,
    this.isNetworkImage = false,
  });

  final String imageUrl;
  final bool isNetworkImage;

  @override
  Widget build(BuildContext context) {
    final double height = THelperFunctions.screenHeight();
    return isNetworkImage
        ? TimedNetworkImage(
            imageUrl: imageUrl,
            height: height * 0.18,
            width: double.infinity,
            fit: BoxFit.cover,
          )
        : Image.asset(
            imageUrl,
            height: height * 0.2,
            width: double.infinity,
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) => Container(
              height: 200,
              color: Colors.grey.shade300,
              child: const Icon(Icons.broken_image, size: 48),
            ),
          );
  }
}
