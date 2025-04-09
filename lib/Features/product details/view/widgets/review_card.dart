import 'package:flutter/material.dart';
import '../../../../core/utils/constants/sizes.dart';

//// A card widget for displaying individual reviews and the store response.
class ReviewCard extends StatelessWidget {
  final String reviewerName;
  final String reviewDate;
  final int rating;
  final String comment;
  final String storeResponse;
  final String storeResponseDate;

  const ReviewCard({
    super.key,
    required this.reviewerName,
    required this.reviewDate,
    required this.rating,
    required this.comment,
    required this.storeResponse,
    required this.storeResponseDate,
  });

  /// Utility to generate star icons based on the rating value.
  List<Widget> _buildStarIcons() {
    return List.generate(
      rating,
      (index) => const Icon(
        Icons.star,
        color: Colors.amber,
        size: 16,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Header row with reviewer's name and date
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  reviewerName,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: TSizes.fontSizeMd),
                ),
                Text(
                  reviewDate,
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
            const SizedBox(height: 8),

            /// Display star rating
            Row(
              children: _buildStarIcons(),
            ),
            const SizedBox(height: 8),

            /// Review text
            Text(
              comment,
              style: const TextStyle(fontSize: TSizes.fontSizeSm),
            ),
            const SizedBox(height: 8),

            /// Store response section, if available
            if (storeResponse.isNotEmpty)
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Response from T's Store",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      storeResponse,
                      style: const TextStyle(fontSize: TSizes.fontSizeSm),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      storeResponseDate,
                      style: const TextStyle(
                          color: Colors.grey, fontSize: TSizes.fontSizeSm),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
