import 'package:flutter/material.dart';

class VerticalSpacer extends StatelessWidget {
  const VerticalSpacer({Key key, this.space = 8}) : super(key: key);
  final double space;

  @override
  Widget build(BuildContext context) => SizedBox(height: space);
}
