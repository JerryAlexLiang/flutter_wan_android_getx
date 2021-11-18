import 'package:flutter/material.dart';
import 'package:flutter_wan_android_getx/res/gaps.dart';
import 'package:flutter_wan_android_getx/theme/app_color.dart';
import 'package:flutter_wan_android_getx/theme/app_theme.dart';
import 'package:flutter_wan_android_getx/utils/logger_util.dart';
import 'package:flutter_wan_android_getx/widget/ripple_view.dart';

/// 类名: chip_search_wrap.dart
/// 创建日期: 11/10/21 on 3:44 PM
/// 描述: 搜索页面关键词name 流布局列表
/// 作者: 杨亮

enum SearchChipType { hot, history }

class ChipSearchWrap extends StatelessWidget {
  const ChipSearchWrap({
    Key? key,
    this.isShow = true,
    this.isShowTitle = true,
    this.title = '',
    this.subTitle = '',
    this.chipNameList,
    required this.onTap,
    this.searchChipType,
    required this.onRightTap,
  }) : super(key: key);

  // 是否显示流式布局
  final bool isShow;

  // 是否显示标题栏
  final bool isShowTitle;
  final String title;
  final String subTitle;

  // 类型：hot 热词 history：搜索历史关键词
  final SearchChipType? searchChipType;

  //流布局数据列表
  final List<String?>? chipNameList;
  final Function(String value) onTap;
  final VoidCallback onRightTap;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isShow,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _parentTitle(context),
          Gaps.vGap5,
          _chipWrap(context),
        ],
      ),
    );
  }

  /// 标题栏
  Widget _parentTitle(BuildContext context) {
    return Visibility(
      visible: isShowTitle,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          searchChipType == SearchChipType.hot
              ? const Icon(Icons.local_fire_department)
              : const Icon(Icons.history),
          Gaps.hGap8,
          // Text(
          //   title,
          //   style: context.bodyText1Style,
          // ),
          RichText(
            text: TextSpan(
              text: title,
              style: context.bodyText1Style,
              children: [
                const WidgetSpan(
                  child: Gaps.hGap16,
                ),
                TextSpan(
                  text: subTitle,
                  style: context.bodyText2Style!.copyWith(
                    color: AppColors.colorB8C0D4,
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          //右侧图标
          searchChipType == SearchChipType.hot
              // ? Gaps.empty
              ? RippleView(
                  radius: 20,
                  onTap: onRightTap,
                  child: const Padding(
                    padding: EdgeInsets.all(5),
                    child: Icon(
                      Icons.visibility_off_rounded,
                      size: 18,
                    ),
                  ),
                )
              : RippleView(
                  radius: 20,
                  onTap: onRightTap,
                  child: const Padding(
                    padding: EdgeInsets.all(5),
                    child: Icon(
                      Icons.delete_rounded,
                      size: 18,
                    ),
                  ),
                ),
        ],
      ),
    );
  }

  /// 流布局列表
  Widget _chipWrap(BuildContext context) {
    if (chipNameList != null) {
      LoggerUtil.d("======> ChipSearchWrap1  ${chipNameList!.toList()}");
      List<Widget> _wrapList = chipNameList!
          .map((e) => _chipWidget(context, e!, chipNameList!.indexOf(e)))
          .toList();

      LoggerUtil.d("======> ChipSearchWrap3  ${_wrapList.toList()}");

      return Wrap(
        // spacing: 5,
        // runSpacing: 5,
        children: _wrapList,
      );
    } else {
      return Gaps.empty;
    }
  }

  /// chip内容组件
  Widget _chipWidget(BuildContext context, String content, int index) {
    LoggerUtil.d("======> ChipSearchWrap2  $content");

    ///使用DecoratedBox+InkWell看不到点击效果，需要使用Ink组件
    return Container(
      padding: const EdgeInsets.all(5),
      child: Ink(
        decoration: BoxDecoration(
          // color: Colors.grey[200],
          color: context.chipBackgroundColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: InkWell(
          splashColor: Colors.transparent.withOpacity(0.1),
          borderRadius: BorderRadius.circular(20),
          onTap: () => onTap(content),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Visibility(
                    // 类型为热词推荐且只显示第一个chip
                    visible: searchChipType == SearchChipType.hot &&
                        (index == 0 ? true : false),
                    child: Container(
                      padding: const EdgeInsets.only(right: 5),
                      child: const Icon(
                        Icons.local_fire_department_rounded,
                        size: 15,
                        color: Colors.red,
                      ),
                    )),
                Text(
                  content,
                  style: context.bodyText2Style,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
