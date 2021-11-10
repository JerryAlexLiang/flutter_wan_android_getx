import 'package:flutter/material.dart';
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

  /// 热词数据
  final hotKeys = <String>[].obs;

  /// 是否显示搜索结果界面
  final _isShowResult = false.obs;

  get isShowResult => _isShowResult.value;

  set isShowResult(value) => _isShowResult.value = value;

  //两种模式 0： 默认界面 1： 搜索结果界面
  int get indexed {
    if (isShowResult) {
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
    Fluttertoast.showToast(msg: '关闭');
    isShowResult = false;
  }

  /// 退出搜索框
  finishSearchPage() {
    clearSearchView();
    FocusManager.instance.primaryFocus?.unfocus();
    Get.back(canPop: true);
  }

  Future<void> loadSearchKeys() async {
    if (keyword.toString().isNotEmpty) {
      Fluttertoast.showToast(msg: keyword);
      isShowResult = true;
    } else {
      Fluttertoast.showToast(msg: '请输入搜索内容~');
      // isShowResult = false;
    }
  }
}
