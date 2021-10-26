import 'package:flutter/material.dart';
import 'package:flutter_wan_android_getx/page/setting/setting_page.dart';
import 'package:flutter_wan_android_getx/utils/logger_util.dart';
import 'package:get/get.dart';

import 'mine_controller.dart';

class MinePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<MineController>();

    LoggerUtil.d("=======> MinePage build");
    return Center(
      child: MaterialButton(
        onPressed: () {
          navigator!
              .push(MaterialPageRoute(builder: (context) => SettingPage()));
        },
        child: const Text('更改主题'),
      ),
    );
  }
}
