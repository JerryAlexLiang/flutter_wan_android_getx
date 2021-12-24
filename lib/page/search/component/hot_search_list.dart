import 'package:flutter/material.dart';
import 'package:flutter_wan_android_getx/page/search/component/chip_search_wrap.dart';
import 'package:flutter_wan_android_getx/page/search/search_controller.dart';
import 'package:flutter_wan_android_getx/res/gaps.dart';
import 'package:flutter_wan_android_getx/res/strings.dart';
import 'package:flutter_wan_android_getx/utils/logger_util.dart';
import 'package:flutter_wan_android_getx/widget/ripple_view.dart';
import 'package:get/get.dart';

/// 类名: hot_search_list.dart
/// 创建日期: 11/10/21 on 3:21 PM
/// 描述: 热门搜索
/// 作者: 杨亮

class HotSearchList extends StatelessWidget {
  HotSearchList({Key? key}) : super(key: key);

  final controller = Get.find<SearchController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      //热门搜索列表
      var hotKeys = controller.hotKeys;
      if (hotKeys.isNotEmpty) {
        var hotNameList = hotKeys.map((e) => e.name).toList();
        LoggerUtil.d(
            "======> HotSearchList  ${hotNameList.map((e) => e.toString()).toList()}");

        Widget widget;
        controller.showHotKeys == true
            ? widget = ChipSearchWrap(
                isShow: controller.showHotKeys,
                title: StringsConstant.hotSearch.tr,
                searchChipType: SearchChipType.hot,
                chipNameList: hotNameList,
                onTap: (String value) {
                  // 点击Chip热词或者搜索历史某一项词条进行搜索
                  controller.tagSearchChipSearch(value);
                },
                onRightTap: () {
                  //节省流量，只设置点击不可见热词，不重新请求数据
                  controller.showHotKeys = false;
                },
              )
            : widget = Container(
                alignment: Alignment.topCenter,
                child: RippleView(
                  radius: 20,
                  //节省流量，只设置点击不可见热词，不重新请求数据
                  onTap: () => controller.showHotKeys = true,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.visibility_rounded,
                          size: 18,
                        ),
                        Gaps.hGap5,
                        Text(StringsConstant.seeAllRecommends.tr),
                      ],
                    ),
                  ),
                ),
              );

        return widget;
      } else {
        return Gaps.empty;
      }
    });
  }
}
