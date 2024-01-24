import 'package:flutter/material.dart';

class UserReview extends StatelessWidget {
  const UserReview({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Row(
          children: [
            Icon(Icons.star),
            Text('4.3'),
            SizedBox(
              width: 8,
            ),
            Text('Excellent'),
          ],
        ),
        const SizedBox(
          height: 8,
        ),
        const Text('Rating description'),
        const SizedBox(
          height: 8,
        ),
        Row(
          children: [
            Text(
              'By: User name',
              style: Theme.of(context).textTheme.labelMedium,
            ),
          ],
        )
      ],
    );
  }
}
