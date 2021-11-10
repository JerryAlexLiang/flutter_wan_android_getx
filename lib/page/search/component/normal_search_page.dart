import 'package:flutter/material.dart';
import 'package:flutter_wan_android_getx/page/search/component/hot_search_list.dart';
import 'package:flutter_wan_android_getx/res/gaps.dart';

/// 类名: normal_search_page.dart
/// 创建日期: 11/10/21 on 5:50 PM
/// 描述: 搜索页热词及历史记录页面
/// 作者: 杨亮

class NormalSearchPage extends StatelessWidget {
  const NormalSearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children:  [
        Gaps.vGap10,
        HotSearchList(),
      ],
    );
  }
}
