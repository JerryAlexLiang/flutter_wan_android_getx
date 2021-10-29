import 'package:flutter/material.dart';
import 'package:flutter_wan_android_getx/page/setting/setting_controller.dart';
import 'package:flutter_wan_android_getx/page/setting/theme/theme_setting_controller.dart';
import 'package:flutter_wan_android_getx/routes/app_routes.dart';
import 'package:flutter_wan_android_getx/widget/custom_app_bar.dart';
import 'package:flutter_wan_android_getx/widget/custom_list_title.dart';
import 'package:get/get.dart';

class SettingPage extends StatelessWidget {
  final settingController = Get.find<SettingController>();
  final themeSettingController = Get.find<ThemeSettingController>();

  SettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        centerTitle: '设置',
      ),
      body: Obx(() {
        return ListView(
          children: [
            CustomListTitle(
              title: '主题',
              isShowLeftWidget: true,
              leftWidget: context.isDarkMode
                  ? const Icon(Icons.nightlight_round)
                  : const Icon(Icons.wb_sunny_rounded),
              rightContent: themeSettingController.themeKeyValue,
              rightImage: 'images/ic_arrow_right.png',
              onTap: () => Get.toNamed(AppRoutes.themeModePage),
            ),
          ],
        );
      }),
    );
  }
}
