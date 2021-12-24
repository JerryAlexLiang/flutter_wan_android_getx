import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_wan_android_getx/constant/constant.dart';
import 'package:flutter_wan_android_getx/model/article_data_model.dart';
import 'package:flutter_wan_android_getx/page/search/article_detail_controller.dart';
import 'package:flutter_wan_android_getx/res/r.dart';
import 'package:flutter_wan_android_getx/res/strings.dart';
import 'package:flutter_wan_android_getx/theme/app_theme.dart';
import 'package:flutter_wan_android_getx/utils/logger_util.dart';
import 'package:flutter_wan_android_getx/widget/article_detail_app_bar_add_menu.dart';
import 'package:flutter_wan_android_getx/widget/cached_network_image_view.dart';
import 'package:flutter_wan_android_getx/widget/popup_window_widget.dart';
import 'package:flutter_wan_android_getx/widget/ripple_view.dart';
import 'package:get/get.dart';

/// 类名: article_detail_web_app_bar.dart
/// 创建日期: 12/2/21 on 3:47 PM
/// 描述: 文章详情WebView页面 通用标题栏
/// 左右边距12
/// 作者: 杨亮

class ArticleDetailWebAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  ArticleDetailWebAppBar({
    Key? key,
    required this.model,
    required this.showCollect,
    this.opacity = 1.0,
    this.appBarHeight = 56.0,
    this.backgroundColor,
    this.showBottomLine = false,
    this.bottomLineHeight = 0.6,
    this.bottomLineColor,
  }) : super(key: key);

  final ArticleDataModelDatas model;
  final bool showCollect;
  final double opacity;
  final double appBarHeight;
  final Color? backgroundColor;

  /// 是否显示下划线
  final bool showBottomLine;
  final double bottomLineHeight;
  final Color? bottomLineColor;

  // final VoidCallback? onLeftPressed;
  // final VoidCallback? onLeft2Pressed;
  // final VoidCallback? onRightPressed;
  // final VoidCallback? onRight2Pressed;

  // GlobalKey能够跨Widget访问状态
  // 定义了一个GlobalKey并传递给Widget1，然后我们便可以通过这个key拿到它所绑定的SwitcherWidgetState并在外部调用SwitcherWidgetState的changeState方法改变状态了
  final GlobalKey _addKey = GlobalKey();

  final detailController = Get.find<ArticleDetailController>();

  @override
  Widget build(BuildContext context) {
    final Color _backgroundColor =
        backgroundColor ?? context.appBarBackgroundColor!;

    final SystemUiOverlayStyle _overlayStyle =
        ThemeData.estimateBrightnessForColor(_backgroundColor) ==
                Brightness.dark
            ? SystemUiOverlayStyle.light
            : SystemUiOverlayStyle.dark;

    LoggerUtil.d("=======<>3  ${model.toJson()}");

    return Opacity(
      opacity: opacity,
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: _overlayStyle,
        child: Material(
          color: _backgroundColor,
          child: SafeArea(
            child: Container(
              height: appBarHeight,
              decoration: BoxDecoration(
                /// 使用装饰器设置是否显示下划线
                border: Border(
                  bottom: showBottomLine
                      ? Divider.createBorderSide(context,
                          width: bottomLineHeight, color: bottomLineColor)
                      : Divider.createBorderSide(context,
                          width: 0.0, color: Colors.transparent),
                ),
              ),
              child: Row(
                children: [
                  backWidget(context),
                  titleWidget(context),
                  const Spacer(),
                  rightWidget(context, model),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(appBarHeight);

  Widget backWidget(BuildContext context) {
    return Row(
      children: [
        Container(
          margin: const EdgeInsets.only(left: 2),
          child: RippleView(
            radius: 100,
            onTap: () async {
              await detailController.webViewController.canGoBack()
                  ? detailController.webViewController.goBack()
                  : {
                      Get.back(),
                      // 恢复第一次进入标志
                      detailController.isFirstInitWeb = true,
                    };
            },
            child: Container(
              padding: const EdgeInsets.all(10),
              child: Image.asset(
                'images/ic_back_black.png',
                width: 24,
                height: 24,
                color: context.appBarIconColor,
              ),
            ),
          ),
        ),
        Obx(() {
          return Visibility(
            // visible: detailController.isFirstInitWeb == true ? false : true,
            visible: !detailController.isFirstInitWeb,
            child: Container(
              // decoration: BoxDecoration(
              //     borderRadius: BorderRadius.circular(100),
              //     color: Colors.red.withOpacity(0.1)),
              child: RippleView(
                radius: 100,
                onTap: () => {
                  Get.back(),
                },
                child: Container(
                  padding: const EdgeInsets.all(10),
                  child: Icon(
                    Icons.close_outlined,
                    color: context.appBarIconColor,
                  ),
                ),
              ),
            ),
          );
        }),
      ],
    );
  }

  Widget titleWidget(BuildContext context) {
    String? name;
    if (model.author != null) {
      if (model.author!.isNotEmpty) {
        name = model.author!;
      } else if (model.shareUser != null) {
        if (model.shareUser!.isNotEmpty) {
          name = model.shareUser!;
        }
      }
    }

    return Container(
      margin: const EdgeInsets.only(left: 15),
      child: Row(
        children: [
          const CachedNetworkImageView(
            visible: true,
            isCircle: true,
            imageUrl: Constant.defaultImageUrlHorizontal,
            fit: BoxFit.cover,
            width: 30,
            height: 30,
          ),
          Container(
            margin: const EdgeInsets.only(left: 15),
            child: Text(
              name ?? StringsConstant.myCompany.tr,
              style: context.bodyText2Style,
            ),
          ),
        ],
      ),
    );
  }

  Widget rightWidget(BuildContext context, ArticleDataModelDatas model) {
    return Container(
      margin: const EdgeInsets.only(right: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Visibility(
            visible: showCollect,
            child: RippleView(
              radius: 100,
              onTap: () => detailController.collectInsideArticle(model),
              child: Container(
                padding: const EdgeInsets.all(5),
                child: Obx(() {
                  return Icon(
                    Icons.favorite,
                    size: 24,
                    color: model.isCollect
                        ? Colors.red
                        : Colors.grey.withOpacity(0.5),
                  );
                }),
              ),
            ),
          ),
          RippleView(
            key: _addKey,
            radius: 100,
            onTap: () => showAddMenu(context, model),
            child: Container(
              padding: const EdgeInsets.all(10),
              child: SvgPicture.asset(
                R.assetsSvgShare,
                width: 24,
                height: 24,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void showAddMenu(BuildContext context, ArticleDataModelDatas model) {
    final RenderBox button =
        _addKey.currentContext!.findRenderObject()! as RenderBox;

    showPopupWindow<void>(
      context: context,
      isShowBg: false,
      offset: Offset(button.size.width - 8.0, 0),
      anchor: button,
      child: ArticleDetailAppBarAddMenu(model: model),
    );
  }
}
