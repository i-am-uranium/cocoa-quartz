import 'package:flutter/material.dart';
import '../../constants/colors.dart';

class CustomContainer extends StatelessWidget {
  const CustomContainer({
    @required this.child,
    @required this.shadowColor,
    this.borderRadius = 8,
    this.padding = const EdgeInsets.all(8),
    this.color = AppColors.white,
    this.offset = const Offset(0, 8),
    this.blurRadius = 10,
    this.spreadRadius = 0,
    Key key,
  }) : super(key: key);
  final Widget child;
  final Color shadowColor;
  final double borderRadius;
  final EdgeInsets padding;
  final Offset offset;
  final double blurRadius;
  final double spreadRadius;

  final Color color;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.all(
          Radius.circular(borderRadius),
        ),
        boxShadow: [
          BoxShadow(
            offset: offset,
            color: shadowColor,
            blurRadius: blurRadius,
            spreadRadius: spreadRadius,
          ),
        ],
      ),
      child: child,
    );
  }
}
