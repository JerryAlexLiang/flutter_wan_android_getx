import 'package:flutter/material.dart';
import 'package:flutter_wan_android_getx/base/base_getx_controller.dart';
import 'package:flutter_wan_android_getx/res/gaps.dart';
import 'package:flutter_wan_android_getx/widget/state/load_error_page.dart';
import 'package:flutter_wan_android_getx/widget/state/load_state.dart';
import 'package:get/get.dart';

/// 类名: common_state_page.dart
/// 创建日期: 11/16/21 on 3:58 PM
/// 描述: Common State Widget 封装
/// 作者: 杨亮

class CommonStatePage<T extends BaseGetXController> extends StatefulWidget {
  const CommonStatePage(
      {Key? key,
      required this.controller,
      required this.onPressed,
      required this.onRefresh,
      required this.onLoading,
      required this.child,
      this.errorPage,
      this.emptyPage})
      : super(key: key);

  final T controller;
  final VoidCallback onPressed;
  final VoidCallback onRefresh;
  final VoidCallback onLoading;
  final Widget child;
  final Widget? errorPage;
  final Widget? emptyPage;

  @override
  _CommonStatePageState<T> createState() {
    return _CommonStatePageState<T>();
  }
}

class _CommonStatePageState<T extends BaseGetXController>
    extends State<CommonStatePage<T>> {
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (widget.controller.loadState == LoadState.simpleLoading) {
        return Container();
      } else if (widget.controller.loadState == LoadState.fail) {
        return LoadErrorPage(
          onTap: widget.onPressed,
          errMsg: 'errMsg',
        );
      } else if (widget.controller.loadState == LoadState.empty) {
        return Container();
      } else if (widget.controller.loadState == LoadState.success) {
        return widget.child;
      }
      return Gaps.empty;
    });
  }
}
