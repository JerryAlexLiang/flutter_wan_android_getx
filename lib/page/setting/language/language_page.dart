import 'package:flutter/material.dart';
import 'package:flutter_wan_android_getx/page/model/language.dart';
import 'package:flutter_wan_android_getx/res/strings.dart';
import 'package:flutter_wan_android_getx/routes/app_routes.dart';
import 'package:flutter_wan_android_getx/utils/logger_util.dart';
import 'package:flutter_wan_android_getx/widget/custom_app_bar.dart';
import 'package:flutter_wan_android_getx/widget/custom_list_title.dart';
import 'package:get/get.dart';

import 'language_controller.dart';

class LanguagePage extends StatelessWidget {
  final controller = Get.find<LanguageController>();

  LanguagePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    LoggerUtil.d('LanguagePage build',tag: 'LanguagePage');

    return Scaffold(
      appBar: CustomAppBar(
        centerTitle: StringsConstant.language.tr,
      ),
      body: languageListView(),
    );
  }

  Widget languageListView() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      itemCount: controller.languageList.length,
      itemBuilder: (context, index) {
        return CustomListTitle(
          title: controller.languageList[index].name!.tr,
          subTitle: controller.languageList[index].name,
          isSelectType: true,
          isSelect: controller.languageList[index].isSelect,
          rightWidget: const Icon(
            Icons.radio_button_checked,
            size: 20,
          ),
          onTap: () => {
            controller.onSelectLanguage(index),
            Get.offAllNamed(AppRoutes.main),
          },
        );
      },
    );
  }
}
