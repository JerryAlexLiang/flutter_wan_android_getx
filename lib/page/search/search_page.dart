import 'package:flutter/material.dart';
import 'package:flutter_wan_android_getx/base/common_state_page.dart';
import 'package:flutter_wan_android_getx/base/refresh_paging_state_page.dart';
import 'package:flutter_wan_android_getx/page/search/component/normal_search_page.dart';
import 'package:flutter_wan_android_getx/page/search/component/search_list_item_widget.dart';
import 'package:flutter_wan_android_getx/res/strings.dart';
import 'package:flutter_wan_android_getx/widget/search_app_bar.dart';
import 'package:flutter_wan_android_getx/widget/search_view.dart';
import 'package:flutter_wan_android_getx/widget/state/load_state.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
        actionName: StringsConstant.search.tr,
        onRightPressed: () {
          controller.loadSearchKeys();
        },
        searchInput: Obx(() {
          return SearchView(
            enabled: true,
            hintText: controller.hotHint,
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
          );
        }),
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
            // 历史搜索和热词标签tag页面
            hotHistoryView(),
            searchResultView(),
          ],
        ),
        onWillPop: () => controller.onWillPopListener(),
      );
    });
  }

  /// 历史搜索和热词标签tag页面
  Widget hotHistoryView() {
    return CommonStatePage<SearchController>(
      controller: controller,
      onPressed: () => controller.initHotKeysList(),
      child: const NormalSearchPage(),
    );
  }

  Widget searchResultView() {
    return RefreshPagingStatePage<SearchController>(
      controller: controller,
      onPressed: () {
        /// 错误页面 点击重新加载数据
        controller.loadSearchKeys();
      },
      refreshController: controller.refreshController,
      onRefresh: () {
        /// isRefresh: true 下拉刷新
        controller.searchByKeyword(
            isLoading: false,
            refreshState: RefreshState.refresh,
            keyword: controller.keyword);
      },
      onLoadMore: () {
        /// isLoadMore: true 上滑加载更多
        controller.searchByKeyword(
            isLoading: false,
            refreshState: RefreshState.loadMore,
            keyword: controller.keyword);
      },

      child: ListView.builder(
        itemCount: controller.searchResult.length,
        itemBuilder: (context, index) {
          return SearchListItemWidget(
            model: controller.searchResult[index],
          );
        },
      ),
      // child: ListView.builder(
      //   itemCount: controller.searchResult.length,
      //   itemBuilder: (context, index) {
      //     return Container(
      //       padding: const EdgeInsets.symmetric(
      //         vertical: 5,
      //         horizontal: 10,
      //       ),
      //       decoration: const BoxDecoration(
      //           border: Border(
      //         bottom: BorderSide(
      //           width: 0.1,
      //           color: Colors.grey,
      //         ),
      //       )),
      //       child: ListTile(
      //         onTap: () => Fluttertoast.showToast(
      //             msg: controller.searchResult[index].title ?? "致一科技"),
      //         title: Text(controller.searchResult[index].title ?? ""),
      //         subtitle: Text(controller.searchResult[index].chapterName ?? ''),
      //       ),
      //     );
      //   },
      // ),

      //   // 带分割线的ListView - 点击范围之外-不用这种方法，使用Decoration设置下划线
      //   child: ListView.separated(
      //     separatorBuilder: (context, index) {
      //       return const Divider(
      //         thickness: 0.1,
      //         color: Colors.grey,
      //         indent: 10,
      //         endIndent: 10,
      //       );
      //     },
      //     itemCount: controller.searchResult.length,
      //     itemBuilder: (context, index) {
      //       return ListTile(
      //         onTap: () => Fluttertoast.showToast(
      //             msg: controller.searchResult[index].title ?? "致一科技"),
      //         title: Text(controller.searchResult[index].title ?? ""),
      //         subtitle: Text(controller.searchResult[index].chapterName ?? ''),
      //       );
      //     },
      //   ),
    );
  }
}
