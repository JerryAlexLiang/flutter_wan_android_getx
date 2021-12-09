import 'package:flutter/services.dart';

/// 类名: customized_length_formatter.dart
/// 创建日期: 12/7/21 on 6:13 PM
/// 描述: 自定义兼容中文拼音输入法长度限制输入框
/// 作者: 杨亮

class CustomizedLengthTextInputFormatter extends TextInputFormatter {
  final int maxLength;

  CustomizedLengthTextInputFormatter(this.maxLength);

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.isComposingRangeValid) return newValue;
    return LengthLimitingTextInputFormatter(maxLength)
        .formatEditUpdate(oldValue, newValue);
  }
}
