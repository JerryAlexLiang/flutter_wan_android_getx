import 'package:flutter/material.dart';
import 'package:flutter_wan_android_getx/theme/app_theme.dart';
import 'package:flutter_wan_android_getx/utils/sp_util.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class ThemeSettingController extends GetxController {
  /// 主题设置
  final _themeKeyObs = "".obs;

  get themeKeyValue => _themeKeyObs.value;

  set themeKeyValue(string) => _themeKeyObs.value = string;

  /// 跟随系统模式
  final _systemThemeModeObs = false.obs;

  bool get systemThemeModeValue => _systemThemeModeObs.value;

  set systemThemeModeValue(value) => _systemThemeModeObs.value = value;

  ///保存当前选择的主题
  void changeThemeData(String themeKey) async {
    //改变主题
    Get.changeTheme(themeDataList![themeKey]!);
    //本地保存主题
    // _themeKeyObs.value = themeKey;
    themeKeyValue = themeKey;
    //saveAppThemeData
    SpUtil.saveAppThemeData(themeKey);
  }

  void openSystemThemeMode(bool openSystemThemeMode) {
    // openSystemThemeMode
    //     ? Get.changeThemeMode(ThemeMode.system)
    //     : Get.changeThemeMode(ThemeMode.light);
    if (openSystemThemeMode) {
      Get.changeThemeMode(ThemeMode.system);
      // if(themeKeyValue == ThemeKey.darkTheme){
      //   changeThemeData(ThemeKey.darkTheme);
      // }else{
      //   changeThemeData(ThemeKey.lightTheme);
    }else{
      if(Get.isDarkMode){
        themeKeyValue = ThemeKey.darkTheme;
        Get.changeThemeMode(ThemeMode.dark);
      }else{
        themeKeyValue = ThemeKey.lightTheme;
        Get.changeThemeMode(ThemeMode.light);
      }
    }
    systemThemeModeValue = openSystemThemeMode;
    SpUtil.saveOpenAppSystemThemeMode(openSystemThemeMode);
  }
}
