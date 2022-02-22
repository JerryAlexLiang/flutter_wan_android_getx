import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_wan_android_getx/page/collect/collect_article_list/collect_article_list_page.dart';
import 'package:flutter_wan_android_getx/page/collect/collect_link_list/collect_link_list_page.dart';
import 'package:flutter_wan_android_getx/res/gaps.dart';
import 'package:flutter_wan_android_getx/theme/app_theme.dart';
import 'package:flutter_wan_android_getx/widget/custom_underline_tabIndicator.dart';
import 'package:flutter_wan_android_getx/widget/keep_alive_wrapper.dart';
import 'package:get/get.dart';

import 'collect_controller.dart';

/// 类名: collect_page.dart
/// 创建日期: 2/17/22 on 10:48 AM
/// 描述: 收藏界面
/// 作者: 杨亮

class CollectPage extends StatelessWidget {
  const CollectPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CollectController>();

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

    final Color _backgroundColor = context.appBarBackgroundColor!;

    final SystemUiOverlayStyle _overlayStyle =
        ThemeData.estimateBrightnessForColor(_backgroundColor) ==
                Brightness.dark
            ? SystemUiOverlayStyle.light
            : SystemUiOverlayStyle.dark;

    //Expanded(
    //                     flex: 1,
    //                     child: backWidget(context),
    //                   ),
    //                   Expanded(
    //                     flex: 5,
    //                     child: titleWidget(context),
    //                   ),
    //                   Expanded(
    //                     flex: 1,
    //                     child: rightWidget(context),
    //                   ),

    return DefaultTabController(
      length: controller.collectTypeList.length,
      initialIndex: 0,
      child: Scaffold(
        appBar: PreferredSize(
          child: AnnotatedRegion<SystemUiOverlayStyle>(
            value: _overlayStyle,
            child: SafeArea(
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      alignment: Alignment.centerLeft,
                      child: IconButton(
                        onPressed: () => Get.back(),
                        padding: const EdgeInsets.all(12.0),
                        icon: Image.asset(
                          'images/ic_back_black.png',
                          color: context.appBarIconColor,
                        ),
                      ),
                    ),
                    flex: 1,
                  ),
                  TabBar(
                    isScrollable: true,
                    indicatorColor: Colors.red,
                    indicatorSize: TabBarIndicatorSize.label,
                    indicatorWeight: 0,
                    // 自定义indicator指示器
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
                    tabs: controller.collectTypeList
                        .map((e) => Tab(
                              text: e,
                            ))
                        .toList(),
                  ),
                  const Expanded(
                    child: Gaps.empty,
                    flex: 1,
                  ),
                ],
              ),
            ),
          ),
          preferredSize: const Size.fromHeight(48),
        ),
        body: const TabBarView(
          children: [
            KeepAliveWrapper(
              // 收藏文章列表
              child: CollectArticleListPage(),
            ),
            KeepAliveWrapper(
              // 网址收藏列表
              child: CollectLinkListPage(),
            ),
          ],
        ),
      ),
    );
  }
}
