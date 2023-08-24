import 'package:flutter_wan_android_getx/page/collect/collect_article_list/collect_article_list_controller.dart';
import 'package:flutter_wan_android_getx/page/home/home_controller.dart';
import 'package:flutter_wan_android_getx/page/mine/mine_controller.dart';
import 'package:flutter_wan_android_getx/page/navigation_tree/navigation_tree_controller.dart';
import 'package:flutter_wan_android_getx/page/project/project_controller.dart';
import 'package:flutter_wan_android_getx/page/search/article_detail_controller.dart';
import 'package:flutter_wan_android_getx/page/search/my_search_controller.dart';
import 'package:flutter_wan_android_getx/page/system_tree/system_tree_controller.dart';
import 'package:get/get.dart';

import 'index_controller.dart';

class IndexBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => IndexController());
    Get.lazyPut(() => MySearchController());
    Get.lazyPut(() => HomeController());
    Get.lazyPut(() => SystemTreeController());
    Get.lazyPut(() => NavigationTreeController());
    Get.lazyPut(() => ProjectController());
    Get.lazyPut(() => MineController());

    /// 文章详情控制器（收藏、点赞等）
    Get.put(ArticleDetailController());

    // /// 登录注册退出
    // Get.lazyPut(() => LoginRegisterController());
  }
}
