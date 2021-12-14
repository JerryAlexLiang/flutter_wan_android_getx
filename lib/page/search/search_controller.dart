import 'package:flutter/material.dart';
import 'package:flutter_wan_android_getx/base/base_getx_with_page_refresh_controller.dart';
import 'package:flutter_wan_android_getx/constant/constant.dart';
import 'package:flutter_wan_android_getx/http/dio_method.dart';
import 'package:flutter_wan_android_getx/http/dio_util.dart';
import 'package:flutter_wan_android_getx/http/request_api.dart';
import 'package:flutter_wan_android_getx/model/article_data_model.dart';
import 'package:flutter_wan_android_getx/model/hot_search_model.dart';
import 'package:flutter_wan_android_getx/page/search/article_detail_controller.dart';
import 'package:flutter_wan_android_getx/res/strings.dart';
import 'package:flutter_wan_android_getx/utils/logger_util.dart';
import 'package:flutter_wan_android_getx/utils/sp_util.dart';
import 'package:flutter_wan_android_getx/widget/state/load_state.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

/// 类名: search_controller.dart
/// 创建日期: 11/15/21 on 4:58 PM
/// 描述: 搜索界面
/// 作者: 杨亮

class SearchController extends BaseGetXWithPageRefreshController {
  // final detailController = Get.find<ArticleDetailController>();

  /// 搜索输入框孔控制器
  late TextEditingController textEditingController;

  /// 关键词
  final _keyword = ''.obs;

  get keyword => _keyword.value;

  set keyword(value) => _keyword.value = value;

  /// 搜索结果
  final _searchResult = <ArticleDataModelDatas>[].obs;

  List<ArticleDataModelDatas> get searchResult => _searchResult;

  set searchResult(value) => _searchResult.value = value;

  /// 热词数据List
  final _hotKeys = <HotSearchModel>[].obs;

  List<HotSearchModel> get hotKeys => _hotKeys;

  set hotKeys(value) => _hotKeys.assignAll(value);

  /// 搜索hint
  final _hotHint = '热搜'.obs;

  get hotHint => _hotHint.value;

  set hotHint(value) => _hotHint.value = value;

  /// 是否显示热词流布局
  final _showHotKeys = true.obs;

  bool get showHotKeys => _showHotKeys.value;

  set showHotKeys(value) => _showHotKeys.value = value;

  /// 本地存储搜索历史记录
  final RxList<String> _historyKeys = <String>[].obs;

  // ignore: invalid_use_of_protected_member
  List<String> get historyKeys => _historyKeys.value;

  set historyKeys(value) => _historyKeys.value = value;

  /// 是否显示搜索历史列表流布局
  final _showHistoryKeys = true.obs;

  bool get showHistoryKeys => _showHistoryKeys.value;

  set showHistoryKeys(value) => _showHistoryKeys.value = value;

  /// 是否显示搜索结果界面
  final _showResult = false.obs;

  get showResult => _showResult.value;

  set showResult(value) => _showResult.value = value;

  //两种模式 0： 默认界面 1： 搜索结果界面
  int get indexed {
    if (showResult) {
      return 1;
    } else {
      return 0;
    }
  }

  @override
  void onInit() async {
    textEditingController = TextEditingController();
    clearSearchView();
    // 查找本地搜索记录
    notifySearchHistory(1);
    LoggerUtil.d('============> onInit()');
    super.onInit();
  }

  @override
  void onReadyInitData() {
    super.onReadyInitData();
    initHotKeysList();
  }

  @override
  void dispose() {
    textEditingController.dispose();
    LoggerUtil.d('============> dispose()');
    super.dispose();
  }

  @override
  void onClose() {
    clearSearchView();
    LoggerUtil.d('============> onClose()');
    super.onClose();
  }

  /// 清除搜索框内容
  void clearSearchView() {
    keyword = '';
    textEditingController.clear();
    showResult = false;
  }

  /// 退出搜索框
  finishSearchPage() {
    FocusManager.instance.primaryFocus?.unfocus();
    if (showResult == true) {
      // 如果当前是搜索结果页面，点击返回键返回搜索热词、历史页面，输入关键词keyword不变
      showResult = false;
    } else {
      clearSearchView();
      Get.back(canPop: true);
      // showResult = true;
    }
  }

  /// 拦截系统返回键 退出搜索框
  Future<bool> onWillPopListener() async {
    FocusManager.instance.primaryFocus?.unfocus();
    if (showResult == true) {
      showResult = false;
      return Future.value(false);
    } else {
      clearSearchView();
      Get.back(canPop: true);
      // showResult = true;
      return Future.value(true);
    }
  }

  /// 输入框监听
  void onChange(String value) {
    if (value.isEmpty) {
      showResult = false;
    }
  }

