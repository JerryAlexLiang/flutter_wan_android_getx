import 'package:dio/dio.dart' as dio;
import 'package:flutter_wan_android_getx/app_user_login_state_controller.dart';
import 'package:flutter_wan_android_getx/base/base_getx_with_page_refresh_controller.dart';
import 'package:flutter_wan_android_getx/constant/constant.dart';
import 'package:flutter_wan_android_getx/http/dio_method.dart';
import 'package:flutter_wan_android_getx/http/dio_util.dart';
import 'package:flutter_wan_android_getx/http/request_api.dart';
import 'package:flutter_wan_android_getx/model/article_data_model.dart';
import 'package:flutter_wan_android_getx/routes/app_routes.dart';
import 'package:flutter_wan_android_getx/utils/logger_util.dart';
import 'package:flutter_wan_android_getx/widget/state/load_state.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:sprintf/sprintf.dart';

/// 类名: collect_article_list_controller.dart
/// 创建日期: 2/17/22 on 4:30 PM
/// 描述: 站内文章收藏列表
/// 作者: 杨亮

class CollectArticleListController extends BaseGetXWithPageRefreshController {
  /// 收藏动画显示与否
  final _collectAnimation = false.obs;

  get collectAnimation => _collectAnimation.value;

  set collectAnimation(value) => _collectAnimation.value = value;

  /// 取消收藏动画显示与否
  final _unCollectAnimation = false.obs;

  get unCollectAnimation => _unCollectAnimation.value;

  set unCollectAnimation(value) => _unCollectAnimation.value = value;

  // // 返回数据列表
  final collectArticleList = RxList<ArticleDataModelDatas>();

  @override
  void onInit() {
    super.onInit();
    loadState = LoadState.lottieRocketLoading;
    // 项目列表数据 页码：拼接在链接中，从0开始
    currentPage = 0;
    onFirstInRequestData();
  }

  @override
  void onReadyInitData() {
    super.onReadyInitData();
    onFirstInRequestData();
  }

  /// 第一次进入
  void onFirstInRequestData() {
    initCollectArticleListData(
      // loadingType: Constant.multipleShimmerLoading,
      loadingType: Constant.showLoadingDialog,
      refreshState: RefreshState.first,
    );
  }

  /// 下拉刷新首页
  void onRefreshRequestData() {
    initCollectArticleListData(
      // loadingType: Constant.noLoading,
      loadingType: Constant.showLoadingDialog,
      refreshState: RefreshState.refresh,
    );
  }

  /// 上滑加载更多
  void onLoadMoreRequestData() {
    initCollectArticleListData(
      // loadingType: Constant.noLoading,
      loadingType: Constant.showLoadingDialog,
      refreshState: RefreshState.loadMore,
    );
  }

  /// 请求数据
  Future<void> initCollectArticleListData({
    required String loadingType,
    required RefreshState refreshState,
  }) async {
    if (refreshState == RefreshState.refresh ||
        refreshState == RefreshState.first) {
      /// 下拉刷新  项目列表数据 页码：拼接在链接中，从0开始
      currentPage = 0;
    }
    if (refreshState == RefreshState.loadMore) {
      /// 上滑加载更多
      currentPage++;
    }

    // API拼接页码
    String requestUrl = sprintf(RequestApi.collectArticleList, [currentPage]);

    httpManagerWithRefreshPaging(
      loadingType: loadingType,
      refreshState: refreshState,
      future: DioUtil().request(requestUrl, method: DioMethod.get),
      onSuccess: (response) {
        var articleDataModel = ArticleDataModel().fromJson(response);
        List<ArticleDataModelDatas>? dataList = articleDataModel.datas;

        // 加载到底部判断
        var over = articleDataModel.over;
        if (over != null) {
          if (over) {
            loadNoData();
          }
        }

        if (dataList != null && dataList.isNotEmpty) {
          loadState = LoadState.success;
          refreshLoadState = LoadState.success;

          /// 循环遍历 装载 可观察变量添加 isCollect
          for (var element in dataList) {
            element.collect = true;
            element.isCollect = true;
          }

          if (refreshState == RefreshState.first) {
            collectArticleList.assignAll(dataList);
          } else if (refreshState == RefreshState.refresh) {
            collectArticleList.assignAll(dataList);
          } else if (refreshState == RefreshState.loadMore) {
            collectArticleList.addAll(dataList);
          }
        } else {
          if (loadingType != Constant.noLoading) {
            refreshLoadState = LoadState.empty;
          } else {
            loadNoData();
          }
        }
      },
      onFail: (value) {
        Fluttertoast.showToast(msg: "请求异常:${value.message}");
        LoggerUtil.e("${value.message}", tag: "CollectArticleListController");
      },
      onError: (error) {
        Fluttertoast.showToast(msg: "请求异常:${error.message}");
        LoggerUtil.e(error.message, tag: "CollectArticleListController");
      },
    );
  }

