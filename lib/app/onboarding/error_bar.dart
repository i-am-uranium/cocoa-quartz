import 'package:flutter/material.dart';

import '../../constants/constant.dart';
import '../common/common.dart';

class ErrorBar extends StatelessWidget {
  const ErrorBar({
    @required this.width,
    this.height = 0,
    this.message = '',
    this.onCloseButtonClick,
    Key key,
  }) : super(key: key);
  final double width;
  final double height;
  final String message;
  final VoidCallback onCloseButtonClick;
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      width: width,
      height: height,
      duration: const Duration(milliseconds: 1000),
      curve: Curves.easeIn,
      child: CustomContainer(
        borderRadius: 4,
        shadowColor: AppColors.errorBG,
        child: Stack(
          children: [
            Align(
              child: Text(message),
            ),
            Positioned(
              top: 0,
              right: 16,
              child: IconButton(
                icon: const Icon(Icons.close),
                onPressed: onCloseButtonClick,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
