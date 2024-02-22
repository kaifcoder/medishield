import 'package:flutter/material.dart';
import 'package:medishield/features/shop/screens/product_details/widgets/rating_progress_indicator.dart';

class OverallProductRating extends StatelessWidget {
  const OverallProductRating({
    super.key,
    required this.averageRating,
    required this.fiveStarRating,
    required this.fourStarRating,
    required this.threeStarRating,
    required this.twoStarRating,
    required this.oneStarRating,
  });

  final String averageRating;
  final double fiveStarRating;
  final double fourStarRating;
  final double threeStarRating;
  final double twoStarRating;
  final double oneStarRating;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Text(
            averageRating,
            style: Theme.of(context).textTheme.displayLarge,
          ),
        ),
        Expanded(
          flex: 7,
          child: Column(
            children: [
              RatingProgressIndicator(
                text: '5',
                value: fiveStarRating,
              ),
              RatingProgressIndicator(
                text: '4',
                value: fourStarRating,
              ),
              RatingProgressIndicator(
                text: '3',
                value: threeStarRating,
              ),
              RatingProgressIndicator(
                text: '2',
                value: twoStarRating,
              ),
              RatingProgressIndicator(
                text: '1',
                value: oneStarRating,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
