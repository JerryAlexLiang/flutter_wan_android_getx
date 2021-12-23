import 'package:get/get.dart';

import 'system_content_controller.dart';

class SystemContentBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SystemContentController());
    // Get.lazyPut(() => TreeArticleListPageViewController());
  }
}
