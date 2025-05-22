import 'package:flutter/material.dart';
import '../../../../core/utils/helpers/helper_functions.dart';
// ignore: depend_on_referenced_packages
// import 'package:cloudinary_flutter/image/cld_image.dart';

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
        ?
        //  CldImageWidget(
        //     publicId: 'trcksuit_parrotgreen_likjgj',
        //     height: 150,
        //     width: double.infinity,
        //     fit: BoxFit.cover,
        //     errorBuilder: (context, error, stackTrace) => Container(
        //       height: height * 0.2,
        //       color: Colors.grey.shade300,
        //       child: const Icon(Icons.broken_image, size: 48),
        //     ),
        //   )
        Image.network(
            imageUrl,
            height: height * 0.18,
            width: double.infinity,
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) => Container(
              height: 150,
              width: double.infinity,
              color: Colors.grey.shade300,
              child: const Icon(Icons.broken_image, size: 48),
            ),
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
