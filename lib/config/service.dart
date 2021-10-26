import 'package:flutter_wan_android_getx/http/dio_util.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Service extends GetxService {
  Future<void> init() async {
    await SharedPreferences.getInstance();
    DioUtil();
  }
}
