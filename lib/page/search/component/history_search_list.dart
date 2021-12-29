import 'package:flutter/material.dart';
import 'package:flutter_wan_android_getx/page/search/component/chip_search_wrap.dart';
import 'package:flutter_wan_android_getx/page/search/search_controller.dart';
import 'package:flutter_wan_android_getx/res/strings.dart';
import 'package:get/get.dart';

/// 类名: history_search_list.dart
/// 创建日期: 11/15/21 on 2:56 PM
/// 描述: 本地存储历史搜索记录列表
/// 作者: 杨亮

class HistorySearchList extends StatelessWidget {
  HistorySearchList({Key? key}) : super(key: key);

  final controller = Get.find<SearchController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return historyView();
    });
  }

  /// 历史搜索组件
  Widget historyView() {
    return ChipSearchWrap(
      isShow: controller.showHistoryKeys,
      searchChipType: SearchChipType.history,
      chipNameList: controller.historyKeys,
      title: StringsConstant.searchHistory.tr,
      subTitle: StringsConstant.searchHistoryLimit.tr,
      onTap: (value) {
        // 点击Chip热词或者搜索历史某一项词条进行搜索
        controller.tagSearchChipSearch(value);
      },
      onRightTap: () {
        // 删除本地存储历史搜索记录
        // controller.clearSearchHistory();

        Get.defaultDialog(
          title: StringsConstant.alertContent.tr,
          content: Text(StringsConstant.deleteSearchHistoryAlertContent.tr),
          textCancel: StringsConstant.cancel.tr,
          textConfirm: StringsConstant.confirm.tr,
          onCancel: () {},
          onConfirm: () {
            controller.clearSearchHistory();
            if (Get.isDialogOpen!) {
              Get.back();
            }
          },
        );
      },
    );
  }
}
