import 'package:flutter/material.dart';

//// A visual bar representing a single rating level.
class RatingBar extends StatelessWidget {
  final double progress;
  final int star;

  const RatingBar({super.key, required this.progress, required this.star});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        /// Display star level
        Text("$star stars"),
        const SizedBox(width: 8),

        /// The bar indicator wrapped in an Expanded widget
        Expanded(
          child: Stack(
            children: [
              /// Background bar
              Container(
                height: 10,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.grey[300],
                ),
              ),

              /// Filled bar proportional to the progress value
              FractionallySizedBox(
                widthFactor: progress,
                child: Container(
                  height: 10,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.amber,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
