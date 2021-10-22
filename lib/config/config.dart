import 'package:flutter/cupertino.dart';
import 'package:flutter_wan_android_getx/http/dio_util.dart';
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

  static Future init() async {
    //运行开始
    WidgetsFlutterBinding.ensureInitialized();

    await SharedPreferences.getInstance();

    DioUtil();

    //     // 读取设备第一次打开
//     isFirstOpen = StorageUtil().getBool(STORAGE_DEVICE_FIRST_OPEN_KEY);
//     if (isFirstOpen == null) {
//       isFirstOpen = true;
//     }
  }
}
