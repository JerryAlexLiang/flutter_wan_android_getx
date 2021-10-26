import 'package:get/get.dart';

import 'system_tree_controller.dart';

class SystemTreeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SystemTreeController());
  }
}
