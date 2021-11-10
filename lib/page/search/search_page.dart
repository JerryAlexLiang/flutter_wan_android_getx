import 'package:flutter/material.dart';
import 'package:flutter_wan_android_getx/utils/keyboard_util.dart';
import 'package:flutter_wan_android_getx/widget/search_app_bar.dart';
import 'package:flutter_wan_android_getx/widget/search_view.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import 'search_controller.dart';

/// 搜索界面

class SearchPage extends StatelessWidget {
  final controller = Get.find<SearchController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SearchAppBar(
        showLeft: true,
        onLeftPressed: () => controller.finishSearchPage(),
        showRight: true,
        actionName: '搜索',
        onRightPressed: () {
          controller.keyword = controller.textEditingController.text;
          controller.loadSearchKeys();
          FocusManager.instance.primaryFocus?.unfocus();
        },
        searchInput: SearchView(
          enabled: true,
          hintText: '致一科技',
          hintTextStyle: const TextStyle(fontSize: 13),
          editingController: controller.textEditingController,
          onSuffixPressed: () => controller.clearSearchView(),
          onChange: (String value) {
            controller.keyword = value;
          },
          onSubmit: (value) => {
            controller.keyword = value,
            controller.loadSearchKeys(),
          },
        ),
      ),
      body: Container(
        child: Obx(() {
          return IndexedStack(
            index: controller.indexed,
            children: [
              Container(
                child: Center(
                  child: Text(
                    '1',
                    style: TextStyle(
                      fontSize: 22,
                    ),
                  ),
                ),
              ),
              Container(
                child: Center(
                  child: Text(
                    controller.keyword,
                    style: TextStyle(
                      fontSize: 22,
                    ),
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
