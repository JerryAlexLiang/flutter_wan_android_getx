import 'package:flutter/material.dart';
import 'package:flutter_wan_android_getx/model/tree_model.dart';
import 'package:flutter_wan_android_getx/res/gaps.dart';
import 'package:flutter_wan_android_getx/theme/app_theme.dart';

/// 类名: tree_chip_wrap.dart
/// 创建日期: 12/22/21 on 6:18 PM
/// 描述: 体系 Chip Wrap 流式列表
/// 作者: 杨亮

class TreeChipWrap extends StatelessWidget {
  const TreeChipWrap({
    Key? key,
    required this.chipList,
    required this.onTap,
  }) : super(key: key);

  //流布局数据列表
  final List<Children?>? chipList;
  final Function(Children value) onTap;

  @override
  Widget build(BuildContext context) {
    if (chipList != null) {
      List<Widget> _wrapList = chipList!
          .map((e) => _chipWidget(context, e!, chipList!.indexOf(e)))
          .toList();
      return Wrap(
        // spacing: 5,
        // runSpacing: 5,
        children: _wrapList,
      );
    } else {
      return Gaps.empty;
    }
  }

  Widget _chipWidget(BuildContext context, Children model, int index) {
    ///使用DecoratedBox+InkWell看不到点击效果，需要使用Ink组件
    return Container(
      padding: const EdgeInsets.all(5),
      child: Ink(
        decoration: BoxDecoration(
          // color: Colors.grey[200],
          color: context.chipBackgroundColor,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white, width: 0.1),
        ),
        child: InkWell(
          splashColor: Colors.transparent.withOpacity(0.1),
          borderRadius: BorderRadius.circular(20),
          onTap: () => onTap(model),
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 5,
            ),
            child: Text(
              model.name ?? "",
              style: context.bodyText2Style?.copyWith(fontSize: 14),
            ),
          ),
        ),
      ),
    );
  }
}
