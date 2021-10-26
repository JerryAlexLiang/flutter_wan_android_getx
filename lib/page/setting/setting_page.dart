import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wan_android_getx/theme/app_theme.dart';
import 'package:flutter_wan_android_getx/utils/sp_util.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import 'setting_controller.dart';

class SettingPage extends StatelessWidget {
  final controller = Get.find<SettingController>();

  SettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const SizedBox(
            height: 50,
          ),
          ListTile(
            leading: Text(
              '跟随系统模式',
              style: Get.textTheme.bodyText1,
            ),
            trailing: CupertinoSwitch(
              value: controller.systemThemeMode,
              onChanged: (toggles) => controller.openSystemThemeMode(toggles),
            ),
            onTap: () => Fluttertoast.showToast(msg: "msg"),
          ),
          const SizedBox(
            height: 30,
          ),
          Offstage(
            offstage: controller.systemThemeMode,
            child: Column(
              children: [
                const Icon(Icons.wb_sunny_rounded),
                const Icon(Icons.nightlight_round),
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
                      // Text(Get.isDarkMode ? '夜间模式' : '日间模式'),
                      Text(controller.themeKey.toString()),
                      Icon(
                        controller.themeKey == ThemeKey.darkTheme
                            ? Icons.nightlight_round
                            : Icons.wb_sunny_rounded,
                      )
                    ],
                  ),
                ),
                SwitchListTile(
                  dense: true,
                  //当前为夜间模式的时候为开启状态
                  value: controller.themeKey == ThemeKey.darkTheme,
                  title: Text(
                    controller.themeKey.toString(),
                    style: Get.textTheme.bodyText1,
                  ),
                  onChanged: (toggles) => controller.changeThemeData(
                      toggles ? ThemeKey.darkTheme : ThemeKey.lightTheme),
                ),
                ListTile(
                  leading: Text(
                    controller.themeKey.toString(),
                    style: Get.textTheme.bodyText1,
                  ),
                  trailing: CupertinoSwitch(
                    value: controller.themeKey == ThemeKey.darkTheme,
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
    );
  }
}
