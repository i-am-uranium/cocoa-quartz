import 'package:flutter/material.dart';
import '../../constants/constant.dart';

class HorizontalSeparator extends StatelessWidget {
  const HorizontalSeparator({
    @required this.height,
    this.width = 1,
    this.color = AppColors.line,
    Key key,
  }) : super(key: key);

  final double width;
  final double height;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1,
      height: height,
      color: color,
    );
  }
}
