import 'package:flutter/material.dart';
import 'package:flutter_wan_android_getx/page/setting/theme/theme_setting_controller.dart';
import 'package:flutter_wan_android_getx/routes/app_routes.dart';
import 'package:flutter_wan_android_getx/widget/custom_app_bar.dart';
import 'package:flutter_wan_android_getx/widget/custom_list_title.dart';
import 'package:get/get.dart';

import 'setting_controller.dart';

class SettingPage extends StatelessWidget {
  final controller = Get.put(SettingController);
  final themeSettingController = Get.find<ThemeSettingController>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: '设置',
      ),
      body: Obx(() {
        return ListView(
          children: [
            CustomListTitle(
              title: '主题',
              leftWidget: Icon(Icons.wb_sunny_rounded),
              rightContent: themeSettingController.themeKeyValue,
              rightImage: 'images/ic_arrow_right.png',
              onTap: () => Get.toNamed(AppRoutes.themeModePage),
            ),
            // CustomListTitle(
            //   title: '语言',
            //   leftWidget: Icon(Icons.language),
            //   rightContent: '中文',
            //   rightImage: 'images/ic_arrow_right.png',
            // ),
          ],
        );
      }),
    );
  }
}
