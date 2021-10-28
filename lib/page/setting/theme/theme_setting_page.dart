import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wan_android_getx/theme/app_theme.dart';
import 'package:flutter_wan_android_getx/widget/custom_app_bar.dart';
import 'package:flutter_wan_android_getx/widget/custom_list_title.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import 'theme_setting_controller.dart';

class ThemeSettingPage extends StatelessWidget {
  final controller = Get.find<ThemeSettingController>();

  ThemeSettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        centerTitle: '主题设置',
        actionIcon: const Icon(Icons.star),
        // actionName: '主题',
        //invalid constant value.
        // 变量和 const 关键字冲突.将const 关键字去掉即可.
        onRightPressed: () => Fluttertoast.showToast(msg: "msg"),
      ),
      //在 Flutter 官方的介绍中，ScrollPhysics 的作用是 确定可滚动控件的物理特性， 常见的有以下四大金刚：
      // BouncingScrollPhysics ：允许滚动超出边界，但之后内容会反弹回来。
      // ClampingScrollPhysics ： 防止滚动超出边界，夹住 。
      // AlwaysScrollableScrollPhysics ：始终响应用户的滚动。
      // NeverScrollableScrollPhysics ：不响应用户的滚动。
      body: Obx(() {
        return Center(
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              ListTile(
                leading: Text(
                  '跟随系统模式',
                  // style: Theme.of(context).textTheme.bodyText1,
                  style: context.bodyText1Style,
                ),
                trailing: CupertinoSwitch(
                  value: controller.systemThemeModeValue,
                  onChanged: (toggles) =>
                      controller.openSystemThemeMode(toggles),
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
                        controller.changeThemeData(
                            controller.themeKeyValue == ThemeKey.darkTheme
                                ? ThemeKey.lightTheme
                                : ThemeKey.darkTheme);
                      },
                      child: Row(
                        children: [
                          Text(controller.themeKeyValue),
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
                      onTap: () => Fluttertoast.showToast(
                          msg: "ListTile + CupertinoSwitch"),
                    ),
                    CustomListTitle(
                      // isSelectType: true,
                      // isSelect: true,
                      showBottomLine: true,
                      maxLines: 1,
                      title:
                          "主题设置主题设置主题设置主题设置主题设置主题设置主题设置主题设置主题设置主题设置主题设置主题设置主题设置",
                      isShowLeftWidget: true,
                      leftImage: 'images/ic_back_black.png',
                      // leftColor: Colors.yellow,
                      leftWidget: const Icon(Icons.wb_sunny_rounded),
                      // rightContent: "黑夜模式黑夜模式黑夜模式黑夜模式黑夜模式黑夜模式黑夜模式黑夜模式黑夜模式黑夜模式黑夜模式黑夜模式",
                      rightContent: controller.themeKeyValue * 10,
                      // rightImage: 'images/ic_arrow_right.png',
                      // rightWidget: Container(
                      //   padding: const EdgeInsets.only(right: 10),
                      //   child: const Icon(Icons.check, color: Colors.red),
                      // ),
                      onTap: () =>
                          Fluttertoast.showToast(msg: "CustomListTitle"),
                      onLongPress: () => Fluttertoast.showToast(
                          msg: "CustomListTitle onLongPress"),
                      rightWidget: CupertinoSwitch(
                        value: controller.themeKeyValue == ThemeKey.darkTheme,
                        onChanged: (toggles) => controller.changeThemeData(
                            toggles ? ThemeKey.darkTheme : ThemeKey.lightTheme),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
