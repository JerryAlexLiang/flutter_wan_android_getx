import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_wan_android_getx/res/strings.dart';
import 'package:get/get.dart';
import 'splash_controller.dart';

/// 开屏广告页倒计时

class SplashPage extends StatelessWidget {
  final controller = Get.find<SplashController>();

  SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          ConstrainedBox(
            constraints: const BoxConstraints.expand(),
            child: Image.asset(
              'images/splash_bkpp.png',
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: 30.h,
            right: 20.w,
            child: Material(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(20.r),
              child: InkWell(
                borderRadius: BorderRadius.circular(20.r),
                onTap: () => controller.jumpToMain(),
                child: Container(
                  padding: EdgeInsets.fromLTRB(10.w, 5.h, 10.w, 5.h),
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(0, 0, 0, 0.2),
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Obx(() {
                    return Center(
                      child: Text(
                        '${controller.timeCount}  ${StringsConstant.jumpSplash.tr}',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 13.sp,
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
