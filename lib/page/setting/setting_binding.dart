import 'package:flutter_wan_android_getx/page/setting/language/language_controller.dart';
import 'package:get/get.dart';

import 'setting_controller.dart';

class SettingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SettingController());
    Get.lazyPut(() => LanguageController());
  }
}
