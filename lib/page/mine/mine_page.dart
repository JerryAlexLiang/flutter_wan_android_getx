import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_wan_android_getx/app_user_login_state_controller.dart';
import 'package:flutter_wan_android_getx/base/refresh_paging_state_page.dart';
import 'package:flutter_wan_android_getx/page/mine/component/function_card_text_widget.dart';
import 'package:flutter_wan_android_getx/page/mine/component/user_info_image.dart';
import 'package:flutter_wan_android_getx/page/mine/component/user_info_score.dart';
import 'package:flutter_wan_android_getx/page/setting/theme/theme_setting_controller.dart';
import 'package:flutter_wan_android_getx/res/strings.dart';
import 'package:flutter_wan_android_getx/routes/app_routes.dart';
import 'package:flutter_wan_android_getx/theme/app_theme.dart';
import 'package:flutter_wan_android_getx/utils/logger_util.dart';
import 'package:flutter_wan_android_getx/widget/custom_app_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import 'mine_controller.dart';

class MinePage extends StatelessWidget {
  const MinePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mineController = Get.find<MineController>();
    final themeSettingController = Get.find<ThemeSettingController>();

    LoggerUtil.d("=======> MinePage build");

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        // appBar: customAppBarTitle(mineController),
        body: Stack(
          children: [
            MediaQuery.removePadding(
              context: context,
              removeTop: true,
              child: Obx(() {
                return RefreshPagingStatePage<MineController>(
                  controller: mineController,
                  onPressed: () {},
                  refreshController: mineController.refreshController,
                  scrollController: mineController.scrollController,
                  physics: const BouncingScrollPhysics(),
                  // 已登录时可以下拉刷新，未登录时不能下拉刷新
                  enableRefreshPullDown: loginState ? true : false,
                  enableRefreshPullUp: false,
                  onRefresh: () => mineController.getUserInfo(),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(bottom: 30),
                              height: 220,
                              width: Get.width,
                              child: Image.asset(
                                'images/ic_background.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                            //用户信息头像等
                            const Positioned(
                              left: 20,
                              bottom: 70,
                              top: 70,
                              child: UserInfoImage(),
                            ),
                            //用户信息排名信息等
                            const Positioned(
                              bottom: 5,
                              left: 0,
                              right: 0,
                              child: UserInfoScore(),
                            ),
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(
                              vertical: 10.h, horizontal: 10.w),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: context.backgroundColor,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              FunctionCardTextWidget(
                                0,
                                '收藏',
                                onTap: () => Fluttertoast.showToast(msg: '收藏'),
                              ),
                              FunctionCardTextWidget(
                                1,
                                '分享',
                                onTap: () => Fluttertoast.showToast(msg: '收藏'),
                              ),
                              FunctionCardTextWidget(
                                2,
                                '关注',
                                onTap: () => Fluttertoast.showToast(msg: '收藏'),
                              ),
                              FunctionCardTextWidget(
                                3,
                                '积分',
                                onTap: () => Fluttertoast.showToast(msg: '收藏'),
                              ),
                              FunctionCardTextWidget(
                                0,
                                '历史',
                                onTap: () => Fluttertoast.showToast(msg: '收藏'),
                              ),
                            ],
                          ),
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
                );
              }),
            ),
            customAppBarTitle(context, mineController),
          ],
        ),
      ),
    );
  }

  Widget customAppBarTitle(
      BuildContext context, MineController settingController) {
    return Obx(() {
      return CustomAppBar(
        isBack: false,
        opacity: settingController.percent ?? 0,
        centerTitle: StringsConstant.minePage,
        actionIcon: Icon(
          Icons.settings,
          color: context.appBarIconColor,
        ),
        onRightPressed: () => Get.toNamed(AppRoutes.settingPage),
      );
    });
  }

  imageDecorationCircle(bool isCircle) {
    return BoxDecoration(
      shape: isCircle ? BoxShape.circle : BoxShape.rectangle,
      color: Colors.transparent,
      border: Border.all(width: 3, color: Colors.pinkAccent),
      borderRadius: isCircle
          ? null
          : const BorderRadiusDirectional.all(
              Radius.circular(100),
            ),
      boxShadow: const [
        BoxShadow(
          color: Colors.white,
          offset: Offset(0, 0),
          //模糊
          blurRadius: 3.0,
          //传播散布
          spreadRadius: 3.0,
        ),
      ],
    );
  }
}
