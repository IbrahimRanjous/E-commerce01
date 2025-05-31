import 'dart:async';
import 'package:flutter/material.dart';
import 'package:rjs_store/core/utils/loaders/shimmer_effect.dart'; // Assuming this is your shimmer effect widget

class TimedNetworkImage extends StatefulWidget {
  final String imageUrl;
  final double height;
  final double width;
  final BoxFit fit;
  final int timeoutSeconds;

  const TimedNetworkImage({
    super.key,
    required this.imageUrl,
    required this.height,
    required this.width,
    this.fit = BoxFit.contain,
    this.timeoutSeconds = 5, // Number of seconds before timing out
  });

  @override
  // ignore: library_private_types_in_public_api
  _TimedNetworkImageState createState() => _TimedNetworkImageState();
}

class _TimedNetworkImageState extends State<TimedNetworkImage> {
  bool _hasTimedOut = false;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimeout();
  }

  void _startTimeout() {
    _timer?.cancel();
    _timer = Timer(Duration(seconds: widget.timeoutSeconds), () {
      setState(() {
        _hasTimedOut = true;
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // If we've timed out, show the error widget.
    if (_hasTimedOut) {
      return Container(
        height: widget.height,
        width: widget.width,
        color: Colors.grey.shade300,
        child: const Icon(Icons.broken_image, size: 48),
      );
    }

    return Image.network(
      widget.imageUrl,
      height: widget.height,
      width: widget.width,
      fit: widget.fit,
      filterQuality: FilterQuality.high,
      // The loadingBuilder still shows our loading indicator (e.g., a shimmer effect)
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) {
          // If the image finishes loading before the timeout,
          // cancel the timer and display the image.
          _timer?.cancel();
          return child;
        }
        return TShimmerEffect(
          width: widget.width,
          height: widget.height,
        );
      },
      // errorBuilder still handles cases where the network request actually fails.
      errorBuilder: (context, error, stackTrace) => Container(
        height: widget.height,
        width: widget.width,
        color: Colors.grey.shade300,
        child: const Icon(Icons.broken_image, size: 48),
      ),
    );
  }
}
