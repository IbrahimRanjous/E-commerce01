import 'package:flutter/material.dart';
import 'package:rjs_store/core/utils/constants/sizes.dart';
import 'package:rjs_store/core/widgets/Appbar/appbar.dart';
import 'widgets/overall_rating_widget.dart';
import 'widgets/ratings_bar_chart.dart';
import 'widgets/review_card.dart';

class ReviewsRatingsView extends StatelessWidget {
  const ReviewsRatingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        appBar: TAppbar(
          title: Text('Reviews & Ratings'),
          showBackArrow: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(TSizes.defaultSpace),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Verified review message
                Text(
                  'Verified ratings and reviews from users with similar devices ',
                  style: TextStyle(fontSize: TSizes.fontSizeMd),
                ),
                SizedBox(height: TSizes.spaceBtwItems),

                /// Overall rating widget (4.7 & total reviews)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    OverallRatingWidget(
                      rating: 3.7,
                      reviewCount: 121160,
                    ),
                    SizedBox(width: TSizes.spaceBtwItems),

                    /// Bar chart for the rating distribution
                    RatingsBarChart(),
                  ],
                ),
                SizedBox(height: TSizes.spaceBtwItems),

                /// Review Cards below
                ReviewCard(
                  reviewerName: "John Doe",
                  reviewDate: "03-Nov-2023",
                  rating: 5,
                  comment:
                      "Intuitive user interface and seamless purchase experience.",
                  storeResponse: "Thank you for the kind words.",
                  storeResponseDate: "03-Nov-2023",
                ),
                SizedBox(height: 16),
                ReviewCard(
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
