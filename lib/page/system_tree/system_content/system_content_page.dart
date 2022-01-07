import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_wan_android_getx/model/tree_model.dart';
import 'package:flutter_wan_android_getx/page/system_tree/tree_article_list_page_view/tree_article_list_page_view_page.dart';
import 'package:flutter_wan_android_getx/theme/app_theme.dart';
import 'package:flutter_wan_android_getx/widget/custom_underline_tabIndicator.dart';
import 'package:flutter_wan_android_getx/widget/keep_alive_wrapper.dart';
import 'package:flutter_wan_android_getx/widget/ripple_view.dart';
import 'package:get/get.dart';

import 'system_content_controller.dart';

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

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          '${treeModel.name}',
          style: context.bodyText1Style,
        ),
        actions: [
          RippleView(
            radius: 100,
            onTap: () {
              // 地不弹出菜单
              Get.bottomSheet(
                Container(
                  padding: EdgeInsets.all(10.w),
                  child: Wrap(
                    runSpacing: 1.w,
                    spacing: 5.w,
                    children: warpList(context, treeModel, controller),
                  ),
                ),
                backgroundColor: context.scaffoldBackgroundColor,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                ),
              );
            },
            child: Container(
              child: const Icon(Icons.menu),
              padding: const EdgeInsets.all(5),
            ),
          ),
        ],
        bottom: treeTab(context, controller, treeModel),
      ),
      body: tabBarView(context, controller, treeModel, index),
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

  //const KeepAliveWrapper(
  //         // keepAlive默认为true
  //         // keepAlive为 true 后会缓存所有的列表项，列表项将不会销毁。
  //         // keepAlive为 false 时，列表项滑出预加载区域后将会别销毁。
  //         // 使用时一定要注意是否必要，因为对所有列表项都缓存的会导致更多的内存消耗
  //         keepAlive: true,
  //         child: HomePage(),
  //       ),
  tabBarView(BuildContext context, SystemContentController controller,
      TreeModel treeModel, int index) {
    var pageViewList = treeModel.children!
        .map((e) => KeepAliveWrapper(
              child: TreeArticleListPageViewPage(id: e.id),
            ))
        .toList();

    return TabBarView(
      controller: controller.tabController,
      children: pageViewList,
    );
  }

  warpList(BuildContext context, TreeModel treeModel,
      SystemContentController controller) {
    List<Widget> warpList = treeModel.children!.map((element) {
        return ChoiceChip(
          label: Text(
            element.name ?? "",
            style: context.bodyText2Style,
          ),
          selectedColor: Colors.lightBlueAccent.withOpacity(0.5),
          selected: controller.tabController.index ==
              controller.treeModel.children!.indexOf(element),
          onSelected: (bool newValue) {
            controller.tabController.index =
                controller.treeModel.children!.indexOf(element);
            //关闭弹框
            if (Get.isBottomSheetOpen == true) {
              Get.back();
            }
          },
        );
    }).toList();

    return warpList;
  }
}
