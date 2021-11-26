import 'package:flutter/material.dart';
import 'package:flutter_wan_android_getx/utils/decoration_style.dart';

/// 类名: custom_point_widget.dart
/// 创建日期: 11/26/21 on 6:29 PM
/// 描述: 圆点
/// 作者: 杨亮

class CustomPointWidget extends StatelessWidget {
  const CustomPointWidget({
    Key? key,
    required this.thickness,
    required this.color,
  }) : super(key: key);

  final double thickness;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      width: thickness,
      height: thickness,
      decoration: DecorationStyle.imageDecorationCircle(
        isCircle: true,
        color: color,
      ),
    );
  }
}
