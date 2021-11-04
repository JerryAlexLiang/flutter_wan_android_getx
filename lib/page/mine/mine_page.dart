import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_wan_android_getx/page/setting/language/language_page.dart';
import 'package:flutter_wan_android_getx/page/setting/theme/theme_setting_controller.dart';
import 'package:flutter_wan_android_getx/page/setting/theme/theme_setting_page.dart';
import 'package:flutter_wan_android_getx/res/strings.dart';
import 'package:flutter_wan_android_getx/routes/app_routes.dart';
import 'package:flutter_wan_android_getx/theme/app_theme.dart';
import 'package:flutter_wan_android_getx/utils/logger_util.dart';
import 'package:flutter_wan_android_getx/widget/custom_app_bar.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'mine_controller.dart';

class MinePage extends StatelessWidget {
  const MinePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mineController = Get.find<MineController>();
    final themeSettingController = Get.find<ThemeSettingController>();

    LoggerUtil.d("=======> MinePage build");
    // return Center(
    //   child: MaterialButton(
    //     onPressed: () {
    //       Get.toNamed(AppRoutes.settingPage);
    //     },
    //     child: Row(
    //       children: [
    //         context.isDarkMode
    //             ? Icon(
    //                 Icons.nightlight_round,
    //                 color: context.appIconColor,
    //               )
    //             : Icon(
    //                 Icons.wb_sunny_rounded,
    //                 color: context.appIconColor,
    //               ),
    //         Expanded(
    //           child: Text(
    //             // '更改主题',
    //             StringsConstant.changeTheme.tr,
    //             style: TextStyle(
    //               // color: Theme.of(context).textTheme.bodyText1?.color,
    //               color: context.bodyText1Color,
    //             ),
    //           ),
    //         ),
    //       ],
    //     ),
    //   ),
    // );

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        body: Obx(() {
          return Stack(
            children: [
              MediaQuery.removePadding(
                context: context,
                removeTop: true,
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  controller: mineController.scrollController,
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          Container(
                            height: 220,
                            width: Get.width,
                            child: Image.asset(
                              'images/ic_background.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned(
                            left: 20,
                            bottom: 70,
                            top: 70,
                            child: Container(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                clipBehavior: Clip.antiAlias,
                                child: Image.asset(
                                  'images/launch_image.png',
                                  fit: BoxFit.cover,
                                  width: 80,
                                  height: 80,
                                ),
                              ),
                              decoration: imageDecorationCircle(true),
                              padding: EdgeInsets.all(1),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        height: 100,
                        color: Colors.pink,
                        child: Center(
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
                                Container(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(100),
                                    clipBehavior: Clip.antiAlias,
                                    child: Image.asset(
                                      'images/ic_background.png',
                                      fit: BoxFit.cover,
                                      width: 50,
                                      height: 50,
                                    ),
                                  ),
                                  decoration: imageDecorationCircle(true),
                                  padding: EdgeInsets.all(1),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: 500,
                        color: Colors.yellow,
                        child: Center(
                          child: Text("2"),
                        ),
                      ),
                      Container(
                        height: 500,
                        color: Colors.blue,
                        child: Center(
                          child: Text("3"),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              customAppBarTitle(mineController),
            ],
          );
        }),
      ),
    );
  }

  Widget customAppBarTitle(MineController settingController) {
    return Opacity(
      opacity: settingController.percent ?? 0,
      child: CustomAppBar(
        centerTitle: StringsConstant.minePage,
        isBack: false,
      ),
    );
  }

  imageDecorationCircle(bool isCircle) {
    return BoxDecoration(
      shape: isCircle ? BoxShape.circle : BoxShape.rectangle,
      color: Colors.white,
      borderRadius: isCircle
          ? null
          : BorderRadiusDirectional.all(
        Radius.circular(100),
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.white,
          offset: Offset(0, 0),
          //模糊
          blurRadius: 3.0,
          spreadRadius: 3.0,
        ),
      ],
    );
  }
}
