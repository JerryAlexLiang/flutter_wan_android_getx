import 'package:get/get.dart';

import 'project_controller.dart';

class ProjectBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ProjectController());
  }
}
