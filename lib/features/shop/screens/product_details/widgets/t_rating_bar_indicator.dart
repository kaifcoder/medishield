import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:medishield/utils/constants/colors.dart';

class TRatingBarIndicator extends StatelessWidget {
  const TRatingBarIndicator({
    super.key,
    required this.rating,
  });
  final double rating;

  @override
  Widget build(BuildContext context) {
    return RatingBarIndicator(
      itemBuilder: (context, index) => const Icon(
        Icons.star,
        color: TColors.primary,
      ),
      rating: rating,
      unratedColor: TColors.grey,
      itemCount: 5,
      itemSize: 16,
      direction: Axis.horizontal,
    );
  }
}
