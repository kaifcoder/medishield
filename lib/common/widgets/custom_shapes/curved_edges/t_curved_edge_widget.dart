import 'package:flutter/material.dart';
import 'package:medishield/common/widgets/custom_shapes/curved_edges/t_custom_edge.dart';

class TCurvedEdgeWidget extends StatelessWidget {
  const TCurvedEdgeWidget({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ClipPath(
        clipBehavior: Clip.antiAlias,
        clipper: TCustomCurvedEdges(),
        child: child);
  }
}
