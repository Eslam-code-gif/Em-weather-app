import 'package:flutter/material.dart';
import 'package:minimal_weather_app/const/styles.dart';
ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    surface: AppColors.backgroundLight,
    primary: AppColors.primaryLight,
    secondary: AppColors.secondaryLight
  )
);

ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,

    colorScheme: ColorScheme.dark(
        surface: AppColors.backgroundDark,
        primary: AppColors.primaryDark,
        secondary: AppColors.secondaryDark
    )
);