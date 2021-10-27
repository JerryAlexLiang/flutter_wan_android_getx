import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wan_android_getx/theme/app_theme.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import 'theme_setting_controller.dart';

class ThemeSettingPage extends StatelessWidget {
  final controller = Get.find<ThemeSettingController>();

  ThemeSettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('主题设置'),
        centerTitle: true,
      ),
      body: Center(
        child: ListView(
          children: [
            ListTile(
              leading: Text(
                '跟随系统模式',
                style: Get.textTheme.bodyText1,
              ),
              trailing: CupertinoSwitch(
                value: controller.systemThemeModeValue,
                onChanged: (toggles) => controller.openSystemThemeMode(toggles),
              ),
              onTap: () => Fluttertoast.showToast(msg: "msg"),
            ),
            const SizedBox(
              height: 10,
            ),
            Offstage(
              offstage: controller.systemThemeModeValue,
              child: Column(
                children: [
                  MaterialButton(
                    onPressed: () {
                      controller.changeThemeData(Get.isDarkMode
                          ? ThemeKey.lightTheme
                          : ThemeKey.darkTheme);
                    },
                    child: Row(
                      children: [
                        Icon(
                          Get.isDarkMode
                              ? Icons.nightlight_round
                              : Icons.wb_sunny_rounded,
                          color: Get.iconColor,
                        ),
                        Text(Get.isDarkMode ? '夜间模式' : '日间模式'),
                        // Text(controller.themeKey.toString()),
                        Icon(
                          controller.themeKeyValue == ThemeKey.darkTheme
                              ? Icons.nightlight_round
                              : Icons.wb_sunny_rounded,
                        ),
                      ],
                    ),
                  ),
                  SwitchListTile(
                    dense: true,
                    //当前为夜间模式的时候为开启状态
                    value: controller.themeKeyValue == ThemeKey.darkTheme,
                    title: Text(
                      controller.themeKeyValue,
                      style: Get.textTheme.bodyText1,
                    ),
                    onChanged: (toggles) => controller.changeThemeData(
                        toggles ? ThemeKey.darkTheme : ThemeKey.lightTheme),
                  ),
                  ListTile(
                    leading: Text(
                      controller.themeKeyValue,
                      style: Get.textTheme.bodyText1,
                    ),
                    trailing: CupertinoSwitch(
                      value: controller.themeKeyValue == ThemeKey.darkTheme,
                      onChanged: (toggles) => controller.changeThemeData(
                          toggles ? ThemeKey.darkTheme : ThemeKey.lightTheme),
                    ),
                    onTap: () => Fluttertoast.showToast(msg: "msg"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
