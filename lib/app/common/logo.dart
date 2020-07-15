import 'dart:math';

import 'package:flutter/material.dart';

import '../../constants/assets.dart';
import '../../constants/colors.dart';
import '../../constants/constant.dart';
import 'custom_container.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({
    this.width = 50,
    this.height = 50,
    Key key,
  }) : super(key: key);
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
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
