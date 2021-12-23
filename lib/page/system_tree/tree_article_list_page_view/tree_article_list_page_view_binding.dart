import 'package:get/get.dart';

import 'tree_article_list_page_view_controller.dart';

class TreeArticleListPageViewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TreeArticleListPageViewController());
  }
}
