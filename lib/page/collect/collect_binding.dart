import 'package:flutter_wan_android_getx/page/collect/collect_article_list/collect_article_list_controller.dart';
import 'package:flutter_wan_android_getx/page/collect/collect_link_list/collect_link_list_controller.dart';
import 'package:get/get.dart';

import 'collect_controller.dart';

class CollectBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CollectController());
    Get.lazyPut(() => CollectArticleListController());
    Get.lazyPut(() => CollectLinkListController());
  }
}
