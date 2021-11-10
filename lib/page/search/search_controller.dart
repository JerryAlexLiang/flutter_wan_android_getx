import 'package:flutter/material.dart';
import 'package:flutter_wan_android_getx/http/base_response.dart';
import 'package:flutter_wan_android_getx/http/dio_method.dart';
import 'package:flutter_wan_android_getx/http/dio_util.dart';
import 'package:flutter_wan_android_getx/http/request_api.dart';
import 'package:flutter_wan_android_getx/model/hot_search_model.dart';
import 'package:flutter_wan_android_getx/utils/logger_util.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

/// 搜索界面

class SearchController extends GetxController {
  /// 搜索输入框孔控制器
  late TextEditingController textEditingController;

  /// 关键词
  final _keyword = ''.obs;

  get keyword => _keyword.value;

  set keyword(value) => _keyword.value = value;

  /// 搜索结果
  final _searchResult = ''.obs;

  get searchResult => _searchResult.value;

  set searchResult(value) => _searchResult.value = value;

  /// 热词数据List
  final _hotKeys = <HotSearchModel>[].obs;

  List<HotSearchModel> get hotKeys => _hotKeys;

  set hotKeys(value) => _hotKeys.assignAll(value);

  /// 是否显示热词流布局
  final _showHotKeys = true.obs;

  bool get showHotKeys => _showHotKeys.value;

  set showHotKeys(value) => _showHotKeys.value = value;

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
  void onInit() {
    textEditingController = TextEditingController();
    clearSearchView();
    LoggerUtil.d('============> onInit()');
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    initHotKeysList();
    LoggerUtil.d('============> onReady()');
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
      showResult = true;
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
    if (keyword.toString().isNotEmpty) {
      Fluttertoast.showToast(msg: keyword);
      searchResult = keyword;
      showResult = true;
    } else {
      Fluttertoast.showToast(msg: '请输入搜索内容~');
    }
  }

  /// 请求热门关键词
  Future<void> initHotKeysList() async {

    LoggerUtil.d('============> onReady*****()');

    BaseResponse response =
        await DioUtil().request(RequestApi.hotSearch, method: DioMethod.get);

    //拿到res.data就可以进行Json解析了，这里一般用来构造实体类
    var success = response.success;
    if (success != null) {
      if (success) {
        ///列表转换的时候一定要加一下强转List<dynamic>，否则会报错
        List<HotSearchModel> hotSearchList = (response.data as List<dynamic>)
            .map((e) => HotSearchModel().fromJson(e))
            .toList();

        hotKeys = hotSearchList;

        if (hotKeys.isNotEmpty) {
          showHotKeys = true;
        } else {
          showHotKeys = false;
        }
        LoggerUtil.d(
            '=====> success1 : ${hotSearchList.map((e) => e.name).toList()}');

        LoggerUtil.d(
            '=====> success2 : ${hotKeys.map((e) => e.name).toList()}');
      } else {
        showHotKeys = false;
        LoggerUtil.d('=====> fail : ${hotKeys.map((e) => e.name).toList()}');
      }
    }
  }
}
