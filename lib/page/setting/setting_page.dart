import 'package:flutter/material.dart';
import 'package:flutter_wan_android_getx/http/dio_util.dart';
import 'package:flutter_wan_android_getx/page/setting/language/language_controller.dart';
import 'package:flutter_wan_android_getx/page/setting/setting_controller.dart';
import 'package:flutter_wan_android_getx/page/setting/theme/theme_setting_controller.dart';
import 'package:flutter_wan_android_getx/res/strings.dart';
import 'package:flutter_wan_android_getx/routes/app_routes.dart';
import 'package:flutter_wan_android_getx/utils/logger_util.dart';
import 'package:flutter_wan_android_getx/widget/custom_app_bar.dart';
import 'package:flutter_wan_android_getx/widget/custom_list_title.dart';
import 'package:get/get.dart';

class SettingPage extends StatelessWidget {
  final settingController = Get.find<SettingController>();
  final themeSettingController = Get.find<ThemeSettingController>();
  final languageController = Get.find<LanguageController>();

  SettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LoggerUtil.d('SettingPage build', tag: 'SettingPage');

    return Scaffold(
      appBar: CustomAppBar(
        // centerTitle: '设置',
        centerTitle: StringsConstant.setting.tr,
      ),
      body: Obx(() {
        return ListView(
          children: [
            CustomListTitle(
              // title: '主题',
              title: StringsConstant.theme.tr,
              isShowLeftWidget: true,
              leftWidget: context.isDarkMode
                  ? const Icon(Icons.nightlight_round)
                  : const Icon(Icons.wb_sunny_rounded),
              rightContent: themeSettingController.themeTrObs,
              rightImage: 'images/ic_arrow_right.png',
              onTap: () => Get.toNamed(AppRoutes.themeModePage),
            ),
            CustomListTitle(
              // title: '语言',
              title: StringsConstant.language.tr,
              isShowLeftWidget: true,
              leftWidget: const Icon(Icons.language),
              rightContent: languageController.currentLanguage,
              onTap: () => Get.toNamed(AppRoutes.languageModePage),
            ),
            // Visibility(
            //   visible: settingController.isLogin,
            //   child: CustomListTitle(
            //     title: '退出登录',
            //     isShowLeftWidget: true,
            //     leftWidget: const Icon(Icons.logout),
            //     onTap: () => settingController.gotoLogout(),
            //   ),
            // ),
            Obx(() {
              return CustomListTitle(
                title: '${settingController.isLogin}',
                isShowLeftWidget: true,
                leftWidget: const Icon(Icons.logout),
                onTap: () => settingController.gotoLogout(),
              );
            })
          ],
        );
      }),
    );
  }
}
