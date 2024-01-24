import 'package:flutter/material.dart';
import 'package:medishield/utils/constants/colors.dart';
import 'package:shimmer/shimmer.dart';

class CustomShimmer extends StatelessWidget {
  const CustomShimmer(
      {super.key,
      required this.height,
      required this.width,
      this.radius = 15,
      this.color});

  final double height, width, radius;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: color ?? Colors.grey[300]!,
      highlightColor: color ?? Colors.grey[100]!,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: color ?? TColors.white,
          borderRadius: BorderRadius.circular(radius),
        ),
      ),
    );
  }
}
