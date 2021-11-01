import 'package:flutter_wan_android_getx/generated/json/base/json_convert_content.dart';
import 'package:flutter_wan_android_getx/res/strings.dart';
import 'package:get/get.dart';

class Language with JsonConvert<Language> {
  String? name;
  String? language;
  String? country;
  bool? isSelect = false;

  Language({this.name, this.language, this.country, this.isSelect = false});
}

///新增语言要在此处手动增加
final supportLanguageList = [
  Language(name: StringsConstant.systemMode, language: '', country: ''),
  Language(
      name: StringsConstant.simplifiedChinese,
      language: 'zh',
      country: 'CN'),
  Language(
      name: StringsConstant.traditionalChineseHongKong,
      language: 'zh',
      country: 'HK'),
  Language(name: StringsConstant.usEnglish, language: 'zh', country: 'US'),
];
