import 'package:flutter/material.dart';
import 'package:flutter_wan_android_getx/res/gaps.dart';
import 'package:flutter_wan_android_getx/res/r.dart';
import 'package:flutter_wan_android_getx/theme/app_theme.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

/// 类名: load_error_page.dart
/// 创建日期: 11/16/21 on 6:21 PM
/// 描述: 加载错误页面
/// 作者: 杨亮

class LoadErrorPage extends StatelessWidget {
  const LoadErrorPage({
    Key? key,
    required this.onTap,
    required this.errMsg,
  }) : super(key: key);

  final VoidCallback onTap;
  final String? errMsg;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Lottie.asset(
              R.assetsLottieRefreshError,
              width: 200,
              // height: Get.height,
              fit: BoxFit.cover,
              animate: true,
            ),
            Gaps.vGap10,
            Text(
              '$errMsg，点击重试',
              style: context.bodyText1Style,
            ),
          ],
        ),
      ),
    );
  }
}
