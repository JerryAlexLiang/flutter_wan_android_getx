import 'package:flutter/material.dart';
import 'package:flutter_wan_android_getx/res/gaps.dart';
import 'package:flutter_wan_android_getx/res/r.dart';
import 'package:flutter_wan_android_getx/theme/app_color.dart';
import 'package:flutter_wan_android_getx/theme/app_theme.dart';
import 'package:flutter_wan_android_getx/widget/state/load_state.dart';
import 'package:lottie/lottie.dart';

/// 类名: load_error_page.dart
/// 创建日期: 11/16/21 on 6:21 PM
/// 描述: 加载错误页面
/// 作者: 杨亮

class EmptyErrorStatePage extends StatelessWidget {
  const EmptyErrorStatePage({
    Key? key,
    required this.loadState,
    required this.onTap,
    required this.errMsg,
  }) : super(key: key);

  /// 页面类型
  final LoadState loadState;
  final VoidCallback onTap;
  final String? errMsg;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SafeArea(
        child: Scaffold(
          body: Container(
            alignment: Alignment.center,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Gaps.vGap150,
                Container(
                  child: Lottie.asset(
                    loadState == LoadState.empty
                        ? R.assetsLottieRefreshEmpty
                        : R.assetsLottieRefreshError,
                    width: 200,
                    fit: BoxFit.cover,
                    animate: true,
                  ),
                ),
                loadState == LoadState.empty ? Gaps.empty : Gaps.vGap26,
                Text(
                  '$errMsg，点击重试',
                  style: context.bodyText2Style!.copyWith(
                    color: AppColors.colorB8C0D4,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
