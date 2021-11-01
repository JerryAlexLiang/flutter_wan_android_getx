import 'package:flutter/material.dart';
import 'package:flutter_wan_android_getx/page/setting/theme/theme_setting_controller.dart';
import 'package:flutter_wan_android_getx/res/strings.dart';
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
            context.isDarkMode
                ? Icon(
                    Icons.nightlight_round,
                    color: context.appIconColor,
                  )
                : Icon(
                    Icons.wb_sunny_rounded,
                    color: context.appIconColor,
                  ),
            Expanded(
              child: Text(
                // '更改主题',
                StringsConstant.changeTheme.tr,
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
