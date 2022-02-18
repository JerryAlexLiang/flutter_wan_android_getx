import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_wan_android_getx/base/refresh_paging_state_page.dart';
import 'package:flutter_wan_android_getx/page/home/component/home_banner.dart';
import 'package:flutter_wan_android_getx/page/search/article_detail_controller.dart';
import 'package:flutter_wan_android_getx/page/search/component/search_list_item_widget.dart';
import 'package:flutter_wan_android_getx/page/search/search_controller.dart';
import 'package:flutter_wan_android_getx/routes/app_routes.dart';
import 'package:flutter_wan_android_getx/utils/logger_util.dart';
import 'package:flutter_wan_android_getx/widget/search_app_bar.dart';
import 'package:flutter_wan_android_getx/widget/search_view.dart';
import 'package:flutter_wan_android_getx/widget/state/favorite_lottie_widget.dart';
import 'package:flutter_wan_android_getx/widget/state/loading_lottie_rocket_widget.dart';
import 'package:get/get.dart';

import 'home_controller.dart';

/// 类名: home_page.dart
/// 创建日期: 12/15/21 on 5:33 PM
/// 描述: 首页
/// 作者: 杨亮

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();
    final searchController = Get.find<SearchController>();
    final detailController = Get.find<ArticleDetailController>();

    LoggerUtil.d("=======> HomePage build");

    return Scaffold(
      appBar: SearchAppBar(
        showLeft: true,
        showRight: false,
        // showBottomLine: true,
        bottomLineColor: Colors.red,
        leftName: 'Flutter',
        leftNameStyle: const TextStyle(fontSize: 16),
        leftPadding: const EdgeInsets.only(left: 16, right: 5),
        searchInput: Obx(() {
          return SearchView(
            hintText: '大家都在搜：${searchController.hotHint}',
            hintTextStyle: const TextStyle(fontSize: 13),
            onTap: () => Get.toNamed(AppRoutes.searchPage),
          );
        }),
      ),
      body: SafeArea(
        top: true,
        // child: RefreshPagingStatePage<HomeController>(
        //   controller: controller,
        //   onPressed: () => controller.onFirstInHomeData(),
        //   onRefresh: () => controller.onRefreshHomeData(),
        //   onLoadMore: () => controller.onLoadMoreHomeData(),
        //   refreshController: controller.refreshController,
        //   // header: const ClassicHeader(),
        //   lottieRocketRefreshHeader: false,
        //   child: CustomScrollView(
        //     // 滑动监听器
        //     controller: controller.scrollController,
        //     slivers: [
        //       _homeBanner(),
        //       _homeArticleList(controller),
        //     ],
        //   ),
        // ),

        child: Stack(
          alignment: Alignment.center,
          children: [
            RefreshPagingStatePage<HomeController>(
              controller: controller,
              onPressed: () => controller.onFirstInHomeData(),
              onRefresh: () => controller.onRefreshHomeData(),
              onLoadMore: () => controller.onLoadMoreHomeData(),
              refreshController: controller.refreshController,
              // header: const ClassicHeader(),
              lottieRocketRefreshHeader: false,
              child: CustomScrollView(
                // 滑动监听器
                controller: controller.scrollController,
                slivers: [
                  _homeBanner(),
                  _homeArticleList(controller, detailController),
                ],
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
        ),
      ),
    );
  }

  /// 轮播图Banner
  Widget _homeBanner() {
    return SliverToBoxAdapter(
      child: Container(
        height: 120.h,
        child: const HomeBannerWidget(),
      ),
    );
  }

  Widget _homeArticleList(
      HomeController controller, ArticleDetailController detailController) {
    return Obx(() {
      return SliverList(
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            return SearchListItemWidget(
              dataList: controller.homeArticleList,
              index: index,
              onCollectClick: (int index) {
                // 文章列表收藏、取消收藏
                detailController
                    .requestCollectArticle(controller.homeArticleList[index]);
              },
            );
          },
          childCount: controller.homeArticleList.length,
        ),
      );
    });
  }
}
