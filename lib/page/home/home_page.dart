import 'package:flutter/material.dart';
import 'package:flutter_wan_android_getx/utils/logger_util.dart';
import 'package:get/get.dart';

import 'home_controller.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();

    LoggerUtil.d("=======> HomePage build");

    return  const Icon(Icons.star);
  }
}
