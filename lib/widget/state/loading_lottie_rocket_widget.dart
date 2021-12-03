import 'package:flutter/material.dart';
import 'package:flutter_wan_android_getx/res/r.dart';
import 'package:lottie/lottie.dart';

/// 类名: favorite_lottie_widget.dart
/// 创建日期: 11/30/21 on 5:49 PM
/// 描述: Lottie loading 动画
/// 作者: 杨亮

class LoadingLottieRocketWidget extends StatelessWidget {
  const LoadingLottieRocketWidget({
    Key? key,
    this.lottieAsset,
    required this.visible,
    required this.animate,
    required this.repeat,
    this.width,
    this.height,
    this.fit,
  }) : super(key: key);

  final String? lottieAsset;
  final bool visible;
  final bool animate;
  final bool repeat;
  final double? width;
  final double? height;
  final BoxFit? fit;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: visible,
      child: Lottie.asset(
        lottieAsset ?? R.assetsLottieRocketLoadingAnimation,
        animate: animate,
        repeat: repeat,
        width: width,
        height: height,
        fit: fit,
      ),
    );
  }
}
