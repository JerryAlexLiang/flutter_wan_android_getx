import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_wan_android_getx/base/base_getx_with_page_refresh_controller.dart';
import 'package:flutter_wan_android_getx/res/gaps.dart';
import 'package:flutter_wan_android_getx/res/r.dart';
import 'package:flutter_wan_android_getx/res/strings.dart';
import 'package:flutter_wan_android_getx/theme/app_theme.dart';
import 'package:flutter_wan_android_getx/widget/state/load_error_page.dart';
import 'package:flutter_wan_android_getx/widget/state/load_state.dart';
import 'package:flutter_wan_android_getx/widget/state/loading_lottie_rocket_widget.dart';
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
    this.lottieRocketRefreshHeader = true,
    this.physics,
    this.scrollController,
    this.enableRefreshPullUp = true,
    this.enableRefreshPullDown = true,
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
  final bool enableRefreshPullUp;

  ///是否启用下拉刷新
  final bool enableRefreshPullDown;

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

  final bool? lottieRocketRefreshHeader;

  /// 刷新尾部
  final Widget? footer;

  final ScrollPhysics? physics;

  final ScrollController? scrollController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        if (controller.refreshLoadState == LoadState.simpleShimmerLoading) {
          return const ShimmerLoadingPage();
        } else if (controller.refreshLoadState ==
            LoadState.multipleShimmerLoading) {
          return const ShimmerLoadingPage(
            simpleLoading: false,
          );
        } else if (controller.refreshLoadState ==
            LoadState.lottieRocketLoading) {
          return Column(
            children: const [
              Gaps.vGap150,
              LoadingLottieRocketWidget(
                visible: true,
                animate: true,
                repeat: true,
              ),
            ],
          );
        } else if (controller.refreshLoadState == LoadState.fail) {
          return errorPage ??
              EmptyErrorStatePage(
                loadState: LoadState.fail,
                onTap: onPressed,
                errMsg: controller.httpErrorMsg,
              );
        } else if (controller.refreshLoadState == LoadState.empty) {
          return emptyPage ??
              EmptyErrorStatePage(
                loadState: LoadState.empty,
                onTap: onPressed,
                errMsg: StringsConstant.noData.tr,
              );
        } else if (controller.refreshLoadState == LoadState.success) {
          // return SmartRefresher(
          //   controller: refreshController,
          //   enablePullDown: enableRefreshPullDown,
          //   enablePullUp: enableRefreshPullUp,
          //   onRefresh: onRefresh,
          //   onLoading: onLoadMore,
          //   physics: physics,
          //   scrollController: scrollController,
          //   header: header ?? customHeaderWidget(context),
          //   footer: footer ?? customFooterWidget(context),
          //   child: child,
          // );

          //AnnotatedRegion<SystemUiOverlayStyle>(
          //       value: SystemUiOverlayStyle.light,

          return RefreshConfiguration.copyAncestor(
            maxOverScrollExtent: 30,
            context: context,
            child: SmartRefresher(
              controller: refreshController,
              enablePullDown: enableRefreshPullDown,
              enablePullUp: enableRefreshPullUp,
              onRefresh: onRefresh,
              onLoading: onLoadMore,
              physics: physics,
              scrollController: scrollController,
              header: header ?? customHeaderWidget(context),
              footer: footer ?? customFooterWidget(context),
              child: child,
            ),
          );
        }

        return Gaps.empty;
      }),
    );
  }

  Widget customHeaderWidget(BuildContext context) {
    return CustomHeader(builder: (context, refreshStatus) {
      Widget customHeader;

      if (refreshStatus == RefreshStatus.idle) {
        // 初始状态，当未被超滚动时，或在超滚动取消后，或在完成后，条收回
        /// 下拉时显示
        customHeader = refreshStatusWidget(
          context: context,
          constant: StringsConstant.pullToRefresh.tr,
          iconData: Icons.arrow_downward,
        );
      } else if (refreshStatus == RefreshStatus.refreshing) {
        // 指示器正在刷新，等待完成回调
        customHeader = refreshStatusWidget(
          context: context,
          constant: StringsConstant.loading.tr,
          refreshWidget: (lottieRocketRefreshHeader == null ||
                  (lottieRocketRefreshHeader != null &&
                      lottieRocketRefreshHeader == true))
              ? const LoadingLottieRocketWidget(
                  lottieAsset: R.assetsLottieRocketLunchLoadingAnimation,
                  visible: true,
                  animate: true,
                  repeat: true,
                  width: 30,
                  height: 50,
                  fit: BoxFit.cover,
                )
              : const CupertinoActivityIndicator(),
        );
      } else if (refreshStatus == RefreshStatus.failed) {
        // 指示器刷新失败
        customHeader = refreshStatusWidget(
          context: context,
          constant: (controller.httpErrorMsg != null &&
                  controller.httpErrorMsg.toString().isNotEmpty)
              ? StringsConstant.refreshFailed.tr +
                  '\n' +
                  controller.httpErrorMsg
              : StringsConstant.refreshFailed.tr,
          iconData: Icons.error,
        );
      } else if (refreshStatus == RefreshStatus.completed) {
        // 指示器刷新完成
        customHeader = refreshStatusWidget(
          context: context,
          constant: StringsConstant.refreshSuccess.tr,
          iconData: Icons.done,
        );
      } else {
        // 松手开始刷新数据
        customHeader = refreshStatusWidget(
          context: context,
          constant: StringsConstant.releaseStartRefreshing.tr,
          iconData: Icons.refresh,
        );
      }

      final Color _backgroundColor = context.appBarBackgroundColor!;

      final SystemUiOverlayStyle _overlayStyle =
          ThemeData.estimateBrightnessForColor(_backgroundColor) ==
                  Brightness.dark
              ? SystemUiOverlayStyle.light
              : SystemUiOverlayStyle.dark;

      return AnnotatedRegion<SystemUiOverlayStyle>(
        value: _overlayStyle,
        child: Container(
          height: 90,
          // color: Colors.red,
          padding: const EdgeInsets.all(10),
          alignment: Alignment.bottomCenter,
          child: customHeader,
        ),
      );
    });
  }

  Widget customFooterWidget(BuildContext context) {
    return CustomFooter(builder: (context, loadStatus) {
      Widget? customFooter;

      if (loadStatus == LoadStatus.idle) {
        /// 上滑时显示 pullToLoading
        customFooter = refreshStatusWidget(
          context: context,
          constant: StringsConstant.pullToLoading.tr,
          iconData: Icons.arrow_upward,
        );
      } else if (loadStatus == LoadStatus.canLoading) {
        /// 上滑要松手时显示
        customFooter = refreshStatusWidget(
          context: context,
          constant: StringsConstant.releaseStartLoading.tr,
          iconData: Icons.autorenew,
        );
      } else if (loadStatus == LoadStatus.loading) {
        customFooter = refreshStatusWidget(
          context: context,
          constant: StringsConstant.loading.tr,
          refreshWidget: const CupertinoActivityIndicator(),
        );
      } else if (loadStatus == LoadStatus.noMore) {
        customFooter = refreshStatusWidget(
          context: context,
          constant: StringsConstant.noMoreData.tr,
          iconData: Icons.error_outline,
        );
      } else if (loadStatus == LoadStatus.failed) {
        customFooter = refreshStatusWidget(
          context: context,
          constant: (controller.httpErrorMsg != null &&
                  controller.httpErrorMsg.toString().isNotEmpty)
              ? StringsConstant.loadFailed.tr + "\n" + controller.httpErrorMsg
              : StringsConstant.loadFailed.tr,
          iconData: Icons.error_outline,
        );
      }

      return Container(
        padding: const EdgeInsets.all(10),
        alignment: Alignment.center,
        child: customFooter,
      );
    });
  }

  refreshStatusWidget({
    required BuildContext context,
    required String constant,
    IconData? iconData,
    Widget? refreshWidget,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        refreshWidget ??
            Icon(
              iconData,
              color: Colors.grey,
            ),
        Gaps.hGap10,
        Text(
          constant,
          style: context.bodyText2Style!.copyWith(color: Colors.grey),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
