import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_wan_android_getx/page/mine/mine_controller.dart';
import 'package:flutter_wan_android_getx/res/gaps.dart';
import 'package:get/get.dart';

class FunctionCardTextWidget extends GetView<MineController> {
  const FunctionCardTextWidget(this.count, this.title,
      {@required this.onTap, Key? key})
      : super(key: key);

  final int count;
  final String title;
  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap,
      child: Container(
        padding: EdgeInsets.all(15.w),
        child: Column(
          children: [
            Text('$count'),
            Gaps.vGap5,
            Text(title),
          ],
        ),
      ),
    );
  }
}
