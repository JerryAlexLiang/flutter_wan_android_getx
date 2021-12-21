import 'package:flutter/widgets.dart';
import 'package:flutter_wan_android_getx/app_user_login_state_controller.dart';
import 'package:flutter_wan_android_getx/base/base_getx_with_page_refresh_controller.dart';
import 'package:flutter_wan_android_getx/constant/constant.dart';
import 'package:flutter_wan_android_getx/http/base_response.dart';
import 'package:flutter_wan_android_getx/http/dio_method.dart';
import 'package:flutter_wan_android_getx/http/dio_util.dart';
import 'package:flutter_wan_android_getx/http/request_api.dart';
import 'package:flutter_wan_android_getx/model/article_data_model.dart';
import 'package:flutter_wan_android_getx/model/home_banner_model.dart';
import 'package:flutter_wan_android_getx/res/strings.dart';
import 'package:flutter_wan_android_getx/utils/logger_util.dart';
import 'package:flutter_wan_android_getx/widget/state/load_state.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:sprintf/sprintf.dart';

/// 首页
class HomeController extends BaseGetXWithPageRefreshController {
  /// Banner List
  // final homeBannerList = List<HomeBannerModel>.empty(growable: true).obs;
  final homeBannerList = RxList<HomeBannerModel>();

  /// 首页文章列表
  final homeArticleList = RxList<ArticleDataModelDatas>();

  @override
  void onInit() {
    super.onInit();

    /// 每次登陆状态发生变化后更新数据
    ever(appStateController.isLogin, (callback) {
      onRefreshHomeData();
      // // 匀速滑动到顶部
      // scrollController.animateTo(0,
      //     duration: const Duration(milliseconds: 1000), curve: Curves.linear);
      // 定位到顶部
      scrollController.jumpTo(0);
    });
  }

  @override
  void onReadyInitData() {
    super.onReadyInitData();
    // 第一次进入首页
    onFirstInHomeData();
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }

  /// 获取首页Banner
  Future<void> getHomeBannerData() async {
    BaseResponse response =
        await DioUtil().request(RequestApi.homeBanner, method: DioMethod.get);
    //拿到res.data就可以进行Json解析了，这里一般用来构造实体类
    var success = response.success;
    if (success != null) {
      if (success) {
        // await Future.delayed(const Duration(milliseconds: 5000));
        refreshLoadingSuccess(RefreshState.refresh);

        ///列表转换的时候一定要加一下强转List<dynamic>，否则会报错
        List<HomeBannerModel> model = (response.data as List<dynamic>)
            .map((e) => HomeBannerModel.fromJson(e))
            .toList();
        homeBannerList.assignAll(model);
      }
    }
  }

  /// 获取首页文章列表  GET https://www.wanandroid.com/article/list/0/json
  Future<void> getHomeArticleList(
      String loadingType, RefreshState refreshState) async {
    /// 参数：页码，拼接在连接中，从0开始。
    // String requestUrl = sprintf(RequestApi.homeArticleList, currentPage);

    //RequestApi.articleSearch.replaceFirst(RegExp('page'), '$currentPage'),

    String requestUrl =
        RequestApi.homeArticleList.replaceFirst(RegExp('page'), '$currentPage');

    LoggerUtil.d(
        '+++++++>>>>  loadingType: $loadingType refreshState:$refreshState');

    handleRequestWithRefreshPaging(
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
          refreshLoadState = LoadState.success;

          /// 循环遍历 装载 可观察变量 isCollect
          for (var element in dataList) {
            var collect = element.collect;
            element.isCollect = collect;
          }

          if (refreshState == RefreshState.first) {
            homeArticleList.assignAll(dataList);
          } else if (refreshState == RefreshState.refresh) {
            homeArticleList.assignAll(dataList);
            // Fluttertoast.showToast(msg: StringsConstant.refreshSuccess.tr);
          } else if (refreshState == RefreshState.loadMore) {
            homeArticleList.addAll(dataList);
          }
        } else {
          if (loadingType != Constant.noLoading) {
            refreshLoadState = LoadState.empty;
          } else {
            loadNoData();
          }
        }
      },
      onFail: (error) {
        refreshLoadState = LoadState.fail;
        Fluttertoast.showToast(msg: '数据请求失败 ${error.code}  ${error.message}');
      },
      onError: (error) {
        refreshLoadState = LoadState.fail;
        Fluttertoast.showToast(msg: '数据请求失败 ${error.code}  ${error.message}');
      },
    );
  }

  /// 获取首页数据
  Future<void> getHomeData({
    required String loadingType,
    required RefreshState refreshState,
  }) async {
    if (refreshState == RefreshState.refresh ||
        refreshState == RefreshState.first) {
      /// 下拉刷新
      currentPage = 0;
      // 获取首页Banner数据源
      getHomeBannerData();
    }
    if (refreshState == RefreshState.loadMore) {
      /// 上滑加载更多
      currentPage++;
      // Fluttertoast.showToast(msg: 'currentPage: $currentPage');
    }
    LoggerUtil.d('============> getHomeData() $currentPage',
        tag: 'HomeController');
    // 获取首页文章列表
    getHomeArticleList(loadingType, refreshState);
  }

  /// 第一次进入首页
  void onFirstInHomeData() {
    LoggerUtil.d('============> onFirstInHomeData()', tag: 'HomeController');
    getHomeData(
      loadingType: Constant.lottieRocketLoading,
      refreshState: RefreshState.first,
    );
  }

  /// 下拉刷新首页
  void onRefreshHomeData() {
    LoggerUtil.d('============> onRefreshHomeData()', tag: 'HomeController');
    getHomeData(
      loadingType: Constant.noLoading,
      refreshState: RefreshState.refresh,
    );
  }

  /// 上滑加载更多
  void onLoadMoreHomeData() {
    LoggerUtil.d('============> onLoadMoreHomeData()', tag: 'HomeController');
    getHomeData(
      loadingType: Constant.noLoading,
      refreshState: RefreshState.loadMore,
    );
  }
}
