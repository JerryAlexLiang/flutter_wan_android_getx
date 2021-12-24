import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_wan_android_getx/app_user_login_state_controller.dart';
import 'package:flutter_wan_android_getx/page/auth_middle_page.dart';
import 'package:flutter_wan_android_getx/page/mine/mine_controller.dart';
import 'package:flutter_wan_android_getx/page/search/search_page.dart';
import 'package:flutter_wan_android_getx/res/gaps.dart';
import 'package:flutter_wan_android_getx/res/strings.dart';
import 'package:flutter_wan_android_getx/routes/app_routes.dart';
import 'package:flutter_wan_android_getx/utils/decoration_style.dart';
import 'package:flutter_wan_android_getx/utils/logger_util.dart';
import 'package:flutter_wan_android_getx/utils/sp_util.dart';
import 'package:flutter_wan_android_getx/widget/ripple_view.dart';
import 'package:get/get.dart';

/// 用户信息头像等
class UserInfoImage extends GetView<MineController> {
  const UserInfoImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width,
      child: Row(
        children: [
          RippleView(
            radius: 100,
            onTap: () => Get.to(
              AuthMiddlePage(
                child: SearchPage(),
              ),
              transition: Transition.native,
            ),
            child: Container(
              decoration: DecorationStyle.imageDecorationCircle(
                isCircle: true,
                // borderRadius: 10,
                borderWidth: 3,
                borderColor: Colors.pinkAccent,
                boxShadowBlurRadius: 3,
                boxShadowSpreadRadius: 3,
                boxShadowColor: Colors.white.withOpacity(0.8),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                clipBehavior: Clip.antiAlias,
                child: Image.asset(
                  'images/launch_image.png',
                  fit: BoxFit.contain,
                  width: 80,
                  height: 80,
                ),
              ),
            ),
          ),
          Gaps.hGap15,
          Obx(() {
            return Text(
              loginState
                  ? '${appStateController.userInfo.value.nickname}'
                  : StringsConstant.loginContent.tr,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 23.sp,
                  fontWeight: FontWeight.bold),
            );
          }),
          const Expanded(
            child: SizedBox(),
          ),
          Material(
            color: Colors.transparent,
            child: Ink(
              child: InkWell(
                splashColor: Colors.transparent.withOpacity(0.1),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                ),
                onTap: () => Get.toNamed(AppRoutes.settingPage),
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                  ),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 30,
                    ),
                    color: Colors.transparent.withOpacity(0.2),
                    child: const Icon(
                      Icons.settings,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
