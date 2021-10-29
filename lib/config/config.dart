import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_wan_android_getx/http/dio_util.dart';
import 'package:flutter_wan_android_getx/page/setting/theme/theme_setting_controller.dart';
import 'package:flutter_wan_android_getx/theme/app_theme.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Config {
  // 是否启用代理
  static const proxyEnable = false;

  /// 代理服务IP
  static const proxyIp = '172.16.43.74';

  /// 代理服务端口
  static const proxyPort = 8866;

  static bool isDebug = true;

  /// 是否 release
  static bool get isRelease => const bool.fromEnvironment("dart.vm.product");

  /// 是否第一次打开
  static bool? isFirstOpen;

  //// 保存用户已打开APP
//   static saveAlreadyOpen() {
//     StorageUtil().setBool(STORAGE_DEVICE_FIRST_OPEN_KEY, false);
//   }

  ///在项目启动前做一些初始化操作
  static Future init() async {
    //运行开始
    WidgetsFlutterBinding.ensureInitialized();

    //初始化状态栏
    initStatusBar();

    //初始化持久工具
    await Get.putAsync(() => SharedPreferences.getInstance());
    Get.lazyPut(() => DioUtil());

    var themeSettingController =
        Get.put<ThemeSettingController>(ThemeSettingController());

    //初始化默认主题
    var themeData =
        Get.find<SharedPreferences>().getString(ThemeKey.appThemeKey);

    if (themeData == null) {
      themeSettingController.setLightThemeMode();
    } else {
      if (themeData == ThemeKey.lightTheme) {
        //日间模式
        themeSettingController.setLightThemeMode();
      } else if (themeData == ThemeKey.darkTheme) {
        //夜间模式
        themeSettingController.setDarkThemeMode();
      } else if (themeData == ThemeKey.systemTheme) {
        //跟随系统模式
        themeSettingController.setSystemThemeMode();
      }
    }

    // //是否跟随系统自动切换暗色模式
    // bool? themeMode =
    //     Get.find<SharedPreferences>().getBool(ThemeKey.keyAppThemeMode);
    // themeSettingController.openSystemThemeMode();

    //     // 读取设备第一次打开
//     isFirstOpen = StorageUtil().getBool(STORAGE_DEVICE_FIRST_OPEN_KEY);
//     if (isFirstOpen == null) {
//       isFirstOpen = true;
//     }
  }

  static void initStatusBar() {
    if (Platform.isAndroid) {
      //如果是android设备，状态栏设置为透明沉浸
      SystemUiOverlayStyle _style = const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Colors.transparent,
      );
      SystemChrome.setSystemUIOverlayStyle(_style);
    }
  }
}
