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
    this.shadowColor = AppColors.appLogoShadow,
    this.bgColor = AppColors.appLogoBG,
    Key key,
  }) : super(key: key);
  final double width;
  final double height;
  final Color shadowColor;
  final Color bgColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Transform.rotate(
        angle: pi / 4,
        child: CustomContainer(
          color: bgColor,
          shadowColor: shadowColor,
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
