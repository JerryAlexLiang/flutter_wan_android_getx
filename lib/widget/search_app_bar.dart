import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_wan_android_getx/res/gaps.dart';
import 'package:flutter_wan_android_getx/theme/app_theme.dart';

/// 自定义搜索栏 - AppBar
/// 说明：
/// 1、Widget属性icon 优先于String类型的image生效，imageColor只对image生效
/// 2、右侧Widget,actionName属性优先于actionIcon和actionImage生效；

class SearchAppBar extends StatelessWidget implements PreferredSizeWidget {
  const SearchAppBar({
    Key? key,
    this.appBarHeight = 56.0,
    this.backgroundColor,
    this.opacity = 1.0,
    this.showBottomLine = false,
    this.bottomLineHeight = 0.6,
    this.bottomLineColor,
    this.showLeft = false,
    this.backImg = 'images/ic_back_black.png',
    this.backIcon,
    this.leftName = '',
    this.leftPadding,
    this.leftNameStyle,
    this.onLeftPressed,
    this.backImageColor,
    this.actionName = '',
    this.actionNameStyle,
    this.actionIcon,
    this.actionImage,
    this.actionBgColor,
    this.onRightPressed,
    required this.searchInput,
    this.showRight = false,
    this.rightPadding,
  }) : super(key: key);

  final double appBarHeight;
  final Color? backgroundColor;
  final double opacity;

  /// 是否显示下划线
  final bool showBottomLine;
  final double bottomLineHeight;
  final Color? bottomLineColor;

  final bool showLeft;
  final String backImg;
  final Widget? backIcon;
  final Color? backImageColor;
  final String leftName;
  final EdgeInsetsGeometry? leftPadding;
  final TextStyle? leftNameStyle;
  final VoidCallback? onLeftPressed;

  final Widget searchInput;

  final bool showRight;
  final String actionName;
  final TextStyle? actionNameStyle;
  final EdgeInsetsGeometry? rightPadding;
  final Widget? actionIcon;
  final String? actionImage;
  final Color? actionBgColor;
  final VoidCallback? onRightPressed;

  @override
  Widget build(BuildContext context) {
    // /// 显示状态栏
    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
    //     overlays: [SystemUiOverlay.top]);

    // /// 隐藏状态栏
    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);

    final Color _backgroundColor =
        backgroundColor ?? context.appBarBackgroundColor!;

    final SystemUiOverlayStyle _overlayStyle =
        ThemeData.estimateBrightnessForColor(_backgroundColor) ==
                Brightness.dark
            ? SystemUiOverlayStyle.light
            : SystemUiOverlayStyle.dark;

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
                  Expanded(
                    child: searchInput,
                  ),
                  rightWidget(context)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  //AppBar需要实现PreferredSizeWidget
  Size get preferredSize => Size.fromHeight(appBarHeight);

  Widget backWidget(BuildContext context) {
    Widget leftWidget = leftName.isNotEmpty
        ? Container(
            alignment: Alignment.center,
            padding: leftPadding ?? const EdgeInsets.symmetric(horizontal: 5),
            child: Text(
              leftName,
              style: leftNameStyle,
            ),
          )
        : IconButton(
            onPressed: () async {
              // FocusManager.instance.primaryFocus?.unfocus();
              // // bool isBack = await navigator!.maybePop();
              // // if (isBack) {
              // //   Get.back();
              // // }
              // Get.back(canPop: true);

              if (onLeftPressed != null) {
                onLeftPressed!();
              }
            },
            tooltip: 'Back',
            padding: const EdgeInsets.all(12.0),
            icon: backIcon ??
                Image.asset(
                  backImg,
                  color: backImageColor ?? context.appBarIconColor,
                ),
          );

    final Widget widget = showLeft ? leftWidget : Gaps.hGap16;

    return Container(
      alignment: Alignment.centerLeft,
      child: widget,
    );
  }

  Widget rightWidget(BuildContext context) {
    TextStyle? textStyle = TextStyle(
        color: actionBgColor ?? context.subtitle2Color,
        fontSize: context.subtitle2Style?.fontSize);

    Widget rightWidget = actionName.isNotEmpty
        ? TextButton(
            onPressed: onRightPressed,
            child: Text(
              actionName,
              style: actionNameStyle ?? textStyle,
            ),
          )
        : IconButton(
            padding: const EdgeInsets.all(12.0),
            onPressed: onRightPressed,
            icon: actionIcon ??
                (actionImage != null
                    ? Image.asset(
                        actionImage!,
                        color: actionBgColor,
                      )
                    : Gaps.empty),
          );

    Widget widget = showRight ? rightWidget : Gaps.hGap16;

    return Container(
      padding: rightPadding,
      alignment: Alignment.centerRight,
      child: widget,
    );
  }
}
