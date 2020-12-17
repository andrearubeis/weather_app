import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTheme {

  static ThemeData get light {
    return ThemeData(
        splashColor: AppColors.black,
        accentColor: AppColors.primaryLight,
        scaffoldBackgroundColor: AppColors.darkerWhite,
        primaryColorLight: AppColors.black,
        primaryColorDark: AppColors.white,
        colorScheme: ColorScheme(
            primary: AppColors.basicsLight1,
            primaryVariant: AppColors.basicsLight2,
            secondary: AppColors.basicsLight3,
            secondaryVariant: AppColors.basicsLight4,
            surface: AppColors.basicsLight5,
            background: AppColors.basicsLight6,
            error: AppColors.statusErrorLight,
            onPrimary: AppColors.graphLight,
            onSecondary: AppColors.black,
            onSurface: AppColors.white,
            onBackground: Colors.transparent,
            onError: Colors.transparent,
            brightness: Brightness.light));
  }

  static ThemeData get dark {
    return ThemeData(
        splashColor: AppColors.black,
        accentColor: AppColors.primaryDark,
        scaffoldBackgroundColor: AppColors.black,
        primaryColorLight: AppColors.white,
        primaryColorDark: AppColors.black,
        colorScheme: ColorScheme(
            primary: AppColors.basicsDark1,
            primaryVariant: AppColors.basicsDark2,
            secondary: AppColors.basicsDark3,
            secondaryVariant: AppColors.basicsDark4,
            surface: AppColors.basicsDark5,
            background: AppColors.basicsDark6,
            error: AppColors.statusErrorDark,
            onPrimary: AppColors.graphDark,
            onSecondary: AppColors.black,
            onSurface: AppColors.white,
            onBackground: Colors.transparent,
            onError: Colors.transparent,
            brightness: Brightness.dark));
  }
}

class WeatherAppTheme {
  static bool isDeviceInDarkMode(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    bool darkModeOn = brightness == Brightness.dark;

    return darkModeOn;
  }

  static Color splashColor(BuildContext context) {
    return Theme.of(context).splashColor;
  }

  static Color primaryAccent(BuildContext context) {
    return Theme.of(context).accentColor;
  }

  static Color primaryText(BuildContext context) {
    return Theme.of(context).primaryColorLight;
  }

  static Color secondaryText(BuildContext context) {
    return Theme.of(context).primaryColorDark;
  }

  static Color basics1(BuildContext context) {
    return Theme.of(context).colorScheme.primary;
  }

  static Color basics2(BuildContext context) {
    return Theme.of(context).colorScheme.primaryVariant;
  }

  static Color basics3(BuildContext context) {
    return Theme.of(context).colorScheme.secondary;
  }

  static Color basics4(BuildContext context) {
    return Theme.of(context).colorScheme.secondaryVariant;
  }

  static Color basics5(BuildContext context) {
    return Theme.of(context).colorScheme.surface;
  }

  static Color basics6(BuildContext context, {double opacity}) {
    return Theme.of(context).colorScheme.background.withOpacity(opacity ?? 0.5);
  }

  static Color status(BuildContext context) {
    return Theme.of(context).colorScheme.error;
  }

  static Color graph(BuildContext context) {
    return Theme.of(context).colorScheme.onPrimary;
  }

  static Color white(BuildContext context) {
    return Theme.of(context).colorScheme.onSurface;
  }

  static Color black(BuildContext context) {
    return Theme.of(context).colorScheme.onSecondary;
  }
}
