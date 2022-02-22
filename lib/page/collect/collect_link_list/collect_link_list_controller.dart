import 'package:flutter_wan_android_getx/app_user_login_state_controller.dart';
import 'package:flutter_wan_android_getx/base/base_getx_with_page_refresh_controller.dart';
import 'package:flutter_wan_android_getx/constant/constant.dart';
import 'package:flutter_wan_android_getx/http/dio_method.dart';
import 'package:flutter_wan_android_getx/http/dio_util.dart';
import 'package:flutter_wan_android_getx/http/request_api.dart';
import 'package:flutter_wan_android_getx/model/collect_link_model.dart';
import 'package:flutter_wan_android_getx/routes/app_routes.dart';
import 'package:flutter_wan_android_getx/utils/logger_util.dart';
import 'package:flutter_wan_android_getx/widget/state/load_state.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;

/// 类名: collect_link_list_controller.dart
/// 创建日期: 2/21/22 on 5:45 PM
/// 描述: 我的收藏页 - 网址收藏列表
/// 作者: 杨亮

class CollectLinkListController extends BaseGetXWithPageRefreshController {
  /// 收藏动画显示与否
  final _collectAnimation = false.obs;

  get collectAnimation => _collectAnimation.value;

  set collectAnimation(value) => _collectAnimation.value = value;

  /// 取消收藏动画显示与否
  final _unCollectAnimation = false.obs;

  get unCollectAnimation => _unCollectAnimation.value;

  set unCollectAnimation(value) => _unCollectAnimation.value = value;

  // 返回数据列表
  final collectLinkList = RxList<CollectLinkModel>();

  @override
  void onInit() {
    super.onInit();
    loadState = LoadState.lottieRocketLoading;
    onFirstInRequestData();
  }

  /// 第一次进入
  void onFirstInRequestData() {
    initCollectLinkListData(
      loadingType: Constant.showLoadingDialog,
      refreshState: RefreshState.first,
    );
  }

  /// 下拉刷新首页
  void onRefreshRequestData() {
    initCollectLinkListData(
      loadingType: Constant.showLoadingDialog,
      refreshState: RefreshState.refresh,
    );
  }

  /// 请求数据
  Future<void> initCollectLinkListData({
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

    httpManagerWithRefreshPaging(
      loadingType: loadingType,
      refreshState: refreshState,
      future:
          DioUtil().request(RequestApi.collectLinkList, method: DioMethod.get),
      onSuccess: (response) {
        /// 类表转换的时候一定要加一下墙砖List<dynamic>，否则会报错
        List<CollectLinkModel> dataList = (response as List<dynamic>)
            .map((e) => CollectLinkModel().fromJson(e))
            .toList();

        for (var element in collectLinkList) {
          element.collect = true;
          element.isCollect = true;
        }

        if (dataList.isNotEmpty) {
          if (refreshState == RefreshState.first) {
            collectLinkList.assignAll(dataList);
          } else if (refreshState == RefreshState.refresh) {
            collectLinkList.assignAll(dataList);
          }
        } else {
          if (loadingType != Constant.noLoading) {
            refreshLoadState = LoadState.empty;
          }
        }

        print('==========>1  ${collectLinkList[0].toJson()}');
        print('==========>2  ${collectLinkList[1].toJson()}');
        print('==========>3  ${collectLinkList[2].toJson()}');
      },
      onFail: (value) {
        Fluttertoast.showToast(msg: "请求异常:${value.message}");
        LoggerUtil.e("${value.message}", tag: "CollectLinkListController");
      },
      onError: (error) {
        Fluttertoast.showToast(msg: "请求异常:${error.message}");
        LoggerUtil.e(error.message, tag: "CollectLinkListController");
      },
    );
  }

  /// 删除收藏网站  unCollectLink
  void requestUnCollectLink(CollectLinkModel model) async {
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
        model.collect = false;
        model.isCollect = false;
        Fluttertoast.showToast(msg: '删除收藏网址成功');
      },
      onFail: (value) async {
        // 收藏请求失败 隐藏收藏动画
        collectAnimation = false;
        model.collect = true;
        model.isCollect = true;
        Fluttertoast.showToast(msg: '删除收藏网址失败');
      },
      onError: (value) {
        collectAnimation = false;
        model.collect = true;
        model.isCollect = true;
        Fluttertoast.showToast(msg: '删除收藏网址请求异常');
      },
    );
  }
}
