import 'package:flutter/material.dart';
import 'package:flutter_wan_android_getx/base/common_state_page.dart';
import 'package:flutter_wan_android_getx/base/refresh_paging_state_page.dart';
import 'package:flutter_wan_android_getx/page/search/article_detail_controller.dart';
import 'package:flutter_wan_android_getx/page/search/component/normal_search_page.dart';
import 'package:flutter_wan_android_getx/page/search/component/search_list_item_widget.dart';
import 'package:flutter_wan_android_getx/res/r.dart';
import 'package:flutter_wan_android_getx/res/strings.dart';
import 'package:flutter_wan_android_getx/widget/search_app_bar.dart';
import 'package:flutter_wan_android_getx/widget/search_view.dart';
import 'package:flutter_wan_android_getx/widget/state/favorite_lottie_widget.dart';
import 'package:flutter_wan_android_getx/widget/state/load_state.dart';
import 'package:flutter_wan_android_getx/widget/state/loading_lottie_widget.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
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
    /////  初始化收藏状态 async 防止因控件还没有构建完成 【setState() or markNeedsBuild() called during build.】
    //   Future<void> initCollectState() async {
    //     // 使用延迟加载可以解决问题
    //     await Future.delayed(const Duration(milliseconds: 0));
    //     /// 初始化收藏状态
    //     if (model != null) {
    //       controller.initCollectState(model!.collect!);
    //       LoggerUtil.d('+++++++>>>>>1  ${model!.collect!}');
    //       LoggerUtil.d('+++++++>>>>>2  ${controller.isCollect}');
    //     }
    //   }
    return Stack(
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
                dataList: controller.searchResult,
                index: index,
              );
            },
          ),
        ),
        Obx(() {
          /// 收藏动画
          // return Visibility(
          //   visible: detailController.collectAnimation,
          //   child: Positioned(
          //     /// 居中显示
          //     top: 0,
          //     bottom: 0,
          //     left: 0,
          //     right: 0,
          //     child: Lottie.asset(
          //       R.assetsLottieCollectAnimation,
          //       animate: detailController.collectAnimation,
          //       repeat: false,
          //     ),
          //   ),
          // );
          return FavoriteLottieWidget(
            visible: detailController.collectAnimation,
            animate: detailController.collectAnimation,
            repeat: false,
          );
        }),
        Obx(() {
          return Loading53483LottieWidget(
            visible: detailController.unCollectAnimation,
            animate: detailController.unCollectAnimation,
            repeat: false,
          );
        })
      ],
    );
  }
}
