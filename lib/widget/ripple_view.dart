import 'package:flutter/material.dart';
import 'package:flutter_wan_android_getx/theme/app_theme.dart';

/// 类名: ripple_view.dart
/// 创建日期: 11/12/21 on 5:37 PM
/// 描述: 封装InkWell点击水波纹效果组件
/// 作者: 杨亮

class RippleView extends StatelessWidget {
  const RippleView({
    Key? key,
    required this.onTap,
    this.onLongPress,
    this.radius = 0.0,
    required this.child,
    this.splashColor,
    this.highlightColor,
    this.color,
    this.border,
  }) : super(key: key);

  final VoidCallback onTap;
  final VoidCallback? onLongPress;
  final double radius;
  final Color? splashColor;
  final Color? highlightColor;
  final Color? color;
  final BoxBorder? border;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Ink(
        decoration: BoxDecoration(
          // color: Colors.white,
          color: color ?? context.scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(radius),
          border: border,
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(radius),
          splashColor: splashColor ?? Colors.transparent.withOpacity(0.1),
          highlightColor: highlightColor ?? context.highlightColor,
          child: child,
          onTap: onTap,
          onLongPress: onLongPress,
        ),
      ),
    );
  }
}
