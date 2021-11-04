import 'dart:async';
import 'package:flutter_wan_android_getx/routes/app_routes.dart';
import 'package:get/get.dart';
import 'package:flutter_wan_android_getx/config/config.dart';

/// 开屏广告页倒计时

class SplashController extends GetxController {
  Timer? _timer;

  //倒计时（单位：秒）10s
  var timeCount = Config.launchTime.obs;

  @override
  void onInit() {
    super.onInit();
    startLaunchTime();
  }

  /// 开启倒计时
  Future<void> startLaunchTime() async {
    Timer(const Duration(milliseconds: 0), () {
      //periodic 周期: 1秒
      _timer = Timer.periodic(const Duration(milliseconds: 1000), (timer) {
        timeCount--;
        if (timeCount <= 0) {
          Timer(const Duration(milliseconds: 500), () {
            //取消倒计时，并跳转主页
            jumpToMain();
          });
        }
      });
    });
  }

  /// 跳转到主页
  void jumpToMain() {
    if (_timer != null) {
      _timer?.cancel();
      //关闭当前页面并跳转到主页
      Get.offAndToNamed(AppRoutes.main);
    }
  }
}
