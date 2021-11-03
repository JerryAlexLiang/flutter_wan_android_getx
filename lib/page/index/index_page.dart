import 'package:flutter/material.dart';
import 'package:flutter_wan_android_getx/utils/logger_util.dart';
import 'package:get/get.dart';

import 'index_controller.dart';

/// 主页导航
class IndexPage extends GetView<IndexController> {
  const IndexPage({Key? key}) : super(key: key);

  // final controller = Get.find<IndexController>();

  @override
  Widget build(BuildContext context) {

    LoggerUtil.d('IndexPage build',tag: 'IndexPage');

    return Scaffold(
      bottomNavigationBar: _buildBottomNavigationBar(),
      body: _buildPageView(),
    );
  }

  /// 底部导航栏
  Widget _buildBottomNavigationBar() {
    return Obx(() {
      return BottomNavigationBar(
        items: controller.bottomTabs,
        currentIndex: controller.currentPage,
        type: BottomNavigationBarType.fixed,
        selectedFontSize: 16,
        unselectedFontSize: 13,
        onTap: (int index) => controller.switchBottomTabBar(index),
      );
    });
  }

  /// 内容页
  Widget _buildPageView() {
    return PageView(
      //禁止滑动
      // physics: const NeverScrollableScrollPhysics(),
      children: controller.tabPageBodies,
      controller: controller.pageController,
      onPageChanged: (index) => controller.onPageChanged(index),
    );
  }
}
