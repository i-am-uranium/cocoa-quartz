import 'package:flutter/material.dart';

class HorizontalSpacer extends StatelessWidget {
  const HorizontalSpacer({Key key, this.space = 8}) : super(key: key);
  final double space;

  @override
  Widget build(BuildContext context) => SizedBox(width: space);
}
