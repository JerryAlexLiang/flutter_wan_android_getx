import 'package:flutter_wan_android_getx/generated/json/base/json_convert_content.dart';

/// 类名: hot_search_model.dart
/// 创建日期: 11/10/21 on 3:21 PM
/// 描述: 热门搜索
/// 作者: 杨亮

class HotSearchModel with JsonConvert<HotSearchModel> {
  double? id;
  String? link;
  String? name;
  double? order;
  double? visible;
}
