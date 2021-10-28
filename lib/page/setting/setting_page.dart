import 'package:flutter/material.dart';
import 'package:flutter_wan_android_getx/widget/custom_app_bar.dart';
import 'package:get/get.dart';

import 'setting_controller.dart';

class SettingPage extends StatelessWidget {
  final controller = Get.find<SettingController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: '设置',
      ),
      body: ListView(
        children: [

        ],
      ),
    );
  }
}
