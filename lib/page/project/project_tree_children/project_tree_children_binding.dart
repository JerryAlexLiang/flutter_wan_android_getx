import 'package:get/get.dart';

import 'project_tree_children_controller.dart';

class ProjectTreeChildrenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ProjectTreeChildrenController());
  }
}
