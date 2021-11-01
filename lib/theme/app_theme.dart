import 'package:flutter/material.dart';
import 'package:flutter_wan_android_getx/theme/app_color.dart';
import 'package:get/get.dart';

///白天模式
ThemeData lightTheme = ThemeData.light().copyWith(
  primaryColor: Colors.blue,
  splashColor: Colors.white12,
  appBarTheme: const AppBarTheme(
    elevation: 0,
    backgroundColor: Colors.white,
    iconTheme: IconThemeData(color: Colors.black),
  ),
  scaffoldBackgroundColor: Colors.white,
  backgroundColor: Colors.grey[200]?.withOpacity(0.7),
  iconTheme: const IconThemeData(
    color: AppColors.iconLightColor,
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    selectedItemColor: AppColors.iconLightColor,
  ),
  // textTheme: const TextTheme(
  //   headline1: TextStyle(
  //     color: Colors.black,
  //   ),
  //   headline3: TextStyle(
  //     color: Colors.black,
  //   ),
  //   subtitle1: TextStyle(
  //     color: Colors.black,
  //   ),
  //   bodyText1: TextStyle(
  //     color: Colors.black,
  //   ),
  //   bodyText2: TextStyle(
  //     color: Colors.black54,
  //   ),
  // ),
);

///夜间模式
ThemeData darkTheme = ThemeData.dark().copyWith(
  appBarTheme: AppBarTheme(
    elevation: 0,
    backgroundColor: ThemeData.dark().scaffoldBackgroundColor,
    iconTheme: const IconThemeData(color: Colors.white),
  ),
  scaffoldBackgroundColor: ThemeData.dark().scaffoldBackgroundColor,
  // backgroundColor: ThemeData.dark().backgroundColor,
  backgroundColor: Colors.red,
  iconTheme: const IconThemeData(
    color: AppColors.iconDarkColor,
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    selectedItemColor: AppColors.iconLightColor,
  ),
);

class ThemeKey {
  static const String appThemeKey = "app_theme_data";
  static const String darkTheme = "夜间模式";
  static const String lightTheme = "日间模式";
  static const String systemTheme = "跟随系统";
}

/// 主题列表
Map<String, ThemeData>? themeDataList = {
  ThemeKey.darkTheme: darkTheme,
  ThemeKey.lightTheme: lightTheme,
};

bool isDarkMode(BuildContext context) {
  return Theme.of(context).colorScheme.brightness == Brightness.dark;
}

extension ThemeExtension on BuildContext {
  Color get backgroundColor => Theme.of(this).scaffoldBackgroundColor;

  Color? get appBarBackgroundColor =>
      Theme.of(this).appBarTheme.backgroundColor;

  Color? get appIconColor => Theme.of(this).iconTheme.color;

  Color? get appBarIconColor => Theme.of(this).appBarTheme.iconTheme?.color;

  Color get dialogBackgroundColor => Theme.of(this).canvasColor;

  Color? get headline1Color => Theme.of(this).textTheme.headline1?.color;

  Color? get subtitle1Color => Theme.of(this).textTheme.subtitle1?.color;

  Color? get subtitle2Color => Theme.of(this).textTheme.subtitle2?.color;

  Color? get bodyText1Color => Theme.of(this).textTheme.bodyText1?.color;

  Color? get bodyText2Color => Theme.of(this).textTheme.bodyText2?.color;

  Color? get iconDataColor => Theme.of(this).iconTheme.color;

  Color? get bottomNavigationBarBackgroundColor =>
      Theme.of(this).bottomNavigationBarTheme.backgroundColor;

  Color? get bottomNavigationBarSelectedItemColor =>
      Theme.of(this).bottomNavigationBarTheme.selectedItemColor;

  Color? get bottomNavigationBarUnSelectedItemColor =>
      Theme.of(this).bottomNavigationBarTheme.unselectedItemColor;
}

extension StyleExtension on BuildContext {
  TextStyle? get headline1Style => Theme.of(this).textTheme.headline1;

  TextStyle? get subtitle1Style => Theme.of(this).textTheme.subtitle1;

  TextStyle? get subtitle2Style => Theme.of(this).textTheme.subtitle2;

  TextStyle? get bodyText1Style => Theme.of(this).textTheme.bodyText1;

  TextStyle? get bodyText2Style => Theme.of(this).textTheme.bodyText2;
}
