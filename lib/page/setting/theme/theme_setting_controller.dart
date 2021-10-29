import 'package:flutter/material.dart';
import 'package:flutter_wan_android_getx/theme/app_theme.dart';
import 'package:flutter_wan_android_getx/utils/sp_util.dart';
import 'package:get/get.dart';

class ThemeSettingController extends GetxController {
  /// 主题设置
  final _themeKeyObs = "".obs;

  get themeKeyValue => _themeKeyObs.value;

  set themeKeyValue(string) => _themeKeyObs.value = string;

  //日间模式
  void setLightThemeMode() {
    Get.changeThemeMode(ThemeMode.light);
    //本地保存主题
    themeKeyValue = ThemeKey.lightTheme;
    SpUtil.saveAppThemeData(themeKeyValue);
  }

  //夜间模式
  void setDarkThemeMode() {
    Get.changeThemeMode(ThemeMode.dark);
    //本地保存主题
    themeKeyValue = ThemeKey.darkTheme;
    SpUtil.saveAppThemeData(themeKeyValue);
  }

  //跟随系统模式
  void setSystemThemeMode() {
    Get.changeThemeMode(ThemeMode.system);
    themeKeyValue = ThemeKey.systemTheme;
    SpUtil.saveAppThemeData(themeKeyValue);
  }
}
