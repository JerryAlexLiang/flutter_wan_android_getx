import 'package:flutter/cupertino.dart';
import 'package:flutter_wan_android_getx/utils/logger_util.dart';

/// 类名: html_utils.dart
/// 创建日期: 11/26/21 on 6:36 PM
/// 描述: HTML工具类封装
/// 作者: 杨亮

class HtmlUtils {
  static String? html2HighLight({required String? html, String? color = 'red'}) {
    // 将<em></em> 强调标签（斜体）更改为 <font/>标签
    // html = html.replaceAll('<em class=\'highlight\'>', '<font color="#f00">');
    html = html?.replaceAll('<em class=\'highlight\'>', '<font color="$color">');
    html = html?.replaceAll('</em>', '</font>');
    LoggerUtil.d('html2HighLight=======>  $html');
    // eg: <font color="#f00">Flutter</font> 安卓 Platform 与 <font color="#f00">Dart</font> 端消息通信方式 Channel 源码解析
    return html;
  }
}
