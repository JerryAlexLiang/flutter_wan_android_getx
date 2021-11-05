import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_wan_android_getx/page/mine/mine_controller.dart';
import 'package:flutter_wan_android_getx/res/gaps.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

/// 用户信息排名信息等
class UserInfoScore extends GetView<MineController> {
  const UserInfoScore({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.h,
      width: Get.width,
      padding: EdgeInsets.symmetric(horizontal: 10.sp),
      margin: EdgeInsets.symmetric(horizontal: 10.sp),
      decoration: BoxDecoration(
        color: Colors.transparent.withOpacity(0.2),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.white, width: 0.2),
      ),
      child: Row(
        children: [
          Container(
            alignment: Alignment.center,
            child: Material(
              color: Colors.transparent,
              child: Ink(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.greenAccent,
                ),
                child: InkWell(
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.w,
                      vertical: 5.h,
                    ),
                    child: Text("级别级别级别"),
                  ),
                ),
              ),
            ),
          ),
          Gaps.hGap10,
          Container(
            alignment: Alignment.centerLeft,
            child: Material(
              color: Colors.transparent,
              child: Ink(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.lightGreenAccent,
                ),
                child: InkWell(
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.w,
                      vertical: 5.h,
                    ),
                    child: Text("级别"),
                  ),
                ),
              ),
            ),
          ),
          const Spacer(),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.message,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
