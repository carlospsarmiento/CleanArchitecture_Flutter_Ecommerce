import 'package:app_flutter/shared/utils/responsive_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginBanner extends StatelessWidget {
  const LoginBanner({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Container(
      height: !ResponsiveUtils.isSmallScreen(context) ?
        height : null,
      color: !ResponsiveUtils.isSmallScreen(context) ?
          Theme.of(context).colorScheme.primary : null,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: SvgPicture.asset(
            "assets/svg/img_login.svg",
            height: 170
          )
        ),
      )
    );
  }
}