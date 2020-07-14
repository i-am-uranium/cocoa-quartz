import 'dart:math';

import 'package:flutter/material.dart';

import '../../constants/assets.dart';
import '../../constants/colors.dart';
import '../../constants/constant.dart';
import 'custom_container.dart';
import 'horizontal_spacer.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 50,
          height: 50,
          child: Transform.rotate(
            angle: pi / 4,
            child: CustomContainer(
              color: AppColors.appLogoBG,
              shadowColor: AppColors.appLogoShadow,
              child: Image.asset(
                Assets.logoPng,
                width: 40,
                height: 40,
              ),
            ),
          ),
        ),
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
