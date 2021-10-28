import 'package:flutter/material.dart';
import 'package:flutter_wan_android_getx/page/setting/theme/theme_setting_controller.dart';
import 'package:flutter_wan_android_getx/page/setting/theme/theme_setting_page.dart';
import 'package:flutter_wan_android_getx/routes/app_routes.dart';
import 'package:flutter_wan_android_getx/theme/app_theme.dart';
import 'package:flutter_wan_android_getx/utils/logger_util.dart';
import 'package:get/get.dart';

import 'mine_controller.dart';

class MinePage extends StatelessWidget {
  const MinePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<MineController>();
    final themeSettingController = Get.find<ThemeSettingController>();

    LoggerUtil.d("=======> MinePage build");
    return Center(
      child: MaterialButton(
        onPressed: () {
          Get.toNamed(AppRoutes.settingPage);
        },
        child: Row(
          children: [
            // GetX<ThemeSettingController>(
            //   init: ThemeSettingController(),
            //   initState: (_) {},
            //   builder: (controller) {
            //     return Icon(
            //       controller.themeKeyValue == ThemeKey.darkTheme
            //           ? Icons.nightlight_round
            //           : Icons.wb_sunny_rounded,
            //     );
            //   },
            // ),
            Icon(
              themeSettingController.themeKeyValue == ThemeKey.darkTheme
                  ? Icons.nightlight_round
                  : Icons.wb_sunny_rounded,
            ),
            Expanded(
              child: Text(
                '更改主题',
                style: TextStyle(
                  // color: Theme.of(context).textTheme.bodyText1?.color,
                  color: context.bodyText1Color,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
