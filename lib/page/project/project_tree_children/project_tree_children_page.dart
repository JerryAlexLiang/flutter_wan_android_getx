import 'package:flutter/material.dart';
import 'package:flutter_wan_android_getx/base/refresh_paging_state_page.dart';
import 'package:flutter_wan_android_getx/page/search/article_detail_controller.dart';
import 'package:flutter_wan_android_getx/page/search/component/search_list_item_widget.dart';
import 'package:get/get.dart';

import 'project_tree_children_controller.dart';

/// 类名: project_tree_children_page.dart
/// 创建日期: 12/27/21 on 2:59 PM
/// 描述: 项目分类下的文章列表
/// 作者: 杨亮

class ProjectTreeChildrenPage extends StatelessWidget {
  const ProjectTreeChildrenPage({
    Key? key,
    this.id,
  }) : super(key: key);

  final int? id;

  @override
  Widget build(BuildContext context) {
    /// Don't use one refreshController to multiple SmartRefresher,It will cause some unexpected bugs mostly in TabBarView
    /// 解决办法
    final controller =
        Get.put(ProjectTreeChildrenController(), tag: id.toString());

    final detailController = Get.find<ArticleDetailController>();
    //
    // /// 赋值cid
    controller.setCid(id);

    /// 第一次进入
    controller.onFirstInRequestData();

    return Scaffold(
      body: Obx(() {
        return RefreshPagingStatePage<ProjectTreeChildrenController>(
          controller: controller,
          refreshController: controller.refreshController,
          onPressed: () => controller.onFirstInRequestData(),
          onRefresh: () => controller.onRefreshRequestData(),
          onLoadMore: () => controller.onLoadMoreRequestData(),
          // lottieRocketRefreshHeader: false,
          child: ListView.builder(
            controller: controller.scrollController,
            itemCount: controller.projectTreeArticleList.length,
            itemBuilder: (context, index) {
              return SearchListItemWidget(
                dataList: controller.projectTreeArticleList,
                index: index,
                onCollectClick: (int index) {
                  // 文章列表收藏、取消收藏
                  detailController.requestCollectArticle(
                      controller.projectTreeArticleList[index]);
                },
              );
            },
          ),
        );
      }),
    );

    return Container(
      height: 1000,
      color: Colors.pinkAccent,
      child: Center(
        child: Text("$id"),
      ),
    );
  }
}
