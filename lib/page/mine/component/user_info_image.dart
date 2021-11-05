import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_wan_android_getx/page/mine/mine_controller.dart';
import 'package:flutter_wan_android_getx/res/gaps.dart';
import 'package:flutter_wan_android_getx/routes/app_routes.dart';
import 'package:flutter_wan_android_getx/utils/decoration_style.dart';
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
          Container(
            decoration: DecorationStyle.imageDecorationCircle(true),
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
          Gaps.hGap15,
          Text(
            'Jerry',
            style: TextStyle(
                color: Colors.white,
                fontSize: 23.sp,
                fontWeight: FontWeight.bold),
          ),
          const Expanded(
            child: SizedBox(),
          ),
          Material(
            color: Colors.transparent,
            child: Ink(
              child: InkWell(
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
