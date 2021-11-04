import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_wan_android_getx/res/gaps.dart';
import 'package:flutter_wan_android_getx/theme/app_theme.dart';
import 'package:get/get.dart';

/// 自定义AppBar
/// 说明：
/// 1、Widget属性icon 优先于String类型的image生效，imageColor只对image生效
/// 2、右侧Widget,actionName属性优先于actionIcon和actionImage生效；

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    Key? key,
    this.appBarHeight = 56.0,
    this.backgroundColor,
    this.title = '',
    this.centerTitle = '',
    this.backImg = 'images/ic_back_black.png',
    this.backIcon,
    this.backImageColor,
    this.actionName = '',
    this.actionNameStyle,
    this.actionIcon,
    this.actionImage,
    this.actionImageColor,
    this.onRightPressed,
    this.isBack = true,
    this.showBottomLine = false,
    this.bottomLineHeight = 0.6,
    this.bottomLineColor,
  }) : super(key: key);

  final double appBarHeight;
  final Color? backgroundColor;
  final String title;
  final String centerTitle;
  final String backImg;
  final Widget? backIcon;
  final Color? backImageColor;
  final String actionName;
  final TextStyle? actionNameStyle;
  final Widget? actionIcon;
  final String? actionImage;
  final Color? actionImageColor;
  final VoidCallback? onRightPressed;
  final bool isBack;

  /// 是否显示下划线
  final bool showBottomLine;
  final double bottomLineHeight;
  final Color? bottomLineColor;

  @override
  Widget build(BuildContext context) {
    final Color _backgroundColor =
        backgroundColor ?? context.appBarBackgroundColor!;

    final SystemUiOverlayStyle _overlayStyle =
        ThemeData.estimateBrightnessForColor(_backgroundColor) ==
                Brightness.dark
            ? SystemUiOverlayStyle.light
            : SystemUiOverlayStyle.dark;

    /// 这里没有直接用SafeArea，而是用Container包装了一层
    /// 因为直接用SafeArea，会把顶部的statusBar区域留出空白
    /// 外层Container会填充SafeArea，指定外层Container背景色也会覆盖原来SafeArea的颜色
    /// var statusheight = MediaQuery.of(context).padding.top;  获取状态栏高度

    /// AnnotatedRegion应该只包裹顶部状态栏处的控件，比如AppBar的写法就不会导致底部导航栏变黑
    /// 将Header抽取出来，AnnotatedRegion只包裹顶部的Header，这样写既能实现修改状态栏字体，也没有影响到底部导航栏。
    return AnnotatedRegion<SystemUiOverlayStyle>(
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
                Expanded(
                  flex: 1,
                  child: backWidget(context),
                ),
                Expanded(
                  flex: 5,
                  child: titleWidget(context),
                ),
                Expanded(
                  flex: 1,
                  child: rightWidget(context),
                ),
              ],
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
    final Widget widget = isBack
        ? IconButton(
            onPressed: () async {
              FocusManager.instance.primaryFocus?.unfocus();
              // bool isBack = await navigator!.maybePop();
              // if (isBack) {
              //   Get.back();
              // }
              Get.back(canPop: true);
            },
            tooltip: 'Back',
            padding: const EdgeInsets.all(12.0),
            icon: backIcon ??
                Image.asset(
                  backImg,
                  color: backImageColor ?? context.appBarIconColor,
                ),
          )
        : Gaps.empty;

    return Container(
      alignment: Alignment.centerLeft,
      child: widget,
    );
  }

  Widget titleWidget(BuildContext context) {
    return Container(
      alignment: centerTitle.isEmpty ? Alignment.centerLeft : Alignment.center,
      child: Text(
        title.isEmpty ? centerTitle : title,
        style: context.subtitle1Style,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Widget rightWidget(BuildContext context) {
    TextStyle? textStyle = TextStyle(
        color: context.subtitle2Color,
        fontSize: context.subtitle2Style?.fontSize);

    Widget widget = actionName.isNotEmpty
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
                        color: actionImageColor,
                      )
                    : Gaps.empty),
          );

    return Container(
      alignment: Alignment.centerRight,
      child: widget,
    );
  }
}
