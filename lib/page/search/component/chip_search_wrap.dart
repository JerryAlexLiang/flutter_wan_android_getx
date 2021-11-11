import 'package:flutter/material.dart';
import 'package:flutter_wan_android_getx/res/gaps.dart';
import 'package:flutter_wan_android_getx/theme/app_theme.dart';
import 'package:flutter_wan_android_getx/utils/logger_util.dart';

/// 类名: chip_search_wrap.dart
/// 创建日期: 11/10/21 on 3:44 PM
/// 描述: 搜索页面关键词name 流布局列表
/// 作者: 杨亮

enum SearchChipType { hot, history }

class ChipSearchWrap extends StatelessWidget {
  const ChipSearchWrap(
      {Key? key,
      this.isShow = true,
      this.isShowTitle = true,
      this.title = '',
      this.chipNameList,
      required this.onTap,
      this.searchChipType})
      : super(key: key);

  // 是否显示流式布局
  final bool isShow;

  // 是否显示标题栏
  final bool isShowTitle;
  final String title;

  // 类型：hot 热词 history：搜索历史关键词
  final SearchChipType? searchChipType;

  //流布局数据列表
  final List<String?>? chipNameList;
  final Function(String value) onTap;

  @override
  Widget build(BuildContext context) {
    return Offstage(
      offstage: isShow ? false : true,
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
    return Offstage(
      offstage: isShowTitle ? false : true,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          searchChipType == SearchChipType.hot
              ? const Icon(Icons.local_fire_department)
              : const Icon(Icons.history),
          Gaps.hGap8,
          Text(
            title,
            style: context.bodyText1Style,
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
                Offstage(
                    offstage: index == 0 ? false : true,
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
