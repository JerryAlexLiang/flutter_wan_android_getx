import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_wan_android_getx/base/common_state_page.dart';
import 'package:flutter_wan_android_getx/page/project/project_tree_children/project_tree_children_page.dart';
import 'package:flutter_wan_android_getx/res/strings.dart';
import 'package:flutter_wan_android_getx/routes/app_routes.dart';
import 'package:flutter_wan_android_getx/theme/app_theme.dart';
import 'package:flutter_wan_android_getx/utils/logger_util.dart';
import 'package:flutter_wan_android_getx/widget/custom_underline_tabIndicator.dart';
import 'package:flutter_wan_android_getx/widget/keep_alive_wrapper.dart';
import 'package:flutter_wan_android_getx/widget/ripple_view.dart';
import 'package:get/get.dart';

import 'project_controller.dart';

/// 类名: project_page.dart
/// 创建日期: 12/27/21 on 2:04 PM
/// 描述: 项目分类
/// 作者: 杨亮

class ProjectPage extends StatelessWidget {
  const ProjectPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProjectController>();

    LoggerUtil.d("=======> ProjectPage build");

    return CommonStatePage<ProjectController>(
      controller: controller,
      onPressed: () => controller.initProjectTreeList(),
      child: Obx(() {
        /// 实战中，如果需要 TabBar 和 TabBarView 联动，通常会创建一个 DefaultTabController 作为它们共同的父级组件，
        /// 这样它们在执行时就会从组件树向上查找，都会使用我们指定的这个 DefaultTabController
        // return DefaultTabController(
        //   length: controller.projectTreeList.length,
        //   initialIndex: 0,
        //   child: Scaffold(
        //     appBar: AppBar(
        //       centerTitle: true,
        //       title: Text(
        //         StringsConstant.projectPage.tr,
        //         style: context.subtitle1Style,
        //       ),
        //       bottom: treeTab(context, controller),
        //     ),
        //     body: sliverPageView(context, controller),
        //   ),
        // );

        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              StringsConstant.projectPage.tr,
              style: context.subtitle1Style,
            ),
            actions: [
              RippleView(
                radius: 100,
                onTap: () => Get.toNamed(AppRoutes.searchPage),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  child: Icon(
                    Icons.search,
                    color: context.theme.appBarTheme.iconTheme?.color,
                  ),
                ),
              ),
            ],
            bottom: treeTabContainer(context, controller),
          ),
          body: sliverPageView(context, controller),
        );
      }),
    );
  }

  treeTabBar(BuildContext context, ProjectController controller) {
    if (controller.projectTreeList.isNotEmpty) {
      List<Widget>? tabList = controller.projectTreeList
          .map((e) => Tab(
                text: e!.name,
              ))
          .toList();

      /// TabBar监听
      controller.tabController.addListener(() {
        if (controller.tabController.index ==
            controller.tabController.animation!.value) {
          controller.projectChildrenIndex = controller.tabController.index;
          LoggerUtil.d(
              "-------111 ${controller.projectChildrenIndex}  ${controller.tabController.index}");
        }
      });

      return TabBar(
        tabs: tabList,
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
  }

  treeTabContainer(BuildContext context, ProjectController controller) {
    if (controller.projectTreeList.isNotEmpty) {
      List<Widget> warpList = controller.projectTreeList.map((element) {
        return Obx(() {
          return ChoiceChip(
            label: Text(
              element!.name ?? "",
              style: context.bodyText2Style,
            ),
            selectedColor: Colors.lightBlueAccent.withOpacity(0.5),
            selected: controller.tabController.index ==
                controller.projectTreeList.indexOf(element),
            onSelected: (bool newValue) {
              controller.tabController.index =
                  controller.projectTreeList.indexOf(element);
              LoggerUtil.d(
                  "-------555 ${controller.projectChildrenIndex}  ${controller.tabController.index}  ${controller.projectTreeList.indexOf(element)}");
              //关闭弹框
              if (Get.isBottomSheetOpen == true) {
                Get.back();
              }
            },
          );
        });
      }).toList();

      return PreferredSize(
        preferredSize: const Size.fromHeight(36),
        child: Row(
          children: [
            Expanded(
              child: treeTabBar(context, controller),
            ),
            RippleView(
              radius: 100,
              onTap: () {
                LoggerUtil.d(
                    "-------666 ${controller.projectChildrenIndex}  ${controller.tabController.index}");
                // 地不弹出菜单
                Get.bottomSheet(
                  Container(
                    padding: EdgeInsets.all(10.w),
                    child: Wrap(
                      runSpacing: 1.w,
                      spacing: 5.w,
                      children: warpList,
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
        ),
      );
    }
    return null;
  }

  Widget? sliverPageView(BuildContext context, ProjectController controller) {
    if (controller.projectTreeList.isNotEmpty) {
      var pageViewList = controller.projectTreeList
          .map((element) => KeepAliveWrapper(
                child: ProjectTreeChildrenPage(id: element!.id),
              ))
          .toList();

      return TabBarView(
        controller: controller.tabController,
        children: pageViewList,
      );
    }
    return null;
  }
}
