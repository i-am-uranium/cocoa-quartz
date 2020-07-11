import 'dart:math';

import 'package:flutter/material.dart';

import '../../constants/assets.dart';
import '../../constants/colors.dart';
import 'custom_container.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
    );
  }
}
