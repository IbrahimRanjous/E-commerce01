import 'package:flutter/material.dart';

//// Displays the overall rating and total number of reviews.
class OverallRatingWidget extends StatelessWidget {
  final double rating;
  final int reviewCount;

  const OverallRatingWidget({
    super.key,
    required this.rating,
    required this.reviewCount,
  });

  /// Builds a list of star icons based on the [rating] value.
  /// For each star:
  /// - Displays a full star if [rating] is greater than or equal to the star's number.
  /// - Displays a half star if the remaining rating is at least 0.5.
  /// - Otherwise, displays an outlined star.
  List<Widget> _buildStarIcons() {
    List<Widget> stars = [];
    for (int i = 0; i < 5; i++) {
      if (rating >= i + 1) {
        // Full yellow star.
        stars.add(const Icon(Icons.star, color: Colors.amber, size: 24));
      } else if (rating >= i + 0.5) {
        // Half yellow star.
        stars.add(const Icon(Icons.star_half, color: Colors.amber, size: 24));
      } else {
        // Outlined star.
        stars.add(const Icon(Icons.star_border, color: Colors.amber, size: 24));
      }
    }
    return stars;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Column to display the numerical rating and review count.
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              rating.toString(),
              style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "$reviewCount reviews",
              style: const TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
          ],
        ),
        const SizedBox(width: 16),
        // Display stars based on the given rating.
        Row(
          children: _buildStarIcons(),
        ),
      ],
    );
  }
}
