import 'package:flutter/material.dart';

/// 类名: sliver_appbar_delegate.dart
/// 创建日期: 12/23/21 on 3:18 PM
/// 描述: 代理类SliverAppBarDelegate继承自SliverPersistentHeaderDelegate，后者是专门用来配置SliverPersistentHeader的代理对象。
/// 可以通过继承使用SliverAppBarDelegate的minHeight和maxHeight属性使这个头部对象根据滚动幅度在指定范围内播放伸缩动画。
/// build()方法用来构建顶部组件的具体视图，shouldRebuild用来确定需要重新构建的条件。
/// 作者: 杨亮

class SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final double minHeight; //最小高度
  final double maxHeight; //最大高度
  final Widget child; //孩子

  SliverAppBarDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });

  @override
  double get maxExtent => maxHeight;

  @override
  double get minExtent => minHeight;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(SliverAppBarDelegate oldDelegate) {
    //是否需要重建
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}
