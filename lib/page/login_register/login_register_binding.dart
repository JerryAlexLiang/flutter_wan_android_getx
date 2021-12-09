import 'package:get/get.dart';

import 'login_register_controller.dart';

class LoginRegisterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LoginRegisterController());
  }
}
