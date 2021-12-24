import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wan_android_getx/model/tree_model.dart';
import 'package:flutter_wan_android_getx/page/system_tree/tree_article_list_page_view/tree_article_list_page_view_page.dart';
import 'package:flutter_wan_android_getx/widget/custom_underline_tabIndicator.dart';
import 'package:flutter_wan_android_getx/widget/keep_alive_wrapper.dart';
import 'package:flutter_wan_android_getx/widget/sliver_appbar_delegate.dart';
import 'package:get/get.dart';
import 'system_content_controller.dart';
import 'package:flutter_wan_android_getx/theme/app_theme.dart';

/// 类名: system_content_page.dart
/// 创建日期: 12/23/21 on 11:18 AM
/// 描述: 体系PageView
/// 作者: 杨亮

class SystemContentPage extends StatelessWidget {
  const SystemContentPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SystemContentController>();

    final TreeModel treeModel = Get.arguments['treeModel'];
    final int index = Get.arguments['treeModelIndex'];

    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            sliverAppBar(context, controller, treeModel),
            persistentHeaderTabBar(context, controller, treeModel),
            sliverTabBarView(context, controller, treeModel, index),
          ],
        ),
      ),
    );
  }

  Widget sliverAppBar(BuildContext context, SystemContentController controller,
      TreeModel treeModel) {
    return SliverAppBar(
      pinned: false,
      elevation: 0,
      centerTitle: true,
      title: Text(
        '${treeModel.name}',
        style: context.bodyText1Style,
      ),
      // bottom: treeTab(context, controller, treeModel),
    );
  }

  treeTab(BuildContext context, SystemContentController controller,
      TreeModel treeModel) {
    List<Widget>? tabList = treeModel.children
        ?.map((e) => Tab(
              text: e.name,
            ))
        .toList();

    return TabBar(
      tabs: tabList!,
      controller: controller.tabController,
      isScrollable: true,
      indicatorColor: Colors.red,
      indicatorSize: TabBarIndicatorSize.label,
      indicatorWeight: 0,
      //自定义indicator指示器
      indicator: const CustomUnderlineTabIndicator(
        borderSide: BorderSide(
          width: 3,
          color: Colors.red,
        ),
        insets: EdgeInsets.only(
          left: 12,
          right: 12,
          top: 10,
          // bottom: 3,
        ),
      ),
      automaticIndicatorColorAdjustment: true,
      labelColor: Colors.blue,
      unselectedLabelColor: context.bodyText2Color,
      labelStyle: const TextStyle(
        color: Colors.blue,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      unselectedLabelStyle: TextStyle(
        color: context.bodyText2Color,
        fontSize: 14,
        fontWeight: FontWeight.normal,
      ),
    );
  }

  persistentHeaderTabBar(BuildContext context,
      SystemContentController controller, TreeModel treeModel) {
    return SliverPersistentHeader(
        pinned: true,
        delegate: SliverAppBarDelegate(
          minHeight: 50,
          maxHeight: 50,
          child: Container(
            color: context.scaffoldBackgroundColor,
            child: treeTab(
              context,
              controller,
              treeModel,
            ),
          ),
        ));
  }

  //const KeepAliveWrapper(
  //         // keepAlive默认为true
  //         // keepAlive为 true 后会缓存所有的列表项，列表项将不会销毁。
  //         // keepAlive为 false 时，列表项滑出预加载区域后将会别销毁。
  //         // 使用时一定要注意是否必要，因为对所有列表项都缓存的会导致更多的内存消耗
  //         keepAlive: true,
  //         child: HomePage(),
  //       ),
  sliverTabBarView(BuildContext context, SystemContentController controller,
      TreeModel treeModel, int index) {
    var pageViewList = treeModel.children!
        .map((e) => KeepAliveWrapper(
              child: TreeArticleListPageViewPage(id: e.id),
            ))
        .toList();

    /// SliverFillViewport 对应的可滚动组件 PageView
    // return SliverFillViewport(
    //   delegate: SliverChildBuilderDelegate(
    //     (context, index) {
    //       return TabBarView(
    //         controller: controller.tabController,
    //         children: pageViewList,
    //       );
    //     },
    //     childCount: 1,
    //   ),
    // );

    return SliverFillRemaining(
      child: TabBarView(
        controller: controller.tabController,
        children: pageViewList,
      ),
    );

  }
}
