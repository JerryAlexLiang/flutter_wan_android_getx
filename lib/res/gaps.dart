import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_wan_android_getx/res/dimens.dart';

/// 间隔
/// 官方做法：https://github.com/flutter/flutter/pull/54394
class Gaps {
  
  /// 水平间隔
  static const Widget hGap1 = SizedBox(width: Dimens.gapDp1);
  static const Widget hGap2 = SizedBox(width: Dimens.gapDp2);
  static const Widget hGap3 = SizedBox(width: Dimens.gapDp3);
  static const Widget hGap4 = SizedBox(width: Dimens.gapDp4);
  static const Widget hGap5 = SizedBox(width: Dimens.gapDp5);
  static const Widget hGap8 = SizedBox(width: Dimens.gapDp8);
  static const Widget hGap10 = SizedBox(width: Dimens.gapDp10);
  static const Widget hGap12 = SizedBox(width: Dimens.gapDp12);
  static const Widget hGap15 = SizedBox(width: Dimens.gapDp15);
  static const Widget hGap16 = SizedBox(width: Dimens.gapDp16);
  static const Widget hGap32 = SizedBox(width: Dimens.gapDp32);
  static const Widget hGap50 = SizedBox(width: Dimens.gapDp50);

  /// 垂直间隔
  static const Widget vGap1 = SizedBox(height: Dimens.gapDp1);
  static const Widget vGap2 = SizedBox(height: Dimens.gapDp2);
  static const Widget vGap3 = SizedBox(height: Dimens.gapDp3);
  static const Widget vGap4 = SizedBox(height: Dimens.gapDp4);
  static const Widget vGap5 = SizedBox(height: Dimens.gapDp5);
  static const Widget vGap8 = SizedBox(height: Dimens.gapDp8);
  static const Widget vGap10 = SizedBox(height: Dimens.gapDp10);
  static const Widget vGap12 = SizedBox(height: Dimens.gapDp12);
  static const Widget vGap15 = SizedBox(height: Dimens.gapDp15);
  static const Widget vGap16 = SizedBox(height: Dimens.gapDp16);
  static const Widget vGap24 = SizedBox(height: Dimens.gapDp24);
  static const Widget vGap32 = SizedBox(height: Dimens.gapDp32);
  static const Widget vGap50 = SizedBox(height: Dimens.gapDp50);
  
//  static Widget line = const SizedBox(
//    height: 0.6,
//    width: double.infinity,
//    child: const DecoratedBox(decoration: BoxDecoration(color: Colours.line)),
//  );

  static const Widget line = Divider();

  static const Widget vLine = SizedBox(
    width: 0.6,
    height: 24.0,
    child: VerticalDivider(),
  );
  
  static const Widget empty = SizedBox.shrink();

  /// 补充一种空Widget实现 https://github.com/letsar/nil
  /// https://github.com/flutter/flutter/issues/78159
}
