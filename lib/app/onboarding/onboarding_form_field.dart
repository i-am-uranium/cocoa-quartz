import 'package:flutter/material.dart';

import '../../constants/constant.dart';
import '../common/custom_container.dart';

class OnboardingFormTextField extends StatelessWidget {
  const OnboardingFormTextField({
    @required this.width,
    @required this.height,
    @required this.label,
    @required this.hint,
    this.obscureText = false,
    this.controller,
    this.textInputType = TextInputType.emailAddress,
    Key key,
  }) : super(key: key);
  final double width;
  final double height;
  final String label;
  final String hint;
  final TextEditingController controller;
  final bool obscureText;
  final TextInputType textInputType;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Center(
        child: CustomContainer(
          color: AppColors.mainBG,
          shadowColor: AppColors.onboardingFormBG,
          child: TextFormField(
            controller: controller,
            keyboardType: obscureText ? TextInputType.text : textInputType,
            cursorColor: AppColors.primary,
            obscureText: obscureText,
            decoration: InputDecoration(
              labelText: label,
              contentPadding: const EdgeInsets.only(
                left: 16,
              ),
              hintText: hint,
              border: InputBorder.none,
            ),
          ),
        ),
      ),
    );
  }
}
