import 'package:flutter/material.dart';
import 'package:flutter_wan_android_getx/res/gaps.dart';
import 'package:flutter_wan_android_getx/theme/app_theme.dart';

/// 自定义组件 CustomListTitle，实现多种布局类型的ListTitle Widget
/// 说明：
/// 1、Widget属性icon 优先于String类型的image生效，imageColor只对image生效
/// 2、右侧Widget,actionName属性优先于actionIcon和actionImage生效；

class CustomListTitle extends StatelessWidget {
  const CustomListTitle({
    Key? key,
    this.isShowLeftWidget = false,
    this.leftImage,
    this.leftWidget,
    this.title = "",
    this.rightContent = "",
    this.maxLines = 1,
    this.leftColor,
    this.rightColor,
    this.rightImage,
    this.rightWidget = Gaps.empty,
    this.leftSize = 22,
    this.endSize = 16,
    this.onTap,
    this.onLongPress,
    this.showBottomLine = false,
    this.isSelectType = false,
    this.isSelect = false,
  }) : super(key: key);

  /// 左侧组件
  final bool isShowLeftWidget;
  final String? leftImage;
  final Widget? leftWidget;

  /// 标题
  final String title;

  /// 内容
  final String rightContent;

  /// 右侧组件
  final String? rightImage;
  final Widget rightWidget;
  final int maxLines;

  /// 是否显示下划线
  final bool showBottomLine;

  ///左侧图标大小
  final double leftSize;

  /// 右侧图标大小
  final double endSize;

  /// 左侧图标颜色
  final Color? leftColor;

  /// 右侧图标颜色
  final Color? rightColor;

  /// 点击事件
  final GestureTapCallback? onTap;

  /// 长按时间
  final GestureTapCallback? onLongPress;

  /// 是否可选类型Item
  final bool isSelectType;

  /// 是否选中
  final bool isSelect;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        onLongPress: onLongPress,
        child: buildContainer(context),
      ),
    );
  }

  Widget buildContainer(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      margin: const EdgeInsets.symmetric(horizontal: 16.0),
      padding: const EdgeInsets.fromLTRB(0, 16, 0, 16),
      constraints: const BoxConstraints(
        maxHeight: double.infinity,
        minHeight: 50,
      ),
      width: double.infinity,
      decoration: BoxDecoration(
        /// 使用装饰器设置是否显示下划线
        border: Border(
          bottom: showBottomLine
              ? Divider.createBorderSide(context, width: 0.6)
              : Divider.createBorderSide(context,
                  width: 0.0, color: Colors.transparent),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // 左侧Widget
          buildLeftWidget(context),
          isShowLeftWidget ? Gaps.hGap10 : Gaps.empty,
          // Title
          buildTitleWidget(context),
          Gaps.hGap32,
          // 右侧Widget
          buildRightWidget(context),
        ],
      ),
    );
  }

  /// 左侧Widget
  Widget buildLeftWidget(BuildContext context) {
    Widget widget = isShowLeftWidget
        ? (leftWidget ??
            (leftImage != null
                ? Image.asset(leftImage!,
                    width: leftSize, height: leftSize, color: leftColor)
                : Gaps.empty))
        : Gaps.empty;

    return Container(
      child: widget,
    );
  }

  /// Title
  Widget buildTitleWidget(BuildContext context) {
    return Expanded(
      child: Container(
        // color: Colors.blue,
        alignment: Alignment.centerLeft,
        child: Offstage(
          //offstage 为false 则显示，为true 则不显示
          offstage: title.isEmpty ? true : false,
          child: Text(
            title,
            style: context.bodyText1Style,
            maxLines: maxLines,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.start,
          ),
        ),
      ),
    );
  }

  /// 右侧Widget
  Widget buildRightWidget(BuildContext context) {
    /// 可选类型Item : buildRightWidget2, 非可选类型Item : buildRightWidget1
    Widget widget =
        !isSelectType ? buildRightWidget1(context) : buildRightWidget2(context);

    if (!isSelectType) {
      //非选项类型Item
      return Expanded(
        flex: 2,
        child: Container(
          // color: Colors.red,
          alignment: Alignment.centerRight,
          child: widget,
        ),
      );
    } else {
      //可选项类型Item
      return Container(
        alignment: Alignment.centerRight,
        child: widget,
      );
    }
  }

  /// 非可选类型Item
  Widget buildRightWidget1(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Offstage(
            offstage: rightContent.isEmpty ? true : false,
            child: Text(
              rightContent,
              style: context.bodyText2Style?.copyWith(fontSize: 12),
              maxLines: maxLines,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.end,
            ),
          ),
        ),
        Gaps.hGap8,
        rightImage != null
            ? Image.asset(
                rightImage!,
                width: endSize,
                height: endSize,
                color: context.bodyText2Color,
              )
            : rightWidget,
      ],
    );
  }

  /// 可选类型Item
  Widget buildRightWidget2(BuildContext context) {
    Widget selectWidget = rightImage != null
        ? Image.asset(
            rightImage!,
            width: endSize,
            height: endSize,
            color: rightColor,
          )
        : rightWidget;

    Widget widget = isSelect ? selectWidget : Gaps.hGap16;
    return widget;
  }
}
