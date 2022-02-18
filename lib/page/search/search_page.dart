import 'package:flutter/material.dart';
import 'package:flutter_wan_android_getx/base/common_state_page.dart';
import 'package:flutter_wan_android_getx/base/refresh_paging_state_page.dart';
import 'package:flutter_wan_android_getx/constant/constant.dart';
import 'package:flutter_wan_android_getx/page/search/article_detail_controller.dart';
import 'package:flutter_wan_android_getx/page/search/component/normal_search_page.dart';
import 'package:flutter_wan_android_getx/page/search/component/search_list_item_widget.dart';
import 'package:flutter_wan_android_getx/res/strings.dart';
import 'package:flutter_wan_android_getx/widget/search_app_bar.dart';
import 'package:flutter_wan_android_getx/widget/search_view.dart';
import 'package:flutter_wan_android_getx/widget/state/favorite_lottie_widget.dart';
import 'package:flutter_wan_android_getx/widget/state/load_state.dart';
import 'package:flutter_wan_android_getx/widget/state/loading_lottie_rocket_widget.dart';
import 'package:get/get.dart';
import 'search_controller.dart';

/// 搜索界面

class SearchPage extends StatelessWidget {
  final controller = Get.find<SearchController>();

  final detailController = Get.find<ArticleDetailController>();

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
    return Stack(
      alignment: Alignment.center,
      children: [
        RefreshPagingStatePage<SearchController>(
          controller: controller,
          onPressed: () {
            /// 错误页面 点击重新加载数据
            controller.loadSearchKeys();
          },
          refreshController: controller.refreshController,
          onRefresh: () {
            /// isRefresh: true 下拉刷新
            controller.searchByKeyword(
                loadingType: Constant.noLoading,
                refreshState: RefreshState.refresh,
                keyword: controller.keyword);
          },
          onLoadMore: () {
            /// isLoadMore: true 上滑加载更多
            controller.searchByKeyword(
                loadingType: Constant.noLoading,
                refreshState: RefreshState.loadMore,
                keyword: controller.keyword);
          },
          child: ListView.builder(
            controller: controller.scrollController,
            itemCount: controller.searchResult.length,
            itemBuilder: (context, index) {
              return SearchListItemWidget(
                dataList: controller.searchResult,
                index: index,
                onCollectClick: (int index) {
                  detailController
                      .requestCollectArticle(controller.searchResult[index]);
                },
              );
            },
          ),
        ),
        Obx(() {
          /// 收藏动画
          return Positioned(
            top: Get.height / 5,
            left: 0,
            right: 0,
            child: FavoriteLottieWidget(
              visible: detailController.collectAnimation,
              animate: detailController.collectAnimation,
              repeat: false,
              width: Get.width,
              height: Get.height / 3,
            ),
          );
        }),
        Obx(() {
          return Positioned(
            top: Get.height / 5,
            left: 0,
            right: 0,
            child: LoadingLottieRocketWidget(
              visible: detailController.unCollectAnimation,
              animate: detailController.unCollectAnimation,
              repeat: false,
              width: Get.width,
              height: Get.height / 3,
            ),
          );
        }),
      ],
    );
  }
}
