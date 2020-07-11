import 'package:flutter/material.dart';
import '../../constants/colors.dart';

class CustomContainer extends StatelessWidget {
  const CustomContainer({
    @required this.child,
    @required this.shadowColor,
    this.borderRadius = 8,
    this.padding = const EdgeInsets.all(8),
    this.color = AppColors.white,
    Key key,
  }) : super(key: key);
  final Widget child;
  final Color shadowColor;
  final double borderRadius;
  final EdgeInsets padding;

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
            offset: const Offset(0, 8),
            color: shadowColor,
            blurRadius: 10,
          ),
        ],
      ),
      child: child,
    );
  }
}
