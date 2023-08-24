import 'package:get/get.dart';

import 'my_search_controller.dart';

class SearchBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MySearchController());
  }
}
