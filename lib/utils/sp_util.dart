import 'package:flutter_wan_android_getx/theme/app_theme.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SpUtil {
  //存储设置的主题
  static saveAppThemeData(String themeKey) {
    Get.find<SharedPreferences>().setString(ThemeKey.appThemeKey, themeKey);
  }
}
