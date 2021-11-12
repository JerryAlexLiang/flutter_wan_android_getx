import 'package:flutter/material.dart';
import 'package:flutter_wan_android_getx/page/search/component/normal_search_page.dart';
import 'package:flutter_wan_android_getx/widget/search_app_bar.dart';
import 'package:flutter_wan_android_getx/widget/search_view.dart';
import 'package:flutter_wan_android_getx/widget/state/load_state.dart';
import 'package:flutter_wan_android_getx/widget/state/shimmer_loading_page.dart';
import 'package:get/get.dart';

import 'search_controller.dart';

/// 搜索界面

class SearchPage extends StatelessWidget {
  final controller = Get.find<SearchController>();

  SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SearchAppBar(
        showLeft: true,
        onLeftPressed: () => controller.finishSearchPage(),
        showRight: true,
        actionName: '搜索',
        onRightPressed: () {
          controller.loadSearchKeys();
        },
        searchInput: SearchView(
          enabled: true,
          hintText: '致一科技',
          editingController: controller.textEditingController,
          onSuffixPressed: () => controller.clearSearchView(),
          onChange: (String value) {
            // 输入时监听赋值
            controller.keyword = value;
            controller.onChange(value);
          },
          onSubmit: (value) => {
            controller.loadSearchKeys(),
          },
        ),
      ),
      body: _buildSearchView(),
    );
  }

  Obx _buildSearchView() {
    return Obx(() {
      return WillPopScope(
        child: IndexedStack(
          index: controller.indexed,
          children: [
            controller.loadState == LoadState.loading
                ? const ShimmerLoadingPage()
                : const NormalSearchPage(),
            Container(
              color: Colors.red,
              height: Get.height,
              width: Get.width,
              child: Center(
                child: Text(
                  controller.searchResult,
                  style: const TextStyle(
                    fontSize: 22,
                  ),
                ),
              ),
            ),
          ],
        ),
        onWillPop: () => controller.onWillPopListener(),
      );
    });
  }
}