  /// 删除收藏网站  unCollectLink
  void requestUnCollectLink(ArticleDataModelDatas model) async {
    // 删除收藏网址
    var unCollectLinkUrl = RequestApi.unCollectLink;

    var postUnCollectLinkUrlParams = {
      "id": model.id,
    };

    /// FormData参数
    if (!loginState) {
      Get.toNamed(AppRoutes.loginRegisterPage);
      return;
    }

    httpManager(
      loadingType: Constant.noLoading,
      // 此接口使用sprintf插件进行String格式化操作  static const String collectInsideArticle = '/lg/collect/%s/json';
      // future: DioUtil().request(requestURL, method: DioMethod.post),
      future: DioUtil().request(
        unCollectLinkUrl,
        method: DioMethod.post,
        data: dio.FormData.fromMap(postUnCollectLinkUrlParams),
      ),
      onStart: () {
        // 显示收藏动画
        collectAnimation = true;
      },
      onSuccess: (response) async {
        await Future.delayed(const Duration(milliseconds: 1000));
        // 收藏请求成功 隐藏收藏动画
        collectAnimation = false;
        Fluttertoast.showToast(msg: '删除收藏网址成功');
      },
      onFail: (value) async {
        // 收藏请求失败 隐藏收藏动画
        collectAnimation = false;
        Fluttertoast.showToast(msg: '删除收藏网址失败');
      },
      onError: (value) {
        collectAnimation = false;
        Fluttertoast.showToast(msg: '删除收藏网址请求异常');
      },
    );
  }

  /// 我的收藏页面取消收藏（站内文章）  collectInsideArticle
  void requestUnCollectArticle(ArticleDataModelDatas model) async {
    // 我的收藏页面取消收藏
    var postUnCollectInsideArticle2Params = {
      "originId": model.originId,
    };

    /// FormData参数

    if (!loginState) {
      Get.toNamed(AppRoutes.loginRegisterPage);
      return;
    }

    httpManager(
      loadingType: Constant.noLoading,
      // 此接口使用sprintf插件进行String格式化操作  static const String collectInsideArticle = '/lg/collect/%s/json';
      // future: DioUtil().request(requestURL, method: DioMethod.post),
      future: DioUtil().request(
        sprintf(RequestApi.unCollectInsideArticle2, [model.id]),
        method: DioMethod.post,
        data: dio.FormData.fromMap(postUnCollectInsideArticle2Params),
      ),
      onStart: () {
        /// 点击之前状态为 已收藏 时 假状态
        // 显示加载动画
        unCollectAnimation = true;
        model.isCollect = false;
      },
      onSuccess: (response) async {
        await Future.delayed(const Duration(milliseconds: 1000));

        /// 点击之前状态为 已收藏 时
        // 取消收藏请求成功
        // 隐藏显示加载动画
        unCollectAnimation = false;
        model.isCollect = false;

        // 删除被取消收藏的item
        collectArticleList.remove(model);

        Fluttertoast.showToast(msg: '取消收藏成功');
      },
      onFail: (value) async {
        /// 点击之前状态为 已收藏 时  恢复状态
        // 取消收藏请求失败
        // 隐藏显示加载动画
        unCollectAnimation = false;
        model.isCollect = true;
        Fluttertoast.showToast(msg: '取消收藏失败');
      },
      onError: (value) {
        /// 点击之前状态为 已收藏 时  恢复状态
        // 取消收藏请求失败
        // 隐藏显示加载动画
        unCollectAnimation = false;
        model.isCollect = true;
        Fluttertoast.showToast(msg: '取消收藏失败');
      },
    );
  }
}
