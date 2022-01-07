// ignore_for_file: file_names

import 'package:flutter/material.dart';

/// 类名: sliver_tabBar_delegate.dart
/// 创建日期: 1/6/22 on 5:58 PM
/// 描述: 这里需要自己实现一个Delegate.因为需要停留weight的高度.
/// 作者: 杨亮

class SliverTabBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar widget;
  final Color color;

  SliverTabBarDelegate({required this.widget, required this.color});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      child: widget,
      color: color,
    );
  }

  @override
  bool shouldRebuild(SliverTabBarDelegate oldDelegate) {
    return false;
  }

  @override
  double get maxExtent => widget.preferredSize.height;

  @override
  double get minExtent => widget.preferredSize.height;
}
