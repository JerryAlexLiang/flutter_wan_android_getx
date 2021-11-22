import 'package:flutter/material.dart';
import 'package:flutter_wan_android_getx/base/base_getx_controller.dart';
import 'package:flutter_wan_android_getx/res/gaps.dart';
import 'package:flutter_wan_android_getx/widget/state/load_error_page.dart';
import 'package:flutter_wan_android_getx/widget/state/load_state.dart';
import 'package:flutter_wan_android_getx/widget/state/shimmer_loading_page.dart';
import 'package:get/get.dart';

/// 类名: common_state_page.dart
/// 创建日期: 11/16/21 on 3:58 PM
/// 描述: Common State Widget 封装
/// 作者: 杨亮

class CommonStatePage<T extends BaseGetXController> extends StatefulWidget {
  const CommonStatePage({
    Key? key,
    required this.controller,
    required this.onPressed,
    this.errorPage,
    this.emptyPage,
    required this.child,
  }) : super(key: key);

  // 业务GetXController
  final T controller;

  // 点击事件
  final VoidCallback onPressed;

  // 自定义设置错误页面
  final Widget? errorPage;

  // 自定义设置空页面
  final Widget? emptyPage;

  //组件
  final Widget child;

  @override
  _CommonStatePageState<T> createState() {
    return _CommonStatePageState<T>();
  }
}

class _CommonStatePageState<T extends BaseGetXController>
    extends State<CommonStatePage<T>> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        if (widget.controller.loadState == LoadState.simpleLoading) {
          return const ShimmerLoadingPage();
        } else if (widget.controller.loadState == LoadState.multipleLoading) {
          return const ShimmerLoadingPage(
            simpleLoading: false,
          );
        } else if (widget.controller.loadState == LoadState.fail) {
          return widget.errorPage ??
              EmptyErrorStatePage(
                loadState: LoadState.fail,
                onTap: widget.onPressed,
                errMsg: widget.controller.httpErrorMsg,
              );
        } else if (widget.controller.loadState == LoadState.empty) {
          return widget.emptyPage ??
              EmptyErrorStatePage(
                loadState: LoadState.empty,
                onTap: widget.onPressed,
                errMsg: '暂无数据哦',
              );
        } else if (widget.controller.loadState == LoadState.success) {
          return widget.child;
        }
        return Gaps.empty;
      }),
    );
  }
}
