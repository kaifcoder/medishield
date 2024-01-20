import 'package:flutter/material.dart';
import 'package:medishield/common/widgets/custom_shapes/containers/t_circular_container.dart';
import 'package:medishield/common/widgets/custom_shapes/curved_edges/t_curved_edge_widget.dart';
import 'package:medishield/utils/constants/colors.dart';

class TPrimaryHeaderContainer extends StatelessWidget {
  const TPrimaryHeaderContainer({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return TCurvedEdgeWidget(
      child: Container(
        color: TColors.primary,
        padding: EdgeInsets.zero,
        child: SizedBox(
          child: Stack(
            children: [
              Positioned(
                top: -200,
                right: -250,
                child: TCircularContainer(
                  backgroundColor: TColors.white.withOpacity(0.1),
                ),
              ),
              Positioned(
                top: 100,
                right: -320,
                child: TCircularContainer(
                  backgroundColor: TColors.white.withOpacity(0.1),
                  radius: 200,
                ),
              ),
              child,
            ],
          ),
        ),
      ),
    );
  }
}
