import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_wan_android_getx/base/base_getx_controller.dart';
import 'package:flutter_wan_android_getx/constant/constant.dart';
import 'package:flutter_wan_android_getx/http/base_response.dart';
import 'package:flutter_wan_android_getx/http/handle_dio_error.dart';
import 'package:flutter_wan_android_getx/utils/logger_util.dart';
import 'package:flutter_wan_android_getx/widget/state/load_state.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

/// 类名: base_getx_with_page_refresh_controller.dart
/// 创建日期: 基于GetX的可刷新及分页的 BaseGetXWithPageRefreshController
/// 描述: TODO
/// 作者: 杨亮

class BaseGetXWithPageRefreshController extends BaseGetXController {
  /// 下拉刷新控制器
  late RefreshController _refreshController;

  RefreshController get refreshController => _refreshController;

  final _initialRefresh = false.obs;

  get initialRefresh => _initialRefresh.value;

  set initialRefresh(value) => _initialRefresh.value = value;

  /// 当前页数
  int currentPage = 0;

  /// 刷新列表加载状态
  final _refreshLoadState = LoadState.simpleShimmerLoading.obs;

  get refreshLoadState => _refreshLoadState.value;

  set refreshLoadState(value) => _refreshLoadState.value = value;

  //滚动控制器
  late ScrollController scrollController;

  //标题栏透明比例
  final _percent = 0.0.obs;

  get percent => _percent.value;

  set percent(value) => _percent.value = value;

  @override
  void onInit() {
    super.onInit();
    scrollController = ScrollController();
    _refreshController = RefreshController(initialRefresh: initialRefresh);
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
    _refreshController.dispose();
  }

  /// 带分页加载下拉刷新的请求，适用于ListView等
  void httpManagerWithRefreshPaging({
    required String loadingType,
    RefreshState refreshState = RefreshState.refresh,
    required Future<dynamic> future,
    Function()? onStart,
    required Function(dynamic value) onSuccess,
    required Function(BaseResponse value) onFail,
    required  Function(ResultException value)? onError,
  }) async {
    // 重置无数据状态刷新器
    _refreshController.resetNoData();

    /// 是否显示加载页面，及加载页面类型
    if (loadingType == Constant.showLoadingDialog) {
      EasyLoading.show(status: 'loading...');
    } else if (loadingType == Constant.simpleShimmerLoading) {
      refreshLoadState = LoadState.simpleShimmerLoading;
    } else if (loadingType == Constant.multipleShimmerLoading) {
      refreshLoadState = LoadState.multipleShimmerLoading;
    } else if (loadingType == Constant.lottieRocketLoading) {
      refreshLoadState = LoadState.lottieRocketLoading;
    } else if (loadingType == Constant.noLoading) {
      refreshLoadState = LoadState.success;
      // return;
    }

    if (onStart != null) {
      onStart();
    }

    future.then((value) {
      /// 网络请求成功
      BaseResponse response = value;
      //拿到res.data就可以进行Json解析了，这里一般用来构造实体类
      var success = response.success;
      if (success != null) {
        if (success) {
          dismissEasyLoading();

          /// 请求成功
          var data = response.data;
          if (data != null) {
            refreshLoadingSuccess(refreshState);
            refreshLoadState = LoadState.success;

            /// 在onSuccess()中也要判断具体的业务数据是否为空
            onSuccess(data);
          } else {
            onSuccess(data);
            /// 第一次加载，返回数据为空，则显示空页面
            if (loadingType != Constant.noLoading) {
              refreshLoadState = LoadState.empty;
            } else {
              refreshLoadState = LoadState.success;

              /// 非第一次加载，返回数据为空，则不显示空页面
              refreshLoadingSuccess(refreshState);
            }
          }
          LoggerUtil.e(
              'handleRequestWithRefreshPaging  success ====> code: ${response.code}  message: ${response.message}');
        } else {
          /// 请求失败
          /// 第一次加载，请求失败，则显示错误页面
          if (loadingType != Constant.noLoading) {
            refreshLoadState = LoadState.fail;
          } else {
            /// 非第一次加载，请求失败，则不显示错误页面
            refreshLoadingFailed(refreshState);
            refreshLoadState = LoadState.success;
          }
          dismissEasyLoading();
          onFail(response);
          LoggerUtil.e(
              'handleRequestWithRefreshPaging  fail1 ====> code: ${response.code} message: ${response.message}');
        }
      } else {
        /// 第一次加载，请求失败，则显示错误页面
        if (loadingType != Constant.noLoading) {
          refreshLoadState = LoadState.fail;
        } else {
          /// 非第一次加载，请求失败，则不显示错误页面
          refreshLoadingFailed(refreshState);
        }
        dismissEasyLoading();
        onFail(response);
        LoggerUtil.e(
            'handleRequestWithRefreshPaging  fail2 ====> code: ${response.code} message: ${response.message}');
      }
    }).onError<ResultException>((error, stackTrace) {
      /// 网络请求失败 第一次加载，请求失败，则显示错误页面
      if (loadingType != Constant.noLoading) {
        // 加载状态设置为fail
        refreshLoadState = LoadState.fail;
        // LoadErrorMsg 文字内容
        httpErrorMsg = '${error.code}  ${error.message}';
      } else {
        /// 网络请求失败 非第一次加载，请求失败，则不显示错误页面
        refreshLoadingFailed(refreshState);
        refreshLoadState = LoadState.success;
      }
      dismissEasyLoading();
      if (onError != null) {
        onError(error);
      }
      LoggerUtil.e(
          'handleRequestWithRefreshPaging  onError ====> code: ${error.code} message: ${error.message}');
    });
  }

  /// RefreshController刷新、加载失败
  void refreshLoadingFailed(RefreshState refreshState) {
    if (refreshState == RefreshState.refresh) {
      _refreshController.refreshFailed();
    } else if (refreshState == RefreshState.loadMore) {
      _refreshController.loadFailed();
    }
  }

  /// RefreshController刷新、加载成功
  void refreshLoadingSuccess(RefreshState refreshState) {
    if (refreshState == RefreshState.refresh) {
      _refreshController.refreshCompleted(resetFooterState: true);
    } else if (refreshState == RefreshState.loadMore) {
      _refreshController.loadComplete();
    }
  }

  /// 没有更多了
  void loadNoData() {
    refreshLoadState = LoadState.success;
    _refreshController.loadNoData();
  }
}
