import 'package:flutter/material.dart';

import '../../constants/colors.dart';
import '../common/raised_button.dart';
import '../common/vertical_spacer.dart';

class OnboardingFormLeftView extends StatelessWidget {
  const OnboardingFormLeftView({
    @required this.imageAssets,
    @required this.title,
    @required this.imageWidth,
    @required this.imageHeight,
    @required this.buttonWidth,
    @required this.buttonTitle,
    this.onButtonClick,
    this.buttonColor = AppColors.black,
    this.titleTextColor = AppColors.black,
    this.buttonTextColor = AppColors.white,
    Key key,
  }) : super(key: key);
  final String imageAssets;
  final String title;
  final double imageHeight;
  final double imageWidth;
  final double buttonWidth;
  final String buttonTitle;
  final VoidCallback onButtonClick;
  final Color buttonColor;
  final Color titleTextColor;
  final Color buttonTextColor;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          imageAssets,
          width: imageWidth,
          height: imageHeight,
          fit: BoxFit.cover,
        ),
        Positioned(
          bottom: 88,
          left: imageWidth / 2 - buttonWidth / 2,
          child: Column(
            children: [
              Text(
                title,
                style: TextStyle(
                  color: titleTextColor.withOpacity(.8),
                ),
              ),
              const VerticalSpacer(
                space: 32,
              ),
              OnboardingFormRaisedButton(
                width: buttonWidth,
                onClick: onButtonClick,
                color: buttonColor.withOpacity(.8),
                text: buttonTitle,
                textColor: buttonTextColor,
              )
            ],
          ),
        ),
      ],
    );
  }
}
