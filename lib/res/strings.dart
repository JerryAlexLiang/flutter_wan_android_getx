import 'package:get/get.dart';

class StringsConstant {
  static const String homePage = "首页"; //首页
  static const String accountTreePage = "体系"; //体系
  static const String navigationPage = "导航"; //导航
  static const String projectPage = "项目"; //项目
  static const String minePage = "我的"; //我的
  static const String changeTheme = "更改主题"; //更改主题
  static const String setting = "设置"; //设置
  static const String theme = "主题"; //主题
  static const String settingTheme = "主题设置"; //主题设置
  static const String darkTheme = "夜间模式"; //夜间模式
  static const String lightTheme = "日间模式"; //日间模式
  static const String systemMode = "跟随系统"; //跟随系统
  static const String language = "语言"; //语言
  static const String simplifiedChinese = "简体中文"; //简体中文
  static const String traditionalChineseHongKong = "繁体中文(香港)"; //繁体中文(香港)
  static const String usEnglish = "英语(US)"; //英语
  static const String exitAppToast = "再次点击退出程序";
}

///使用Get配置语言环境
///使用Get.updateLocale(locale);即可更新
class Messages extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        //简体中文
        'zh_CN': {
          StringsConstant.homePage: '首页',
          StringsConstant.accountTreePage: '体系',
          StringsConstant.navigationPage: '导航',
          StringsConstant.projectPage: '项目',
          StringsConstant.minePage: '我的',
          StringsConstant.changeTheme: '更改主题',
          StringsConstant.setting: '设置',
          StringsConstant.theme: '主题',
          StringsConstant.settingTheme: '主题设置',
          StringsConstant.darkTheme: '夜间模式',
          StringsConstant.lightTheme: '日间模式',
          StringsConstant.systemMode: '跟随系统',
          StringsConstant.language: '语言',
          StringsConstant.simplifiedChinese: '简体中文',
          StringsConstant.traditionalChineseHongKong: '繁体中文(香港)',
          StringsConstant.usEnglish: '英语(US)',
          StringsConstant.exitAppToast: '再次点击退出程序',
        },
        //繁体中文（香港）
        'zh_HK': {
          StringsConstant.homePage: '首頁',
          StringsConstant.accountTreePage: '體系',
          StringsConstant.navigationPage: '導航',
          StringsConstant.projectPage: '項目',
          StringsConstant.minePage: '我的',
          StringsConstant.changeTheme: '更改主題',
          StringsConstant.setting: '設置',
          StringsConstant.theme: '主題',
          StringsConstant.settingTheme: '主题設置',
          StringsConstant.darkTheme: '夜間模式',
          StringsConstant.lightTheme: '日間模式',
          StringsConstant.systemMode: '跟隨系統',
          StringsConstant.language: '語言',
          StringsConstant.simplifiedChinese: '简体中文',
          StringsConstant.traditionalChineseHongKong: '繁体中文(香港)',
          StringsConstant.usEnglish: '英語(US)',
          StringsConstant.exitAppToast: '再按一次退出程序',
        },
        //English
        'en_US': {
          StringsConstant.homePage: 'Home',
          StringsConstant.accountTreePage: 'System',
          StringsConstant.navigationPage: 'Navigation',
          StringsConstant.projectPage: 'Project',
          StringsConstant.minePage: 'Mine',
          StringsConstant.changeTheme: 'Change Theme',
          StringsConstant.setting: 'Setting',
          StringsConstant.theme: 'Theme',
          StringsConstant.settingTheme: 'Setting Theme',
          StringsConstant.darkTheme: 'DarkMode',
          StringsConstant.lightTheme: 'LightMode',
          StringsConstant.systemMode: 'Follow The System',
          StringsConstant.language: 'Language',
          StringsConstant.simplifiedChinese: 'Simplified Chinese',
          StringsConstant.traditionalChineseHongKong:
              'Traditional Chinese(HongKong)',
          StringsConstant.usEnglish: 'English(US)',
          StringsConstant.exitAppToast: 'Click Again ToExit The Program',
        },
      };
}
