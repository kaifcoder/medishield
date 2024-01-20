import 'package:flutter/material.dart';
import 'package:medishield/utils/constants/colors.dart';
import 'package:medishield/utils/constants/sizes.dart';

class QnA extends StatelessWidget {
  const QnA(
      {super.key,
      required this.index,
      required this.question,
      required this.answer});

  final int index;
  final String question, answer;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Ques. $index: $question',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        SizedBox(
          height: TSizes.sm / 2,
        ),
        Text(
          'Answer: $answer',
          style: Theme.of(context).textTheme.bodyMedium!.apply(
                color: TColors.primary,
              ),
        ),
      ],
    );
  }
}
