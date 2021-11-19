import 'package:flutter/material.dart';
import 'package:flutter_wan_android_getx/base/base_getx_with_page_refresh_controller.dart';
import 'package:flutter_wan_android_getx/res/gaps.dart';
import 'package:flutter_wan_android_getx/widget/state/load_error_page.dart';
import 'package:flutter_wan_android_getx/widget/state/load_state.dart';
import 'package:flutter_wan_android_getx/widget/state/shimmer_loading_page.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class RefreshPagingStatePage<T extends BaseGetXWithPageRefreshController>
    extends StatelessWidget {
  const RefreshPagingStatePage({
    Key? key,
    required this.controller,
    required this.onPressed,
    this.errorPage,
    this.emptyPage,
    required this.refreshController,
    this.onRefresh,
    this.onLoadMore,
    required this.child,
    this.header,
    this.footer,
  }) : super(key: key);

  /// 业务GetXController
  final T controller;

  /// 点击事件
  final VoidCallback onPressed;

  /// 自定义设置错误页面
  final Widget? errorPage;

  /// 自定义设置空页面
  final Widget? emptyPage;

  ///是否启用上拉加载
  final bool enablePullUp = true;

  ///是否启用下拉刷新
  final bool enablePullDown = true;

  /// 组件
  final Widget child;

  ///下拉刷新回调
  final VoidCallback? onRefresh;

  ///上拉加载回调
  final VoidCallback? onLoadMore;

  /// 刷新控制器
  final RefreshController refreshController;

  /// 刷新头部
  final Widget? header;

  /// 刷新尾部
  final Widget? footer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        if (controller.loadState == LoadState.simpleLoading) {
          return const ShimmerLoadingPage();
        } else if (controller.loadState == LoadState.multipleLoading) {
          return const ShimmerLoadingPage(
            simpleLoading: false,
          );
        } else if (controller.loadState == LoadState.fail) {
          return errorPage ??
              EmptyErrorStatePage(
                loadState: LoadState.fail,
                onTap: onPressed,
                errMsg: controller.httpErrorMsg,
              );
        } else if (controller.loadState == LoadState.empty) {
          return emptyPage ??
              EmptyErrorStatePage(
                loadState: LoadState.empty,
                onTap: onPressed,
                errMsg: '暂无数据哦',
              );
        } else if (controller.loadState == LoadState.success) {
          return SmartRefresher(
            controller: refreshController,
            enablePullDown: enablePullDown,
            enablePullUp: enablePullUp,
            onRefresh: onRefresh,
            onLoading: onLoadMore,
            header: header ?? const ClassicHeader(),
            footer: footer ??
                ClassicFooter(
                  failedText: controller.httpErrorMsg,
                ),
            child: child,
          );
        }

        return Gaps.empty;
      }),
    );
  }
}
