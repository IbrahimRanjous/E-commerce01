import 'package:flutter/material.dart';
import 'package:rjs_store/core/utils/constants/sizes.dart';
import 'package:rjs_store/core/utils/helpers/helper_functions.dart';
import 'package:rjs_store/core/widgets/Appbar/appbar.dart';
import 'widgets/overall_rating_widget.dart';
import 'widgets/ratings_bar_chart.dart';
import 'widgets/review_card.dart';

class ReviewsRatingsView extends StatelessWidget {
  const ReviewsRatingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const TAppbar(
          title: Text('Reviews & Ratings'),
          showBackArrow: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(TSizes.defaultSpace),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Verified review message
                const Text(
                  'Verified ratings and reviews from users with similar devices ',
                  style: TextStyle(fontSize: TSizes.fontSizeMd),
                ),
                const SizedBox(height: TSizes.spaceBtwItems),

                /// Overall rating widget (4.7 & total reviews)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const OverallRatingWidget(
                      rating: 3.7,
                      reviewCount: 121160,
                    ),
                    SizedBox(width: THelperFunctions.screenWidth() * 0.02),

                    /// Bar chart for the rating distribution
                    const RatingsBarChart(),
                  ],
                ),
                const SizedBox(height: TSizes.spaceBtwItems),

                /// Review Cards below
                const ReviewCard(
                  reviewerName: "John Doe",
                  reviewDate: "03-Nov-2023",
                  rating: 5,
                  comment:
                      "Intuitive user interface and seamless purchase experience.",
                  storeResponse: "Thank you for the kind words.",
                  storeResponseDate: "03-Nov-2023",
                ),
                const SizedBox(height: 16),
                const ReviewCard(
                  reviewerName: "Sophia Wilson",
                  reviewDate: "03-Nov-2023",
                  rating: 5,
                  comment:
                      "Great app design and variety of products. aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
                  storeResponse:
                      "Thank you for the positive feedback. aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
                  storeResponseDate: "03-Nov-2023",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
