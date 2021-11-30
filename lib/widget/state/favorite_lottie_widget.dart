import 'package:flutter/material.dart';
import 'package:flutter_wan_android_getx/res/r.dart';
import 'package:lottie/lottie.dart';

/// 类名: favorite_lottie_widget.dart
/// 创建日期: 11/30/21 on 5:49 PM
/// 描述: 收藏动画
/// 作者: 杨亮

class FavoriteLottieWidget extends StatelessWidget {
  const FavoriteLottieWidget({
    Key? key,
    required this.visible,
    required this.animate,
    required this.repeat,
  }) : super(key: key);

  final bool visible;
  final bool animate;
  final bool repeat;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: visible,
      child: Positioned(
        /// 居中显示
        top: 0,
        bottom: 0,
        left: 0,
        right: 0,
        child: Lottie.asset(
          R.assetsLottieCollectAnimation,
          animate: animate,
          repeat: repeat,
        ),
      ),
    );
  }
}
