import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_wan_android_getx/base/refresh_paging_state_page.dart';
import 'package:flutter_wan_android_getx/model/tree_model.dart';
import 'package:flutter_wan_android_getx/page/system_tree/component/tree_chip_wrap.dart';
import 'package:flutter_wan_android_getx/res/strings.dart';
import 'package:flutter_wan_android_getx/routes/app_routes.dart';
import 'package:flutter_wan_android_getx/theme/app_theme.dart';
import 'package:flutter_wan_android_getx/widget/custom_app_bar.dart';
import 'package:flutter_wan_android_getx/widget/ripple_view.dart';
import 'package:get/get.dart';
import 'package:sticky_headers/sticky_headers.dart';

import 'system_tree_controller.dart';

/// 类名: system_tree_page.dart
/// 创建日期: 12/22/21 on 6:01 PM
/// 描述: 体系列表
/// 作者: 杨亮

class SystemTreePage extends StatelessWidget {
  const SystemTreePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SystemTreeController>();

    return Scaffold(
      appBar: CustomAppBar(
        isBack: false,
        showBottomLine: true,
        centerTitle: StringsConstant.accountTreePage.tr,
        actionIcon: const Icon(Icons.search),
        onRightPressed: () => Get.toNamed(AppRoutes.searchPage),
      ),
      body: SafeArea(
        child: Obx(() {
          return RefreshPagingStatePage<SystemTreeController>(
            controller: controller,
            onPressed: () => controller.initSystemTreeData(),
            refreshController: controller.refreshController,
            enableRefreshPullUp: false,
            onRefresh: () => controller.initSystemTreeData(),
            child: ListView.builder(
              itemCount: controller.treeList.length,
              itemBuilder: (context, index) {
                /// 列表悬浮头
                return RippleView(
                  onTap: () => Get.toNamed(
                    AppRoutes.treeTabContainerPage,
                    arguments: {
                      "treeModel": controller.treeList[index],
                      "treeModelIndex": 0,
                    },
                  ),
                  child: StickyHeader(
                    header: treeListItemHeader(context, controller, index),
                    content: treeListItemContent(context, controller, index),
                  ),
                );
              },
            ),
          );
        }),
      ),
    );
  }

  /// 头部组件
  Widget treeListItemHeader(
      BuildContext context, SystemTreeController controller, int index) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.symmetric(
        horizontal: 10.w,
        vertical: 10.h,
      ),
      decoration: BoxDecoration(
        color: context.backgroundColor,
        border: const Border(
          bottom: BorderSide(width: 0.1, color: Colors.grey),
        ),
      ),
      child: Text(
        controller.treeList[index]!.name ?? "体系",
        style: context.bodyText1Style?.copyWith(
          fontSize: 20.sp,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  /// 子组件
  Widget treeListItemContent(
      BuildContext context, SystemTreeController controller, int index) {
    return Container(
      width: Get.width,
      padding: EdgeInsets.symmetric(
        horizontal: 5.w,
        vertical: 10.h,
      ),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 0.2, color: Colors.grey),
        ),
      ),
      child: TreeChipWrap(
        chipList: controller.treeList[index]!.children,
        onTap: (Children value, int treeModelIndex) => Get.toNamed(
          AppRoutes.treeTabContainerPage,
          arguments: {
            "treeModel": controller.treeList[index],
            "treeModelIndex": treeModelIndex,
          },
        ),
      ),
    );
  }
}
