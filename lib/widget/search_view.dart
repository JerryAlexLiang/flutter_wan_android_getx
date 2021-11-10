import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_wan_android_getx/page/search/search_controller.dart';
import 'package:get/get.dart';

/// 自定义搜索栏

class SearchView extends StatelessWidget {
  SearchView({
    Key? key,
    this.hintText = '',
    this.enabled = false,
    this.height = 35.0,
    this.editingController,
    this.onSuffixPressed,
    this.onTap,
    this.hintTextStyle,
    this.onSubmit,
    this.onChange,
  }) : super(key: key);

  //input内容
  final String hintText;
  final TextStyle? hintTextStyle;

  //是否可输入
  final bool enabled;

  final double height;

  final TextEditingController? editingController;

  // 提交
  final ValueChanged<String>? onChange;
  final ValueChanged<String>? onSubmit;

  //后缀控件点击事件
  final VoidCallback? onSuffixPressed;

  //搜索框不可点击时候的点击事件
  final GestureTapCallback? onTap;

  final FocusNode _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        height: height,
        child: TextField(
          focusNode: _focusNode,
          controller: editingController,
          enabled: enabled,
          onSubmitted: onSubmit,
          onChanged: onChange,
          textInputAction: TextInputAction.search,
          decoration: InputDecoration(
            //后缀图标
            suffixIcon: _buildSuffixIcon(),
            contentPadding: EdgeInsets.symmetric(horizontal: 15.w),
            fillColor: context.theme.secondaryHeaderColor,
            filled: true,
            hintText: hintText,
            hintStyle: hintTextStyle,
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Color(0x00000000)),
              borderRadius: BorderRadius.all(Radius.circular(100)),
            ),
            disabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Color(0x00000000)),
              borderRadius: BorderRadius.all(Radius.circular(100)),
            ),
            border: const OutlineInputBorder(
              borderSide: BorderSide(color: Color(0x00000000)),
              borderRadius: BorderRadius.all(Radius.circular(100)),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Color(0x00000000)),
              borderRadius: BorderRadius.all(Radius.circular(100)),
            ),
          ),
        ),
      ),
    );
  }

  Widget setSuffixIcon(IconData icon) {
    return Icon(icon);
  }

  Widget? _buildSuffixIcon() {
    if (editingController == null) {
      return null;
    } else {
      //SearchView可用时启用SearchController

      final controller = Get.find<SearchController>();

      return enabled
          // ? GetX(
          //     init: Get.find<SearchController>(),
          //     builder: (SearchController controller) {
          //       //监控TextEditingController的输入值，更改Suffix图标
          //       return IconButton(
          //         onPressed: onSuffixPressed,
          //         icon: controller.keyword.isEmpty
          //             ? setSuffixIcon(Icons.search)
          //             : setSuffixIcon(Icons.clear),
          //       );
          //     },
          //   )

          ? Obx(() {
              //监控TextEditingController的输入值，更改Suffix图标
              return IconButton(
                onPressed: onSuffixPressed,
                icon: controller.keyword.isEmpty
                    ? setSuffixIcon(Icons.search)
                    : setSuffixIcon(Icons.clear),
              );
            })
          : IconButton(
              onPressed: onSuffixPressed,
              icon: setSuffixIcon(Icons.search),
            );
    }
  }
}
