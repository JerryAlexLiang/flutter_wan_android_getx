import 'package:flutter/material.dart';
import 'package:flutter_wan_android_getx/theme/app_color.dart';

///白天模式
ThemeData lightTheme = ThemeData.light().copyWith(
  primaryColor: Colors.blue,
  splashColor: Colors.white12,
  scaffoldBackgroundColor: Colors.white,
  backgroundColor: Colors.grey[200]?.withOpacity(0.7),
  iconTheme: const IconThemeData(
    color: AppColors.iconLightColor,
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    selectedItemColor: AppColors.iconLightColor,
  ),
  textTheme: const TextTheme(
    headline1: TextStyle(
      color: Colors.black,
    ),
    subtitle1: TextStyle(
      color: Colors.grey,
    ),
    headline3: TextStyle(
      color: Colors.black,
    ),
    bodyText1: TextStyle(
      color: Colors.black,
    ),
  ),
);

///夜间模式
ThemeData darkTheme = ThemeData.dark().copyWith(
  primaryColor: Colors.red,
  iconTheme: const IconThemeData(
    color: AppColors.iconDarkColor,
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    selectedItemColor: AppColors.iconDarkColor,
  ),
);

IconThemeData lightIconTheme = const IconThemeData(color: Colors.grey);
IconThemeData darkIconTheme = const IconThemeData(color: Colors.grey);

class ThemeKey {
  static const String keyAppThemeData = "app_theme_data";
  static const String keyAppThemeMode = "app_theme_mode";
  static const String darkTheme = "夜间模式";
  static const String lightTheme = "日间模式";
}

/// 主题列表
Map<String, ThemeData>? themeDataList = {
  ThemeKey.darkTheme: darkTheme,
  ThemeKey.lightTheme: lightTheme,
};

// const primaryColor = Color(0xff171616);
// const primaryLightColor = Color(0xff151515);
// const primaryDarkColor = Color(0xff1d1d1d);
// const secondaryColor = Color(0xff1f1f1f);
// const secondaryLightColor = Color(0xff1c1c1c);
// const secondaryDarkColor = Color(0xff000000);
//
// AppBarTheme get appBarTheme => const AppBarTheme();
//
// ThemeData get appThemeData => ThemeData(
//       primaryColor: primaryColor,
//       primaryColorLight: primaryLightColor,
//       scaffoldBackgroundColor: Colors.white,
//       accentColor: primaryColor,
//       appBarTheme: appBarTheme,
//       iconTheme: const IconThemeData(),
//       textTheme: const TextTheme(),
//     );
