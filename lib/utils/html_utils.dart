import 'package:flutter/cupertino.dart';

/// 类名: html_utils.dart
/// 创建日期: 11/26/21 on 6:36 PM
/// 描述: HTML工具类封装
/// 作者: 杨亮

class HtmlUtils {
  static String html2HighLight(String html) {
    html = html.replaceAll('<em class=\'highlight\'>', '<font color="#f00">');
    html = html.replaceAll('</em>', '</font>');
    html = '<font color="#000">$html</font>';
    return html;
  }
}
