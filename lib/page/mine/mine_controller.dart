import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class MineController extends GetxController {
  //标题栏透明比例
  final _percent = 0.0.obs;

  get percent => _percent.value;

  set percent(value) => _percent.value = value;

  //滚动控制器
  ScrollController scrollController = ScrollController();

  //下拉刷新控制器
  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  @override
  void onInit() {
    super.onInit();
    //滑动监听
    scrollController.addListener(() {
      var scrollerPercent = scrollController.offset / 140;
      if (scrollerPercent < 0) {
        scrollerPercent = 0;
      } else if (scrollerPercent > 1.0) {
        scrollerPercent = 1.0;
      }
      percent = scrollerPercent;
    });
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }
}
