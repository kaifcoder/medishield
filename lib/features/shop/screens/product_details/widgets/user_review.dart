import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserReview extends StatelessWidget {
  const UserReview({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.star),
            Text('4.3'),
            SizedBox(
              width: 8,
            ),
            Text('Excellent'),
          ],
        ),
        SizedBox(
          height: 8,
        ),
        Text('Rating description'),
        SizedBox(
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
