import 'package:flutter/material.dart';
import '../../constants/constant.dart';

class BackIconButton extends StatelessWidget {
  const BackIconButton({Key key, this.onPressed}) : super(key: key);
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.arrow_back,
        color: AppColors.black.withOpacity(.8),
      ),
      onPressed: onPressed,
    );
  }
}
