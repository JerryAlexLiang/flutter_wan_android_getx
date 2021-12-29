import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_wan_android_getx/app_user_login_state_controller.dart';
import 'package:flutter_wan_android_getx/constant/constant.dart';
import 'package:flutter_wan_android_getx/model/article_data_model.dart';
import 'package:flutter_wan_android_getx/page/search/article_detail_controller.dart';
import 'package:flutter_wan_android_getx/res/gaps.dart';
import 'package:flutter_wan_android_getx/res/strings.dart';
import 'package:flutter_wan_android_getx/routes/app_routes.dart';
import 'package:flutter_wan_android_getx/theme/app_theme.dart';
import 'package:flutter_wan_android_getx/utils/decoration_style.dart';
import 'package:flutter_wan_android_getx/utils/html_utils.dart';
import 'package:flutter_wan_android_getx/widget/cached_network_image_view.dart';
import 'package:flutter_wan_android_getx/widget/custom_point_widget.dart';
import 'package:flutter_wan_android_getx/widget/ripple_view.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

/// 类名: search_list_item_widget.dart
/// 创建日期: 11/25/21 on 2:38 PM
/// 描述: 搜索结果ListView item Widget
/// 作者: 杨亮

class SearchListItemWidget extends StatelessWidget {
  SearchListItemWidget({
    Key? key,
    required this.dataList,
    required this.index,
  }) : super(key: key);

  final controller = Get.find<ArticleDetailController>();

  /// 文章类表数据源
  final List<ArticleDataModelDatas> dataList;

  /// ListView item index
  final int index;

