import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_wan_android_getx/app_user_login_state_controller.dart';
import 'package:flutter_wan_android_getx/page/mine/mine_controller.dart';
import 'package:flutter_wan_android_getx/res/gaps.dart';
import 'package:get/get.dart';
import 'package:flutter_wan_android_getx/theme/app_theme.dart';

class FunctionCardTextWidget extends GetView<MineController> {
  const FunctionCardTextWidget(
      {required this.count,
      required this.title,
      required this.onTap,
      this.countTextStyle,
      this.titleTextStyle,
      Key? key})
      : super(key: key);

  final int? count;
  final TextStyle? countTextStyle;
  final String title;
  final TextStyle? titleTextStyle;
  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(15.w),
        child: Column(
          children: [
            Text(
              appStateController.isLogin.value ? '$count' : "-",
              style: countTextStyle ??
                  context.bodyText1Style?.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            Gaps.vGap5,
            Text(
              title,
              style: titleTextStyle ??
                  context.bodyText2Style?.copyWith(fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
