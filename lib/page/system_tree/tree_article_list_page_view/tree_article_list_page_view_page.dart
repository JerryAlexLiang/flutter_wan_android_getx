import 'package:flutter/material.dart';
import 'package:flutter_wan_android_getx/base/refresh_paging_state_page.dart';
import 'package:flutter_wan_android_getx/page/search/component/search_list_item_widget.dart';
import 'package:get/get.dart';
import 'tree_article_list_page_view_controller.dart';

/// 类名: tree_article_list_page_view_page.dart
/// 创建日期: 12/23/21 on 6:19 PM
/// 描述: 知识体系下的文章
/// 作者: 杨亮

class TreeArticleListPageViewPage extends StatelessWidget {
  const TreeArticleListPageViewPage({
    Key? key,
    required this.id,
  }) : super(key: key);

  final int? id;

  @override
  Widget build(BuildContext context) {
    /// Don't use one refreshController to multiple SmartRefresher,It will cause some unexpected bugs mostly in TabBarView
    /// 解决办法
    final controller =
        Get.put(TreeArticleListPageViewController(), tag: id.toString());

    /// 赋值cid
    controller.setCid(id);

    /// 第一次进入
    controller.onFirstInRequestData();

    return Scaffold(
      body: Obx(() {
        return RefreshPagingStatePage<TreeArticleListPageViewController>(
          controller: controller,
          refreshController: controller.refreshController,
          onPressed: () => controller.onFirstInRequestData(),
          onRefresh: () => controller.onRefreshRequestData(),
          onLoadMore: () => controller.onLoadMoreRequestData(),
          lottieRocketRefreshHeader: false,
          child: ListView.builder(
            /// 当ListView需要ScrollController的时候，NestedScrollView就会和ListView的滚动失去关联，此时我们只要把ScrollController换成NotificationListener
            // controller: controller.scrollController,
            itemCount: controller.treeArticleList.length,
            itemBuilder: (context, index) {
              return SearchListItemWidget(
                dataList: controller.treeArticleList,
                index: index,
              );
            },
          ),
        );
      }),
    );
  }
}
