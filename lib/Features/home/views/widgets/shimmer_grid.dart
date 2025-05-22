// Dummy shimmer widget - replace with your actual shimmer widget
import 'package:flutter/material.dart';

class TShimmerGrid extends StatelessWidget {
  const TShimmerGrid({super.key});

  @override
  Widget build(BuildContext context) {
    // Return a placeholder widget that looks like a grid shimmer.
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}
