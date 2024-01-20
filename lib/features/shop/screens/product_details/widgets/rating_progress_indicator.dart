import 'package:flutter/material.dart';
import 'package:medishield/utils/constants/colors.dart';
import 'package:medishield/utils/constants/sizes.dart';
import 'package:medishield/utils/device/device_utility.dart';

class RatingProgressIndicator extends StatelessWidget {
  const RatingProgressIndicator({
    super.key,
    required this.text,
    required this.value,
  });

  final String text;
  final double value;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          flex: 1,
          child: Text(
            text,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
        Expanded(
          flex: 11,
          child: SizedBox(
            width: TDeviceUtils.getScreenWidth(context) * 0.5,
            child: LinearProgressIndicator(
              value: value,
              minHeight: 8,
              backgroundColor: TColors.grey,
              borderRadius: BorderRadius.circular(10),
              valueColor: const AlwaysStoppedAnimation<Color>(TColors.primary),
            ),
          ),
        )
      ],
    );
  }
}
