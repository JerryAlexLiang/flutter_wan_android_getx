import 'package:flutter/material.dart';

class DecorationStyle {
  ///圆角图片及模糊度
  static imageDecorationCircle(bool isCircle) {
    return BoxDecoration(
      shape: isCircle ? BoxShape.circle : BoxShape.rectangle,
      color: Colors.transparent,
      border: Border.all(width: 3, color: Colors.pinkAccent),
      borderRadius: isCircle
          ? null
          : const BorderRadiusDirectional.all(
              Radius.circular(100),
            ),
      boxShadow: const [
        BoxShadow(
          color: Colors.white,
          offset: Offset(0, 0),
          //模糊
          blurRadius: 3.0,
          //传播散布
          spreadRadius: 3.0,
        ),
      ],
    );
  }
}
