import 'package:get/get.dart';

class CollectController extends GetxController {
  var collectTypeList = [];

  @override
  void onInit() {
    super.onInit();
    collectTypeList = ["文章", "网址"];
  }
}
