import 'package:flutter/material.dart';
import 'package:rjs_store/core/utils/helpers/helper_functions.dart';
import 'rating_bar.dart';

//// Displays a vertical chart showing the distribution of ratings.
class RatingsBarChart extends StatelessWidget {
  const RatingsBarChart({super.key});

  @override
  Widget build(BuildContext context) {
    /// Dedicated data for each rating (5 to 1 stars)
    final ratingsData = [
      RatingData(star: 5, progress: 1.0),
      RatingData(star: 4, progress: 0.7),
      RatingData(star: 3, progress: 0.5),
      RatingData(star: 2, progress: 0.3),
      RatingData(star: 1, progress: 0.2),
    ];

    return FittedBox(
      fit: BoxFit.contain,
      child: Column(
        children: ratingsData
            .map((data) => SizedBox(
                  width: (THelperFunctions.screenWidth() / 2.3),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: RatingBar(progress: data.progress, star: data.star),
                  ),
                ))
            .toList(),
      ),
    );
  }
}

//// Data model for each rating bar entry.
class RatingData {
  final int star;
  final double progress;
  RatingData({required this.star, required this.progress});
}
