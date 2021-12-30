import 'package:flutter_wan_android_getx/app_user_login_state_controller.dart';
import 'package:flutter_wan_android_getx/base/base_getx_with_page_refresh_controller.dart';
import 'package:flutter_wan_android_getx/constant/constant.dart';
import 'package:flutter_wan_android_getx/http/dio_method.dart';
import 'package:flutter_wan_android_getx/http/dio_util.dart';
import 'package:flutter_wan_android_getx/http/request_api.dart';
import 'package:flutter_wan_android_getx/model/article_data_model.dart';
import 'package:flutter_wan_android_getx/utils/logger_util.dart';
import 'package:flutter_wan_android_getx/widget/state/load_state.dart';
import 'package:get/get.dart';
import 'package:sprintf/sprintf.dart';

class ProjectTreeChildrenController extends BaseGetXWithPageRefreshController {
  final Rx<int?> cid = 0.obs;

  final projectTreeArticleList = RxList<ArticleDataModelDatas>();

  void setCid(int? id) {
    cid.value = id;
  }

  @override
  void onInit() {
    super.onInit();

    loadState = LoadState.lottieRocketLoading;
    // 项目列表数据 页码：拼接在链接中，从1开始
    currentPage = 1;

    ever(appStateController.isLogin, (callback) {
      onRefreshRequestData();
      // 定位到顶部
      if (scrollController.hasClients) {
        scrollController.jumpTo(0);
      }
    });
  }

  /// 第一次进入
  void onFirstInRequestData() {
    initProjectChildrenArticleListData(
      loadingType: Constant.multipleShimmerLoading,
      refreshState: RefreshState.first,
      cid: cid.value,
    );
  }

  /// 下拉刷新首页
  void onRefreshRequestData() {
    initProjectChildrenArticleListData(
      loadingType: Constant.noLoading,
      refreshState: RefreshState.refresh,
      cid: cid.value,
    );
  }

  /// 上滑加载更多
  void onLoadMoreRequestData() {
    initProjectChildrenArticleListData(
      loadingType: Constant.noLoading,
      refreshState: RefreshState.loadMore,
      cid: cid.value,
    );
  }

  /// 项目分类下的文章
  Future<void> initProjectChildrenArticleListData({
    required String loadingType,
    required RefreshState refreshState,
    required int? cid,
  }) async {
    if (refreshState == RefreshState.refresh ||
        refreshState == RefreshState.first) {
      /// 下拉刷新  项目列表数据 页码：拼接在链接中，从1开始。
      currentPage = 1;
    }
    if (refreshState == RefreshState.loadMore) {
      /// 上滑加载更多
      currentPage++;
    }

    String requestUrl =
        sprintf(RequestApi.projectTreeChildrenList, [currentPage]);

    httpManagerWithRefreshPaging(
      loadingType: loadingType,
      refreshState: refreshState,
      future: DioUtil()
          .request(requestUrl, params: {"cid": cid}, method: DioMethod.get),
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

          /// 循环遍历 装载 可观察变量 isCollect
          for (var element in dataList) {
            var collect = element.collect;
            element.isCollect = collect;
          }

          if (refreshState == RefreshState.first) {
            projectTreeArticleList.assignAll(dataList);
          } else if (refreshState == RefreshState.refresh) {
            projectTreeArticleList.assignAll(dataList);
          } else if (refreshState == RefreshState.loadMore) {
            projectTreeArticleList.addAll(dataList);
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
        LoggerUtil.e("${value.message}",
            tag: "ProjectTreeArticleListPageViewController");
      },
      onError: (error) {
        LoggerUtil.e(error.message,
            tag: "ProjectTreeArticleListPageViewController");
      },
    );
  }
}
