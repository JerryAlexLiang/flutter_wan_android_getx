import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_wan_android_getx/base/refresh_paging_state_page.dart';
import 'package:flutter_wan_android_getx/page/collect/collect_link_list_item_page.dart';
import 'package:flutter_wan_android_getx/widget/state/favorite_lottie_widget.dart';
import 'package:flutter_wan_android_getx/widget/state/loading_lottie_rocket_widget.dart';
import 'package:get/get.dart';

import 'collect_link_list_controller.dart';

/// 类名: collect_link_list_page.dart
/// 创建日期: 2/21/22 on 6:03 PM
/// 描述:  我的收藏页 - 网址收藏列表
/// 作者: 杨亮

class CollectLinkListPage extends StatelessWidget {
  const CollectLinkListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CollectLinkListController>();

    return Scaffold(
      body: Obx(() {
        return Stack(
          alignment: Alignment.center,
          children: [
            RefreshPagingStatePage<CollectLinkListController>(
              controller: controller,
              enableRefreshPullDown: true,
              enableRefreshPullUp: false,
              refreshController: controller.refreshController,
              onPressed: () => controller.onFirstInRequestData(),
              onRefresh: () => controller.onRefreshRequestData(),
              child: ListView.builder(
                itemCount: controller.collectLinkList.length,
                itemBuilder: (context, index) {
                  // return CollectLinkListItemPage(
                  //   dataList: controller.collectLinkList,
                  //   index: index,
                  //   onUnCollectLinkUrl: (int index) {
                  //     controller.requestUnCollectLink(
                  //         controller.collectLinkList[index]);
                  //   },
                  // );

                  return Slidable(
                    // Specify a key if the Slidable is dismissible. 如果可滑动的是可撤销的，请指定一个键。
                    key: Key(index.toString()),
                    closeOnScroll: true,
                    // The start action pane is the one at the left or the top side. 开始操作窗格位于左侧或顶部。
                    // startActionPane: ActionPane(
                    endActionPane: ActionPane(
                      // A motion is a widget used to control how the pane animates. 一个运动是一个小部件，用来控制面板如何动画
                      motion: const ScrollMotion(),
                      // A pane can dismiss the Slidable. 一个窗格可以解散可滑动
                      // dismissible: DismissiblePane(onDismissed: () {}),
                      // All actions are defined in the children parameter. 所有操作都在children参数中定义。
                      children: [
                        SlidableAction(
                          onPressed: (context) =>
                              controller.requestUnCollectLink(
                                  model: controller.collectLinkList[index]),
                          label: "取消收藏",
                          icon: Icons.delete,
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                        ),
                      ],
                    ),
                    child: CollectLinkListItemPage(
                      dataList: controller.collectLinkList,
                      index: index,
                      onUnCollectLinkUrl: (int index) {
                        controller.requestUnCollectLink(
                            model: controller.collectLinkList[index]);
                      },
                    ),
                  );
                },
              ),
            ),

            /// 收藏动画
            Positioned(
              top: Get.height / 5,
              left: 0,
              right: 0,
              child: FavoriteLottieWidget(
                visible: controller.collectAnimation,
                animate: controller.collectAnimation,
                repeat: false,
                width: Get.width,
                height: Get.height / 3,
              ),
            ),

            /// 取消收藏动画
            Positioned(
              top: Get.height / 5,
              left: 0,
              right: 0,
              child: LoadingLottieRocketWidget(
                visible: controller.unCollectAnimation,
                animate: controller.unCollectAnimation,
                repeat: false,
                width: Get.width,
                height: Get.height / 3,
              ),
            ),
          ],
        );
      }),
    );
  }
}
