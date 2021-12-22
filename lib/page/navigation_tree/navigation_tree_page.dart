import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_wan_android_getx/base/common_state_page.dart';
import 'package:flutter_wan_android_getx/model/navigation_model.dart';
import 'package:flutter_wan_android_getx/page/navigation_tree/component/navigation_chip_wrap.dart';
import 'package:flutter_wan_android_getx/res/strings.dart';
import 'package:flutter_wan_android_getx/routes/app_routes.dart';
import 'package:flutter_wan_android_getx/theme/app_theme.dart';
import 'package:flutter_wan_android_getx/utils/logger_util.dart';
import 'package:flutter_wan_android_getx/widget/custom_app_bar.dart';
import 'package:flutter_wan_android_getx/widget/state/load_error_page.dart';
import 'package:flutter_wan_android_getx/widget/state/load_state.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import 'navigation_tree_controller.dart';

/// 类名: navigation_tree_page.dart
/// 创建日期: 12/21/21 on 5:51 PM
/// 描述: 导航页面
/// 作者: 杨亮

class NavigationTreePage extends StatelessWidget {
  const NavigationTreePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<NavigationTreeController>();

    LoggerUtil.d("=======> NavigationTreePage build");

    return Scaffold(
      appBar: CustomAppBar(
        isBack: false,
        showBottomLine: true,
        centerTitle: StringsConstant.navigationPage.tr,
      ),
      body: SafeArea(
        child: CommonStatePage<NavigationTreeController>(
          controller: controller,
          onPressed: () => controller.initNavigationData(),
          child: wanNavigationView(controller),
        ),
      ),
    );
  }

  Widget wanNavigationView(NavigationTreeController controller) {
    return Row(
      children: [
        SizedBox(
          width: 100.w,
          child: leftNavigationGroupView(controller),
        ),
        Expanded(
          child: rightNavigationChildrenView(controller),
        ),
      ],
    );
  }

  Widget leftNavigationGroupView(NavigationTreeController controller) {
    return Obx(() {
      var navigationGroupList = controller.navigationGroupList;
      var currentNavigation = controller.currentNavigation.value;

      var divider = const Divider(
        height: 0,
      );

      return ListView.separated(
        separatorBuilder: (context, index) => divider,
        itemCount: controller.navigationGroupList.length,
        itemBuilder: (context, index) {
          // 当前是否选中
          bool isSelectNavigation =
              navigationGroupList[index]?.cid == currentNavigation?.cid;

          /// 给InkWell内部的组件设置颜色，会导致给InkWell的点击水波纹效果消失，需要在外面套一层Ink或者MMaterial组件
          return Ink(
            color: isSelectNavigation
                ? Colors.white
                : Colors.grey.withOpacity(0.1),
            child: InkWell(
              /// 点击导航item切换当前导航item值currentNavigation
              onTap: () =>
                  controller.changeNavigation(navigationGroupList[index]),
              child: Container(
                height: 40.h,
                alignment: Alignment.center,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // 当前导航选中时显示
                    Visibility(
                      visible: isSelectNavigation,
                      child: Container(
                        width: 2.w,
                        height: 45.h,
                        color: Colors.red,
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: Text(
                          navigationGroupList[index]?.name ?? "",
                          style: TextStyle(
                            color: isSelectNavigation
                                ? Colors.black
                                : context.bodyText2Color,
                            fontSize: isSelectNavigation ? 14 : 12,
                            fontWeight: isSelectNavigation
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    });
  }

  Widget rightNavigationChildrenView(NavigationTreeController controller) {
    return Obx(() {
      var currentNavigation = controller.currentNavigation.value;
      if (currentNavigation == null) {
        return EmptyErrorStatePage(
          loadState: LoadState.empty,
          onTap: () => controller.initNavigationData(),
          errMsg: StringsConstant.noData.tr,
        );
      }

      return Container(
        alignment: Alignment.topLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: ScreenUtil().screenWidth - 60.w,
              padding: EdgeInsets.symmetric(
                horizontal: 8.w,
                vertical: 8.h,
              ),
              // color: Colors.white.withOpacity(0.5),
              child: Text(
                currentNavigation.name ?? "导航",
                style: TextStyle(
                  fontSize: 20.sp,
                  color: Colors.red,
                ),
              ),
            ),
            // 不滚动标题栏，只滚动标签流动布局
            /// Column直接套子组件会超出
            Expanded(
              child: (currentNavigation.articles != null &&
                      currentNavigation.articles!.isNotEmpty)
                  ? SingleChildScrollView(
                      // padding: EdgeInsets.all(5.w),
                      padding: EdgeInsets.only(
                        left: 3.w,
                        right: 1.w,
                        top: 3.h,
                        bottom: 3.h,
                      ),
                      child: articlesWrap(currentNavigation),
                    )
                  : EmptyErrorStatePage(
                      loadState: LoadState.empty,
                      onTap: () => controller.initNavigationData(),
                      errMsg: StringsConstant.noData.tr,
                    ),
            ),
          ],
        ),
      );
    });
  }

  /// 流布局列表
  Widget articlesWrap(NavigationModel model) {
    return NavigationChipWrap(
      chipList: model.articles,
      onTap: (value) => Get.toNamed(
        AppRoutes.articleDetailPage,
        arguments: {
          "data": value,
          "showCollect": true,
        },
      ),
    );
  }
}
