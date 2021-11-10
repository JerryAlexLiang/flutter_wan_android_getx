import 'package:flutter/material.dart';
import 'package:flutter_wan_android_getx/routes/app_routes.dart';
import 'package:flutter_wan_android_getx/utils/logger_util.dart';
import 'package:flutter_wan_android_getx/widget/search_app_bar.dart';
import 'package:flutter_wan_android_getx/widget/search_view.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import 'home_controller.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();

    LoggerUtil.d("=======> HomePage build");

    // return  const Icon(Icons.star);

    return Scaffold(
      appBar: SearchAppBar(
        showLeft: true,
        showRight: true,
        showBottomLine: true,
        bottomLineColor: Colors.red,
        leftName: '致一科技',
        leftNameStyle: TextStyle(fontSize: 16),
        leftPadding: EdgeInsets.only(left: 16, right: 5),
        actionName: '搜索',
        onRightPressed: () => Fluttertoast.showToast(msg: '搜索'),
        searchInput: SearchView(
          hintText: '致一科技',
          hintTextStyle: TextStyle(fontSize: 13),
          onTap: () => Get.toNamed(AppRoutes.searchPage),
        ),
      ),
      body: Center(
        child: const Icon(Icons.star),
      ),
    );
  }
}
