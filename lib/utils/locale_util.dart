import 'package:flutter/cupertino.dart';
import 'package:flutter_wan_android_getx/page/model/language.dart';
import 'package:flutter_wan_android_getx/utils/sp_util.dart';
import 'package:get/get.dart';

/// 语言工具类
class LocaleUtil {
  static const String appLanguageKey = 'language';

  /// 获取当前存储的默认语言格式转Locale
  static Locale? getDefaultLocale() {
    var language = SpUtil.getLanguage();
    if (language == null || language.language == '' || language.country == '') {
      //如果没有存储语言设置，则默认是跟随系统
      return Get.deviceLocale;
    } else {
      return Locale(language.language ?? "", language.country);
    }
  }

  /// 更新系统语言
  static updateLocale(Language language) {
    Locale? locale;
    if (language.language == '' || language.country == "") {
      //设置跟随系统
      locale = Get.deviceLocale;
    } else {
      locale = Locale(language.language ?? "", language.country);
    }
    if (locale != null) {
      Get.updateLocale(locale);
    }
  }
}
