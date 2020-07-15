import 'package:flutter/material.dart';

import '../../constants/colors.dart';
import '../../constants/constant.dart';

import 'horizontal_spacer.dart';
import 'logo.dart';

class AppLogoWithText extends StatelessWidget {
  const AppLogoWithText({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const AppLogo(),
        const HorizontalSpacer(
          space: 16,
        ),
        Text(
          Strings.appName,
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w300,
            color: AppColors.black.withOpacity(.8),
            letterSpacing: .5,
          ),
        ),
      ],
    );
  }
}
