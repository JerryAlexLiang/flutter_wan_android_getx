import 'package:flutter/material.dart';
import 'package:flutter_wan_android_getx/page/setting/theme/theme_setting_controller.dart';
import 'package:flutter_wan_android_getx/page/setting/theme/theme_setting_page.dart';
import 'package:flutter_wan_android_getx/routes/app_routes.dart';
import 'package:flutter_wan_android_getx/theme/app_theme.dart';
import 'package:flutter_wan_android_getx/utils/logger_util.dart';
import 'package:get/get.dart';

import 'mine_controller.dart';

class MinePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<MineController>();

    LoggerUtil.d("=======> MinePage build");
    return Center(
      child: MaterialButton(
        onPressed: () {
          // navigator!
          //     .push(
          //     MaterialPageRoute(builder: (context) => ThemeSettingPage()));
          Get.toNamed(AppRoutes.settingPage);
        },
        // child: const Text('更改主题'),
        child: Row(
          children: [
            GetX<ThemeSettingController>(
              init: ThemeSettingController(),
              initState: (_) {},
              builder: (controller) {
                return Icon(
                  controller.themeKeyValue == ThemeKey.darkTheme
                      ? Icons.nightlight_round
                      : Icons.wb_sunny_rounded,
                );
              },
            ),
            const Expanded(
              child: Text('更改主题'),
            ),
          ],
        ),
      ),
    );
  }
}
