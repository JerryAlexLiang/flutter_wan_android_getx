import 'package:flutter/material.dart';
import 'package:flutter_wan_android_getx/base/refresh_paging_state_page.dart';
import 'package:flutter_wan_android_getx/page/search/component/search_list_item_widget.dart';
import 'package:get/get.dart';

import 'collect_article_list_controller.dart';

/// 类名: collect_article_list_page.dart
/// 创建日期: 2/17/22 on 4:27 PM
/// 描述: 收藏文章列表
/// 作者: 杨亮

class CollectArticleListPage extends StatelessWidget {
  const CollectArticleListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // /// Don't use one refreshController to multiple SmartRefresher,It will cause some unexpected bugs mostly in TabBarView
    // /// 解决办法
    // // final controller =
    // // Get.put(ProjectTreeChildrenController(), tag: id.toString());

    // final controller = Get.put(CollectArticleListController());

    final controller = Get.find<CollectArticleListController>();

    return Scaffold(
      body: Obx(() {
        return RefreshPagingStatePage<CollectArticleListController>(
          controller: controller,
          refreshController: controller.refreshController,
          onPressed: () => controller.onFirstInRequestData(),
          onRefresh: () => controller.onRefreshRequestData(),
          onLoadMore: () => controller.onLoadMoreRequestData(),
          child: ListView.builder(
            itemCount: controller.collectArticleList.length,
            itemBuilder: (context, index) {
              return SearchListItemWidget(
                dataList: controller.collectArticleList,
                index: index,
                onCollectClick: (int index) {
                  controller.requestUnCollectArticle(
                      controller.collectArticleList[index]);
                },
              );
            },
          ),
        );
      }),
    );
  }
}
