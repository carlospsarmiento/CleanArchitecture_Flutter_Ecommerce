import 'package:app_flutter/shared/utils/responsive_utils.dart';
import 'package:flutter/material.dart';

class CustomSeparator extends StatelessWidget {
  final double width;
  final double height;

  const CustomSeparator({super.key, this.width = 0, this.height = 0,});

  @override
  Widget build(BuildContext context) {
    double multiplier = ResponsiveUtils.getMultiplier(context);
    return SizedBox(
      width: width * multiplier,
      height: height * multiplier,
    );
  }
}