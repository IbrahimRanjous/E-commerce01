import 'dart:io';
import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:iconsax/iconsax.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import '../../../../core/utils/constants/sizes.dart';

class TRatingAndShare extends StatelessWidget {
  const TRatingAndShare({
    super.key,
    required this.rating,
    required this.reviews,
    required this.captureKey,
  });
  final double rating;
  final int reviews;
  final GlobalKey captureKey; // You can use simply GlobalKey here

  Future<void> captureAndShareScreenshot(GlobalKey key) async {
    try {
      // Retrieve the RenderRepaintBoundary from the key.
      RenderRepaintBoundary boundary =
          key.currentContext!.findRenderObject() as RenderRepaintBoundary;

      // Capture the image with a high pixel ratio for quality.
      final image = await boundary.toImage(pixelRatio: 3.0);
      final ByteData? byteData =
          await image.toByteData(format: ImageByteFormat.png);
      final Uint8List pngBytes = byteData!.buffer.asUint8List();

      // Write the captured image to a temporary file.
      final directory = await getTemporaryDirectory();
      final imagePath = '${directory.path}/screenshot.png';
      final imageFile = File(imagePath);
      await imageFile.writeAsBytes(pngBytes);

      // Share the image file using Share.shareXFiles.
      // ignore: deprecated_member_use
      await Share.shareXFiles([XFile(imagePath)],
          text: 'Check out this product on RJS Store');

      if (kDebugMode) {
        print('Screenshot shared successfully!');
      }
    } catch (e) {
      debugPrint('Error capturing and sharing screenshot: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        /// Rating
        Row(
          children: [
            const Icon(
              Iconsax.star5,
              color: Colors.amber,
              size: 24,
            ),
            const SizedBox(
              width: TSizes.spaceBtwItems / 2,
            ),
            Text.rich(
              TextSpan(children: [
                TextSpan(
                    text: '$rating',
                    style: Theme.of(context).textTheme.bodyLarge),
                TextSpan(text: '($reviews)')
              ]),
            ),
          ],
        ),

        /// Share Button
        IconButton(
          onPressed: () => captureAndShareScreenshot(captureKey),
          icon: const Icon(
            Icons.share,
            size: TSizes.iconMd,
          ),
        ),
      ],
    );
  }
}
