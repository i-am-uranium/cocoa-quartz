import 'package:flutter/material.dart';
import '../../constants/constant.dart';

class OnboardingFormRaisedButton extends StatelessWidget {
  const OnboardingFormRaisedButton({
    @required this.text,
    @required this.width,
    this.onClick,
    this.color = AppColors.primary,
    this.textColor = AppColors.white,
    Key key,
  }) : super(key: key);
  final double width;
  final VoidCallback onClick;
  final Color color;
  final String text;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: 46,
      child: RaisedButton(
        color: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        elevation: 2,
        onPressed: onClick,
        child: Text(
          text,
          style: TextStyle(color: textColor),
        ),
      ),
    );
  }
}
