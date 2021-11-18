import 'package:flutter_wan_android_getx/base/base_getx_controller.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:get/get.dart';

/// 类名: base_getx_with_page_refresh_controller.dart
/// 创建日期: 基于GetX的可刷新及分页的 BaseGetXWithPageRefreshController
/// 描述: TODO
/// 作者: 杨亮

class BaseGetXWithPageRefreshController extends BaseGetXController {
  /// 下拉刷新控制器
  late RefreshController _refreshController;

  RefreshController get refreshController => _refreshController;

  final _initialRefresh = false.obs;

  get initialRefresh => _initialRefresh.value;

  set initialRefresh(value) => _initialRefresh.value = value;

  @override
  void onInit() {
    super.onInit();
    _refreshController = RefreshController(initialRefresh: initialRefresh);
  }

  @override
  void dispose() {
    super.dispose();
    _refreshController.dispose();
  }
}
