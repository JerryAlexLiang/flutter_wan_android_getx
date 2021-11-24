import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_wan_android_getx/theme/app_color.dart';
import 'package:get/get.dart';

///白天模式
ThemeData lightTheme = ThemeData.light().copyWith(
  primaryColor: Colors.blue,
  splashColor: Colors.white12,
  appBarTheme: AppBarTheme(
    systemOverlayStyle: SystemUiOverlayStyle.dark,
    elevation: 0,
    backgroundColor: ThemeData.light().scaffoldBackgroundColor,
    iconTheme: const IconThemeData(color: Colors.black),
  ),
  scaffoldBackgroundColor: ThemeData.light().scaffoldBackgroundColor,
  backgroundColor: Colors.white,
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
    systemOverlayStyle: SystemUiOverlayStyle.light,
    elevation: 0,
    backgroundColor: ThemeData.dark().scaffoldBackgroundColor,
    iconTheme: const IconThemeData(color: Colors.white),
  ),
  scaffoldBackgroundColor: ThemeData.dark().scaffoldBackgroundColor,
  backgroundColor: Colors.black,
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
  Color? get statusBarColor =>
      Theme.of(this).appBarTheme.systemOverlayStyle!.statusBarColor;

  //WrapChip背景填充色
  Color? get chipBackgroundColor {
    return Get.isDarkMode ? Colors.grey.withOpacity(0.2) : Colors.grey[200];
  }

  Color get scaffoldBackgroundColor => Theme.of(this).scaffoldBackgroundColor;

  Color get backgroundColor => Theme.of(this).backgroundColor;

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

  Color? get splashColor => Theme.of(this).splashColor;

  Color? get highlightColor => Theme.of(this).highlightColor;
}

extension StyleExtension on BuildContext {
  TextStyle? get headline1Style => Theme.of(this).textTheme.headline1;

  TextStyle? get headline2Style => Theme.of(this).textTheme.headline2;

  TextStyle? get headline3Style => Theme.of(this).textTheme.headline3;

  TextStyle? get headline4Style => Theme.of(this).textTheme.headline4;

  TextStyle? get headline5Style => Theme.of(this).textTheme.headline5;

  TextStyle? get headline6Style => Theme.of(this).textTheme.headline6;

  TextStyle? get subtitle1Style => Theme.of(this).textTheme.subtitle1;

  TextStyle? get subtitle2Style => Theme.of(this).textTheme.subtitle2;

  TextStyle? get bodyText1Style => Theme.of(this).textTheme.bodyText1;

  TextStyle? get bodyText2Style => Theme.of(this).textTheme.bodyText2;
}
