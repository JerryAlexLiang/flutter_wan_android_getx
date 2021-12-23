import 'package:flutter/material.dart';
import 'package:flutter_wan_android_getx/base/base_getx_controller.dart';
import 'package:flutter_wan_android_getx/model/tree_model.dart';
import 'package:get/get.dart';

class SystemContentController extends BaseGetXController
    with GetSingleTickerProviderStateMixin {
  late TabController tabController;

  final TreeModel treeModel = Get.arguments['treeModel'];
  final int index = Get.arguments['treeModelIndex'];

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(
      length: treeModel.children!.length,
      vsync: this,
      initialIndex: index,
    );
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }
}
