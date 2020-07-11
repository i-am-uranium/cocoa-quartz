import 'package:flutter/material.dart';

import 'colors.dart';
import 'font_family.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get theme => _buildTheme();

  static ThemeData _buildTheme() {
    final base = ThemeData.light();
    return base.copyWith(
      accentColor: AppColors.primary,
      primaryColor: AppColors.primary,
      buttonTheme: base.buttonTheme.copyWith(
        buttonColor: AppColors.primary,
        textTheme: ButtonTextTheme.primary,
        disabledColor: AppColors.buttonDisabled,
      ),
      inputDecorationTheme: const InputDecorationTheme(
        labelStyle: TextStyle(
          color: AppColors.primary,
          fontSize: 13,
        ),
        hintStyle: TextStyle(
          color: AppColors.grey,
          fontSize: 13,
        ),
      ),
      errorColor: AppColors.error,
      cursorColor: AppColors.primary,
      textTheme: _buildTextTheme(base.textTheme),
      iconTheme: base.iconTheme.copyWith(
        color: AppColors.primary,
      ),
      primaryIconTheme: base.primaryIconTheme.copyWith(
        color: AppColors.primary,
      ),
    );
  }

  static TextTheme _buildTextTheme(TextTheme base) {
    return base
        .copyWith(
          headline5: base.headline5.copyWith(
            fontWeight: FontWeight.w500,
          ),
          headline6: base.headline6.copyWith(fontSize: 18),
          caption: base.caption.copyWith(
            fontWeight: FontWeight.w400,
            fontSize: 14,
          ),
        )
        .apply(
          fontFamily: FontFamily.poppins,
          displayColor: AppColors.black,
          bodyColor: AppColors.black,
        );
  }
}
