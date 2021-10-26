import 'package:flutter/material.dart';
import 'package:flutter_wan_android_getx/theme/app_theme.dart';
import 'package:flutter_wan_android_getx/utils/sp_util.dart';
import 'package:get/get.dart';

class SettingController extends GetxController {
  /// 主题设置
  final _themeKeyObs = "".obs;

  String get themeKey => _themeKeyObs.value;

  final _systemThemeMode = false.obs;

  bool get systemThemeMode => _systemThemeMode.value;

  ///保存当前选择的主题
  void changeThemeData(String themeKey) async {
    //改变主题
    Get.changeTheme(themeDataList![themeKey]!);
    //本地保存主题
    _themeKeyObs.value = themeKey;
    //saveAppThemeData
    SpUtil.saveAppThemeData(themeKey);
  }

  void openSystemThemeMode(bool openSystemThemeMode) {
    openSystemThemeMode
        ? Get.changeThemeMode(ThemeMode.system)
        : Get.changeThemeMode(ThemeMode.light);
    _systemThemeMode.value = openSystemThemeMode;
    SpUtil.saveOpenAppSystemThemeMode(openSystemThemeMode);
  }
}
