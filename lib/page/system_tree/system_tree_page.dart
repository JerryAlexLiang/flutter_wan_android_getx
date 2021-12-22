import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_wan_android_getx/base/refresh_paging_state_page.dart';
import 'package:flutter_wan_android_getx/page/system_tree/component/tree_chip_wrap.dart';
import 'package:flutter_wan_android_getx/res/strings.dart';
import 'package:flutter_wan_android_getx/widget/custom_app_bar.dart';
import 'package:flutter_wan_android_getx/widget/ripple_view.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:sticky_headers/sticky_headers.dart';
import 'system_tree_controller.dart';
import 'package:flutter_wan_android_getx/theme/app_theme.dart';

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
        centerTitle: StringsConstant.accountTreePage.tr,
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
                  onTap: () => Fluttertoast.showToast(
                      msg: "${controller.treeList[index]!.name}"),
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
        border: Border(
          bottom: BorderSide(width: 1.h),
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
      padding: EdgeInsets.symmetric(
        horizontal: 5.w,
        vertical: 10.h,
      ),
      child: TreeChipWrap(
        chipList: controller.treeList[index]!.children,
        onTap: (model) {
          Fluttertoast.showToast(msg: "${model.name}");
        },
      ),
    );
  }
}
