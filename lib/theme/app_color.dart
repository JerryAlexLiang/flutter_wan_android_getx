import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static const searchBackgroundColor = Color(0xFFF5F5F5);

  // 背景颜色
  static const Color bgColor = Color(0xFFFEDCE0);

// 文字颜色
  static const Color textColor = Color(0xFF3D0007);

// 按钮开始颜色
  static const Color btnColorStart = Color(0xFFFA6B74);

// 按钮结束颜色
  static const Color btnColorEnd = Color(0xFFF89500);

// 按钮投影颜色
  static const Color btnShadowColor = Color(0x33D83131);

  static const colorB8C0D4 = Color(0xFFB8C0D4);

// 输入框边框颜色
  static const Color inputBorderColor = Color(0xFFECECEC);
  static const Color iconLightColor = Colors.blue;
  static const Color iconDarkColor = Colors.red;
  static const Color messageBgLightColor = inputBorderColor;
  static const Color messageBgDarkColor = Colors.grey;

  static const Color dialogCancelTextColor = Color(0xFFBDBDBD);
}

// 按钮渐变背景色
const LinearGradient btnLinearGradient = LinearGradient(
  colors: [
    AppColors.btnColorStart,
    AppColors.btnColorEnd,
  ],
);
