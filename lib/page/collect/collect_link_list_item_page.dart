import 'package:flutter/material.dart';
import 'package:flutter_wan_android_getx/model/article_data_model.dart';
import 'package:flutter_wan_android_getx/model/collect_link_model.dart';
import 'package:flutter_wan_android_getx/res/gaps.dart';
import 'package:flutter_wan_android_getx/routes/app_routes.dart';
import 'package:flutter_wan_android_getx/utils/decoration_style.dart';
import 'package:flutter_wan_android_getx/widget/ripple_view.dart';
import 'package:get/get.dart';
import 'package:flutter_wan_android_getx/theme/app_theme.dart';

/// 类名: collect_link_list_item_page.dart
/// 创建日期: 2/21/22 on 6:09 PM
/// 描述: 我的收藏-网页收藏列表Item
/// 作者: 杨亮

class CollectLinkListItemPage extends StatelessWidget {
  const CollectLinkListItemPage({
    Key? key,
    required this.dataList,
    required this.index,
    required this.onUnCollectLinkUrl,
  }) : super(key: key);

  // 收藏网址数据源列表
  final List<CollectLinkModel> dataList;

  final int index;

  /// 取消收藏网址点击事件回调
  final Function(int index) onUnCollectLinkUrl;

  @override
  Widget build(BuildContext context) {
    return RippleView(
      onTap: () => Get.toNamed(
        AppRoutes.webDetailCommonPage,
        arguments: {
          "data": dataList[index],
          "index": index,
        },
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 10,
        ),
        margin: const EdgeInsets.symmetric(horizontal: 10),
        decoration: DecorationStyle.imageDecorationCircle(
          borderBottom: true,
          borderColor: Colors.grey,
        ),
        child: Column(
          children: [
            // 收藏网址标题
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(
                  Icons.description_outlined,
                  size: 20,
                ),
                Gaps.hGap8,
                Expanded(
                  child: Text(
                    dataList[index].name ?? "致一科技",
                    style: context.bodyText1Style?.copyWith(
                      fontSize: 15,
                      fontWeight: FontWeight.normal,
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            Gaps.vGap10,
            // 收藏网址地址
            Row(
              children: [
                const Icon(
                  Icons.link,
                  size: 20,
                ),
                Gaps.hGap8,
                Expanded(
                  child: Text(
                    dataList[index].link ?? "收藏网址",
                    style: context.bodyText2Style?.copyWith(
                      fontSize: 13,
                      color: Colors.grey,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
