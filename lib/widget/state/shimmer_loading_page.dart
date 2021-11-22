import 'package:flutter/material.dart';
import 'package:flutter_wan_android_getx/theme/app_theme.dart';
import 'package:flutter_wan_android_getx/widget/state/list_skeleton_shimmer_loading.dart';
import 'package:shimmer/shimmer.dart';

/// 类名: shimmer_loading_page.dart
/// 创建日期: 11/12/21 on 10:31 AM
/// 描述: pk_skeleton骨架屏
/// 作者: 杨亮
class ShimmerLoadingPage extends StatelessWidget {
  const ShimmerLoadingPage({
    Key? key,
    this.simpleLoading = true,
  }) : super(key: key);

  final bool simpleLoading;

  @override
  Widget build(BuildContext context) {
    Widget widget;

    simpleLoading
        ? widget = simpleShimmerLoading(context)
        : widget = listShimmerLoading(context);

    return SafeArea(
        child: Scaffold(
      body: widget,
    ));
  }

  Shimmer simpleShimmerLoading(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey,
      highlightColor: Colors.white,
      child: Center(
        child: Text(
          'Loading...',
          style: context.headline3Style,
        ),
      ),
    );
  }

  Widget listShimmerLoading(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey,
      highlightColor: Colors.white,
      child: const ListSkeletonShimmerLoading(),
    );
  }
}