  /// 根据关键词搜索内容
  Future<void> loadSearchKeys() async {
    //收起软键盘
    FocusManager.instance.primaryFocus?.unfocus();

    if (keyword.toString().isNotEmpty) {
      // 本地持久化搜索记录
      SpUtil.saveSearchHistory(keyword);
      // 历史搜索数据更新及业务逻辑
      notifySearchHistory(2);
    } else {
      if (hotKeys.isNotEmpty) {
        keyword = hotKeys[0].name;
        textEditingController.text = keyword;
      }
    }
    searchByKeyword(
        loadingType: Constant.multipleShimmerLoading,
        refreshState: RefreshState.first,
        keyword: keyword);
  }

  /// 点击热词、搜索历史进行搜索
  void tagSearchChipSearch(String value) {
    // 点击Chip热词或者搜索历史某一项词条进行搜索
    keyword = value;
    //将点击的热词填充输入框
    textEditingController.text = value;
    // 关闭键盘
    FocusManager.instance.primaryFocus?.unfocus();
    // 搜索
    loadSearchKeys();
  }

  /// 搜索
  void searchByKeyword({
    required String loadingType,
    required String keyword,
    required RefreshState refreshState,
  }) async {
    //显示搜索结果页面
    showResult = true;

    if (refreshState == RefreshState.refresh ||
        refreshState == RefreshState.first) {
      /// 下拉刷新
      currentPage = 0;
    }
    if (refreshState == RefreshState.loadMore) {
      /// 上滑加载更多
      currentPage++;
    }

    handleRequestWithRefreshPaging(
      loadingType: loadingType,
      refreshState: refreshState,
      future: DioUtil().request(
        RequestApi.articleSearch.replaceFirst(RegExp('page'), '$currentPage'),
        method: DioMethod.post,
        params: {
          "k": keyword,
        },
      ),
      onSuccess: (response) async {
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
            searchResult.assignAll(dataList);
          } else if (refreshState == RefreshState.refresh) {
            searchResult.assignAll(dataList);
            Fluttertoast.showToast(msg: StringsConstant.refreshSuccess.tr);
          } else if (refreshState == RefreshState.loadMore) {
            searchResult.addAll(dataList);
          }
        } else {
          // if (isLoading) {
          if (loadingType!=Constant.noLoading) {
            refreshLoadState = LoadState.empty;
          } else {
            loadNoData();
          }
        }
      },
      onFail: (error) {
        //显示搜索结果页面
        showResult = true;
        Fluttertoast.showToast(msg: '数据请求失败 ${error.code}  ${error.message}');
      },
      onError: (error){
        //显示搜索结果页面
        showResult = true;
        Fluttertoast.showToast(msg: '数据请求失败 ${error.code}  ${error.message}');
      }
    );
  }

  /// 请求热门关键词
  void initHotKeysList() async {
    LoggerUtil.d('============> onReady*****()');

    handleRequest(
      loadingType: Constant.simpleShimmerLoading,
      future: DioUtil().request(RequestApi.hotSearch, method: DioMethod.get),
      onSuccess: (response) {
        ///列表转换的时候一定要加一下强转List<dynamic>，否则会报错
        List<HotSearchModel> hotSearchList = (response as List<dynamic>)
            .map((e) => HotSearchModel().fromJson(e))
            .toList();

        hotKeys = hotSearchList;

        if (hotKeys.isNotEmpty) {
          showHotKeys = true;
          loadState = LoadState.success;

          /// 热词hint
          hotHint = '${hotKeys[0].name} | ${hotKeys[1].name}';
        } else {
          showHotKeys = false;
          loadState = LoadState.empty;
        }
        LoggerUtil.d(
            '=====> success1 : ${hotSearchList.map((e) => e.name).toList()}');

        LoggerUtil.d(
            '=====> success2 : ${hotKeys.map((e) => e.name).toList()}');

        LoggerUtil.d('======> initHotKeysList : load success');
      },
      onFail: (value) {
        showHotKeys = false;
        LoggerUtil.d('======> initHotKeysList : load fail1');
        LoggerUtil.d('=====> fail : ${hotKeys.map((e) => e.name).toList()}');
      },
      onError: (error){
        showHotKeys = false;
        LoggerUtil.d('======> initHotKeysList : load error');
      }
    );
  }

  /// 历史搜索数据更新及业务逻辑
  void notifySearchHistory(int index) {
    var searchHistory = SpUtil.getSearchHistory();
    if (searchHistory != null) {
      // 显示历史搜索记录
      showHistoryKeys = true;
      if (searchHistory.length >= 20) {
        //仅显示最近搜索的20条记录
        searchHistory = searchHistory.sublist(0, 20);
      }
      historyKeys = searchHistory;
    } else {
      // 不显示历史搜索记录
      showHistoryKeys = false;
      // historyKeys = [''];
    }
    LoggerUtil.d('=====> notifySearchHistory $index : ${historyKeys.toList()}');
  }

  /// 清除本地存储历史搜索记录
  void clearSearchHistory() {
    SpUtil.deleteSearchHistory();
    notifySearchHistory(0);
  }
}
