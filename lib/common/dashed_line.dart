import 'package:flutter/material.dart';

class DashedLine extends StatelessWidget {
  final double dashWidth;
  final double dashHeight;
  final double dashSpacing;
  final Color color;

  const DashedLine({
    this.dashWidth = 5,
    this.dashHeight = 1,
    this.dashSpacing = 3,
    this.color = Colors.grey,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final boxCount =
            (constraints.constrainWidth() / (dashWidth + dashSpacing)).floor();
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(boxCount, (_) {
            return Container(
              width: dashWidth,
              height: dashHeight,
              color: color,
            );
          }),
        );
      },
    );
  }
}
