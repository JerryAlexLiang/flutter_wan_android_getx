import 'package:flutter/material.dart';

class DecorationStyle {
  ///圆角图片及模糊度
  static imageDecorationCircle({
    bool isCircle = false,
    Color color = Colors.transparent,
    Color borderColor = Colors.transparent,
    double borderWidth = 0.0,
    double borderRadius = 0.0,
    Color boxShadowColor = Colors.transparent,
    double boxShadowBlurRadius = 0.0,
    double boxShadowSpreadRadius = 0.0,
    bool borderBottom = false,
    double borderBottomThickness = 0.1,
  }) {
    return BoxDecoration(
      shape: isCircle ? BoxShape.circle : BoxShape.rectangle,
      color: color,
      border: borderBottom
          ? Border(
              bottom: BorderSide(
              width: borderBottomThickness,
              color: borderColor,
            ))
          : Border.all(width: borderWidth, color: borderColor),
      borderRadius: isCircle
          ? null
          : (borderBottom ? null : BorderRadius.circular(borderRadius)),
      boxShadow: [
        BoxShadow(
          color: boxShadowColor,
          offset: const Offset(0, 0),
          //模糊
          blurRadius: boxShadowBlurRadius,
          //传播散布
          spreadRadius: boxShadowSpreadRadius,
        ),
      ],
    );
  }

  /// borderRadius     圆角弧度，isCircle=true时为圆形
  /// borderColor      边框颜色
  /// borderWidth      边框宽度
  /// isCircle         是否为圆形
  /// color            背景色
  static imageProviderDecorationCircle({
    bool isCircle = false,
    Color color = Colors.transparent,
    Color borderColor = Colors.transparent,
    double borderWidth = 0.0,
    double borderRadius = 0.0,
    Color boxShadowColor = Colors.transparent,
    double boxShadowBlurRadius = 0.0,
    double boxShadowSpreadRadius = 0.0,
    required ImageProvider<Object> imageProvider,
    required BoxFit? fit,
  }) {
    return BoxDecoration(
      shape: isCircle ? BoxShape.circle : BoxShape.rectangle,
      color: color,
      border: Border.all(width: borderWidth, color: borderColor),
      borderRadius: isCircle ? null : BorderRadius.circular(borderRadius),
      boxShadow: [
        BoxShadow(
          color: boxShadowColor,
          offset: const Offset(0, 0),
          //模糊
          blurRadius: boxShadowBlurRadius,
          //传播散布
          spreadRadius: boxShadowSpreadRadius,
        ),
      ],
      image: DecorationImage(
        image: imageProvider,
        fit: fit,
        // colorFilter: const ColorFilter.mode(
        //   Colors.red,
        //   BlendMode.colorBurn,
        // ),
      ),
    );
  }
}
