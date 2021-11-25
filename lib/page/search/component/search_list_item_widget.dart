import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wan_android_getx/constant/constant.dart';
import 'package:flutter_wan_android_getx/model/article_data_model.dart';
import 'package:flutter_wan_android_getx/widget/cached_network_image_view.dart';
import 'package:flutter_wan_android_getx/widget/ripple_view.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// 类名: search_list_item_widget.dart
/// 创建日期: 11/25/21 on 2:38 PM
/// 描述: 搜索结果ListView item Widget
/// 作者: 杨亮

class SearchListItemWidget extends StatelessWidget {
  const SearchListItemWidget({Key? key, required this.model}) : super(key: key);

  final ArticleDataModelDatas? model;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: model != null ? true : false,
      child: RippleView(
        onTap: () => Fluttertoast.showToast(msg: model?.title ?? ""),
        child: Container(
          padding: const EdgeInsets.symmetric(
            vertical: 5,
            horizontal: 10,
          ),
          child: Row(
            children: [
              Expanded(
                child: leftContainer(),
              ),
              rightContainer(),
            ],
          ),
        ),
      ),
    );
  }

  Widget leftContainer() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('1'),
        Text('2'),
        Text('3'),
        Text('4'),
      ],
    );
  }

  /// 图片
  /// CachedNetworkImage可以直接使用或通过ImageProvider使用。
  /// CachedNetworkImage作为CachedNetworkImageProvider对Web的支持最小。它目前不包括缓存
  Widget rightContainer() {
    // return Visibility(
    //   visible: (model!.envelopePic != null && model!.envelopePic!.isNotEmpty) ? true : false,
    //   child: ClipRRect(
    //     borderRadius: BorderRadius.circular(10),
    //     child: CachedNetworkImage(
    //       // imageUrl: model!.envelopePic!,
    //       imageUrl: model!.envelopePic ?? Constant.defaultImageUrlVertical,
    //       fit: BoxFit.cover,
    //       width: 100.w,
    //       height: 120.h,
    //       placeholder: (context, url) {
    //         //PhysicalModel ，主要的功能就是设置widget四边圆角，可以设置阴影颜色，和z轴高度
    //         return PhysicalModel(
    //           color: Colors.grey.withOpacity(0.3),
    //           borderRadius: BorderRadius.circular(10),
    //           clipBehavior: Clip.antiAlias,
    //           child: SizedBox(
    //             width: 100.w,
    //             height: 120.h,
    //             child: const Center(
    //               child: CupertinoActivityIndicator(),
    //             ),
    //           ),
    //         );
    //       },
    //     ),
    //   ),
    // );
    return CachedNetworkImageView(
      visible: (model!.envelopePic != null && model!.envelopePic!.isNotEmpty)
          ? true
          : false,
      borderRadius: 10,
      imageUrl: model!.envelopePic ?? Constant.defaultImageUrlVertical,
      width: 100.w,
      height: 120.h,
      fit: BoxFit.cover,
      // borderColor: Colors.red,
      // borderWidth: 1,
    );
  }
}
