import 'package:flutter/material.dart';
import 'package:flutter_wan_android_getx/base/common_state_page.dart';
import 'package:flutter_wan_android_getx/base/refresh_paging_state_page.dart';
import 'package:flutter_wan_android_getx/page/search/component/normal_search_page.dart';
import 'package:flutter_wan_android_getx/widget/search_app_bar.dart';
import 'package:flutter_wan_android_getx/widget/search_view.dart';
import 'package:flutter_wan_android_getx/widget/state/load_state.dart';
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
        showBottomLine: true,
        showLeft: true,
        onLeftPressed: () => controller.finishSearchPage(),
        showRight: true,
        actionName: '搜索',
        onRightPressed: () {
          // controller.loadSearchKeys();
          controller.initHotKeysList();
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
        // child: IndexedStack(
        //   index: controller.indexed,
        //   children: [
        //     // 历史搜索和热词标签tag页面
        //     hotHistoryView(),
        //     searchResultView(),
        //   ],
        // ),

        // child: controller.indexed == 0 ? hotHistoryView() : searchResultView(),

        child: Stack(
          children: [
            Visibility(
              visible: controller.showResult == false,
              child: hotHistoryView(),
            ),
            Visibility(
              visible: controller.showResult == true,
              child: searchResultView(),
            ),
          ],
        ),
        onWillPop: () => controller.onWillPopListener(),
      );
    });
  }

  /// 历史搜索和热词标签tag页面
  Widget hotHistoryView() {
    return CommonStatePage(
      controller: controller,
      onPressed: () => controller.initHotKeysList(),
      child: const NormalSearchPage(),
    );
  }

  Widget searchResultView() {
    return RefreshPagingStatePage(
      controller: controller,
      onPressed: () {
        /// 错误页面 点击重新加载数据
        controller.searchByKeyword(
          // isLoading: true,
          refreshState: controller.refreshState = RefreshState.firstLoad,
          isSimpleLoading: false,
          keyword: controller.keyword,
        );
      },
      refreshController: controller.refreshController,
      onRefresh: () {
        /// isRefresh: true 下拉刷新
        controller.searchByKeyword(
            // isLoading: false,
            isSimpleLoading: false,
            refreshState: controller.refreshState =RefreshState.refresh,
            keyword: controller.keyword);
      },
      onLoadMore: () {
        /// isLoadMore: true 上滑加载更多
        controller.searchByKeyword(
            // isLoading: false,
            isSimpleLoading: false,
            refreshState: controller.refreshState =RefreshState.loadMore,
            keyword: controller.keyword);
      },
      child: ListView.builder(
        itemCount: controller.searchResult.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(controller.searchResult[index].title ?? ""),
            subtitle: Text(controller.searchResult[index].chapterName ?? ''),
          );
        },
      ),
    );
  }
}
