import 'package:flutter/material.dart';

class UserReview extends StatelessWidget {
  const UserReview(
      {super.key,
      required this.rating,
      required this.description,
      required this.userName});

  final String rating, description, userName;

  @override
  Widget build(BuildContext context) {
    title(rating) {
      if (rating == '5') {
        return 'Excellent';
      } else if (rating == '4') {
        return 'Good';
      } else if (rating == '3') {
        return 'Average';
      } else if (rating == '2') {
        return 'Poor';
      } else if (rating == '1') {
        return 'Very Poor';
      } else {
        return 'No Rating';
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.star),
            Text(rating),
            const SizedBox(
              width: 8,
            ),
            Text(
              title(rating),
              style: Theme.of(context).textTheme.labelMedium,
            ),
          ],
        ),
        const SizedBox(
          height: 8,
        ),
        Text(description),
        const SizedBox(
          height: 8,
        ),
        Row(
          children: [
            Text(
              'By: $userName',
              style: Theme.of(context).textTheme.labelMedium,
            ),
          ],
        )
      ],
    );
  }
}
