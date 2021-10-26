import 'package:get/get.dart';

import 'navigation_tree_controller.dart';

class NavigationTreeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => NavigationTreeController());
  }
}
