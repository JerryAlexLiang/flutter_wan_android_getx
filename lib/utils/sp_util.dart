import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_wan_android_getx/page/model/language.dart';
import 'package:flutter_wan_android_getx/theme/app_theme.dart';
import 'package:flutter_wan_android_getx/utils/locale_util.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SpUtil {
  //存储设置的主题
  static saveAppThemeData(String themeKey) {
    Get.find<SharedPreferences>().setString(ThemeKey.appThemeKey, themeKey);
  }

  //获取存储的主题
  static String? getAppThemeData() {
    return Get.find<SharedPreferences>().getString(ThemeKey.appThemeKey);
  }

  //存储-更新语言格式
  static saveUpdateLanguage(Language language) {
    // Get.find<SharedPreferences>()
    //     .setString(LocaleUtil.appLanguageKey, json.encode(language.toJson()));
    Get.find<SharedPreferences>()
        .setString(LocaleUtil.appLanguageKey, jsonEncode(language.toJson()));
  }

  //获取存储的语言格式
  static Language? getLanguage() {
    try {
      var languageJson =
          Get.find<SharedPreferences>().getString(LocaleUtil.appLanguageKey);
      if (languageJson == null) {
        //如果没有存储语言设置，则默认是跟随系统
        return null;
      } else {
        // return Language().fromJson(json.decode(languageJson));
        return Language().fromJson(jsonDecode(languageJson));
      }
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }
}