  @override
  Widget build(BuildContext context) {
    return RippleView(
      onTap: () => Get.toNamed(
        AppRoutes.articleDetailPage,
        arguments: {
          "data": dataList[index],
          "index": index,
          "showCollect": true,
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
            authorShareTime(context),
            Gaps.vGap5,
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: leftContainer(context),
                ),
                Gaps.hGap15,
                rightContainer(),
              ],
            ),
            Gaps.vGap10,
            chapterCollect(context),
          ],
        ),
      ),
    );
  }

  Widget leftContainer(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: titleDesc(context),
    );
  }

  /// 图片
  /// CachedNetworkImage可以直接使用或通过ImageProvider使用。
  /// CachedNetworkImage作为CachedNetworkImageProvider对Web的支持最小。它目前不包括缓存
  Widget rightContainer() {
    return CachedNetworkImageView(
      visible: (dataList[index].envelopePic != null &&
              dataList[index].envelopePic!.isNotEmpty)
          ? true
          : false,
      borderRadius: 6,
      imageUrl: dataList[index].envelopePic ?? Constant.defaultImageUrlVertical,
      // 测试errorWidget效果
      // imageUrl: Constant.placeHolderImageUrl.replaceFirst(RegExp('size1'), '100x120'),
      width: 90,
      height: 130,
      fit: BoxFit.cover,
      // isCircle: true,
      borderColor: Colors.red.withOpacity(0.2),
      borderWidth: 1,
    );
  }

  /// 作者、时间
  Widget authorShareTime(BuildContext context) {
    return Row(
      children: [
        refreshTag(context),
        chapterTag(context),
        author(context),
        const Spacer(),
        niceDate(context),
      ],
    );
  }

  /// 新
  Widget refreshTag(BuildContext context) {
    return Visibility(
      visible: dataList[index].fresh ?? false,
      child: Container(
        margin: const EdgeInsets.only(right: 10),
        padding: const EdgeInsets.symmetric(
          horizontal: 3,
          vertical: 2,
        ),
        decoration: DecorationStyle.imageDecorationCircle(
          color: Colors.red,
          borderRadius: 3,
        ),
        child: Text(
          StringsConstant.freshTag.tr,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 10,
          ),
        ),
      ),
    );
  }

  /// tags
  Widget chapterTag(BuildContext context) {
    return Visibility(
      visible:
          (dataList[index].tags != null && dataList[index].tags!.isNotEmpty)
              ? true
              : false,
      child: Container(
        margin: const EdgeInsets.only(right: 10),
        padding: const EdgeInsets.symmetric(
          horizontal: 3,
          vertical: 2,
        ),
        decoration: DecorationStyle.imageDecorationCircle(
          color: Colors.blueAccent,
          borderRadius: 3,
        ),
        child: Text(
          (dataList[index].tags != null && dataList[index].tags!.isNotEmpty)
              ? dataList[index].tags![0].name!
              : "",
          style: const TextStyle(
            color: Colors.white,
            fontSize: 10,
          ),
        ),
      ),
    );
  }

  /// 作者、分享者
  Widget author(BuildContext context) {
    String value = '';
    if (dataList[index].author != null) {
      if (dataList[index].author!.isNotEmpty) {
        value = dataList[index].author!;
      } else {
        if (dataList[index].shareUser != null) {
          if (dataList[index].shareUser!.isNotEmpty) {
            value = dataList[index].shareUser!;
          }
        }
      }
    }
    return Row(
      children: [
        const Icon(
          Icons.person_outline,
          size: 15,
          color: Colors.grey,
        ),
        Gaps.hGap5,
        Text(
          value,
          style: context.bodyText2Style?.copyWith(
            fontSize: 12,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

  /// 时间、分享时间
  Widget niceDate(BuildContext context) {
    return Row(
      children: [
        const Icon(
          Icons.access_time,
          size: 15,
          color: Colors.grey,
        ),
        Gaps.hGap5,
        Text(
          dataList[index].niceDate ?? (dataList[index].niceShareDate ?? ""),
          style: context.bodyText2Style?.copyWith(
            fontSize: 12,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

  /// 标题、描述
  Widget titleDesc(BuildContext context) {
    return Column(
      children: [
        Visibility(
          visible: dataList[index].title!.isNotEmpty ? true : false,
          // child: Text(
          //   model?.title ?? "",
          //   style: context.bodyText1Style?.copyWith(
          //     fontSize: 15,
          //   ),
          // ),
          child: Html(
            data: HtmlUtils.html2HighLight(
              html: dataList[index].title!,
              // color: 'yellow',
            ),
            style: {
              'font': Style(
                fontSize: const FontSize(15),
                fontWeight: FontWeight.w500,
              ),
            },
          ),
        ),
        Visibility(
          visible: dataList[index].desc!.isNotEmpty ? true : false,
          child: Column(
            children: [
              Gaps.vGap8,
              Text(
                dataList[index].desc ?? "",
                style: context.bodyText2Style?.copyWith(
                  fontSize: 13,
                  color: Colors.grey,
                ),
                maxLines: 5,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// 分类、是否收藏
  Widget chapterCollect(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 3,
            vertical: 2,
          ),
          decoration: DecorationStyle.imageDecorationCircle(
            color: Colors.greenAccent,
            borderRadius: 3,
          ),
          child: Text(
            dataList[index].superChapterName!,
            style: context.bodyText2Style?.copyWith(
              fontSize: 12,
              color: Colors.white,
            ),
          ),
        ),
        //  Container(
        //   alignment: Alignment.center,
        //   height: 15,
        //   child:  const VerticalDivider(
        //     width: 10,
        //     thickness: 1,
        //     color: Colors.blue,
        //   ),
        // ),
        const CustomPointWidget(
          thickness: 3,
          color: Colors.red,
        ),

        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 3,
            vertical: 2,
          ),
          decoration: DecorationStyle.imageDecorationCircle(
            color: Colors.pinkAccent,
            borderRadius: 3,
          ),
          child: Text(
            dataList[index].chapterName!,
            style: context.bodyText2Style?.copyWith(
              fontSize: 12,
              color: Colors.white,
            ),
          ),
        ),

        const Spacer(),
        RippleView(
          onTap: () => {
            controller.collectInsideArticle(dataList[index]),
          },
          radius: 50,
          child: Container(
            margin: const EdgeInsets.all(10),
            child: Obx(() {
              return Icon(
                Icons.favorite,
                // color: dataList[index].isCollect
                //     ? Colors.red
                //     : Colors.grey.withOpacity(0.5),
                color: loginState
                    ? (dataList[index].isCollect
                        ? Colors.red
                        : Colors.grey.withOpacity(0.5))
                    : Colors.grey.withOpacity(0.5),
              );
            }),
          ),
        ),
      ],
    );
  }
}
