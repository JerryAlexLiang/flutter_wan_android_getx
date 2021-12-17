import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_wan_android_getx/base/refresh_paging_state_page.dart';
import 'package:flutter_wan_android_getx/page/component/home_banner.dart';
import 'package:flutter_wan_android_getx/page/search/component/search_list_item_widget.dart';
import 'package:flutter_wan_android_getx/page/search/search_controller.dart';
import 'package:flutter_wan_android_getx/routes/app_routes.dart';
import 'package:flutter_wan_android_getx/utils/logger_util.dart';
import 'package:flutter_wan_android_getx/widget/search_app_bar.dart';
import 'package:flutter_wan_android_getx/widget/search_view.dart';
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

    LoggerUtil.d("=======> HomePage build");

    // return  const Icon(Icons.star);

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
        child: RefreshPagingStatePage<HomeController>(
          controller: controller,
          onPressed: () => controller.onFirstInHomeData(),
          onRefresh: () => controller.onRefreshHomeData(),
          onLoadMore: () => controller.onLoadMoreHomeData(),
          refreshController: controller.refreshController,
          // header: const ClassicHeader(),
          lottieRocketRefreshHeader: false,
          child: CustomScrollView(
            slivers: [
              _homeBanner(),
              _homeArticleList(controller),
            ],
          ),
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

  Widget _homeArticleList(HomeController controller) {
    return Obx(() {
      return SliverList(
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            return SearchListItemWidget(
              dataList: controller.homeArticleList,
              index: index,
            );
          },
          childCount: controller.homeArticleList.length,
        ),
      );
    });
  }
}
