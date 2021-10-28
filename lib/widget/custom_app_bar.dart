import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_wan_android_getx/res/gaps.dart';
import 'package:flutter_wan_android_getx/theme/app_theme.dart';
import 'package:get/get.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    Key? key,
    this.backgroundColor,
    this.title = '',
    this.centerTitle = '',
    this.backImg = 'images/ic_back_black.png',
    this.backIcon,
    this.backBackgroundColor,
    this.actionName = '',
    this.actionIcon = Gaps.empty,
    this.actionBackgroundColor,
    this.onRightPressed,
    this.isBack = true,
  }) : super(key: key);

  final Color? backgroundColor;
  final String title;
  final String centerTitle;
  final String backImg;
  final Widget? backIcon;
  final Color? backBackgroundColor;
  final String actionName;
  final Widget actionIcon;
  final Color? actionBackgroundColor;
  final VoidCallback? onRightPressed;
  final bool isBack;

  @override
  Widget build(BuildContext context) {
    final Color _backgroundColor = backgroundColor ?? context.backgroundColor;

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
          child: Row(
            children: [
              backWidget(context),
              Expanded(
                child: titleWidget(context),
              ),
              rightWidget(context),
            ],
          ),
        ),
      ),
    );
  }

  @override
  //AppBar需要实现PreferredSizeWidget
  Size get preferredSize => const Size.fromHeight(56);

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
                  color: backBackgroundColor ?? context.appIconColor,
                  // Get.theme.appBarTheme.iconTheme?.color,
                ),
          )
        : Gaps.empty;

    return widget;
  }

  Widget titleWidget(BuildContext context) {
    return Container(
      alignment: centerTitle.isEmpty ? Alignment.centerLeft : Alignment.center,
      child: Text(
        title.isEmpty ? centerTitle : title,
        // style: Get.textTheme.subtitle1,
        style: context.subtitle1Style,
      ),
    );
  }

  Widget rightWidget(BuildContext context) {
    TextStyle? textStyle;
    if (actionBackgroundColor != null) {
      textStyle = TextStyle(
          color: actionBackgroundColor,
          // fontSize: Get.textTheme.subtitle2?.fontSize);
          fontSize: context.subtitle2Style?.fontSize);
    } else {
      // textStyle = TextStyle(
      //     color: Get.textTheme.subtitle2?.color,
      //     fontSize: Get.textTheme.subtitle2?.fontSize);
      textStyle = TextStyle(
          color: context.subtitle2Color,
          fontSize: context.subtitle2Style?.fontSize);
    }

    Widget widget = actionName.isNotEmpty
        ? TextButton(
            onPressed: onRightPressed,
            child: Text(
              actionName,
              style: textStyle,
            ),
          )
        : IconButton(
            padding: const EdgeInsets.all(12.0),
            onPressed: onRightPressed,
            icon: actionIcon,
          );
    return widget;
  }
}
