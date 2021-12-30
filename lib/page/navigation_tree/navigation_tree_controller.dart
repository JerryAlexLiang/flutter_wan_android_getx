import 'package:flutter_wan_android_getx/app_user_login_state_controller.dart';
import 'package:flutter_wan_android_getx/base/base_getx_controller.dart';
import 'package:flutter_wan_android_getx/constant/constant.dart';
import 'package:flutter_wan_android_getx/http/dio_method.dart';
import 'package:flutter_wan_android_getx/http/dio_util.dart';
import 'package:flutter_wan_android_getx/http/request_api.dart';
import 'package:flutter_wan_android_getx/model/navigation_model.dart';
import 'package:flutter_wan_android_getx/utils/logger_util.dart';
import 'package:get/get.dart';

/// 类名: navigation_tree_controller.dart
/// 创建日期: 12/21/21 on 6:20 PM
/// 描述: 导航
/// 作者: 杨亮

class NavigationTreeController extends BaseGetXController {
  /// 左侧导航组
  final navigationGroupList = RxList<NavigationModel?>();

  /// 当前选中右侧区间
  final Rx<NavigationModel?> currentNavigation = NavigationModel().obs;

  @override
  void onInit() {
    super.onInit();
    //refreshLoadState = LoadState.success;

    /// 每次登陆状态发生变化后更新数据
    ever(appStateController.isLogin, (callback) {
      initNavigationData();
    });
  }

  @override
  void onReady() {
    super.onReady();
    initNavigationData();
  }

  Future<void> initNavigationData() async {
    httpManager(
      loadingType: Constant.lottieRocketLoading,
      future:
          DioUtil().request(RequestApi.navigationList, method: DioMethod.get),
      onSuccess: (response) {
        ///列表转换的时候一定要加一下强转List<dynamic>，否则会报错
        List<NavigationModel> model = (response as List<dynamic>)
            .map((e) => NavigationModel.fromJson(e))
            .toList();

        /// 循环遍历 装载 可观察变量 isCollect
        if (model.isNotEmpty) {
          for (var value in model) {
            var articles = value.articles;
            if (articles != null && articles.isNotEmpty) {
              for (var article in articles) {
                var collect = article.collect;
                article.isCollect = collect;
              }
            }
          }
        }

        navigationGroupList.assignAll(model);
        if (navigationGroupList.isNotEmpty) {
          // 默认定位到第一个导航栏
          currentNavigation.value = navigationGroupList[0];
        }
        LoggerUtil.d("=======<>1  ${model[0].articles![2].toJson()}");
      },
      onFail: (value) {
        LoggerUtil.e(value.message, tag: "NavigationTreeController");
      },
      onError: (value) {
        LoggerUtil.e(value.message, tag: "NavigationTreeController");
      },
    );
  }

  /// 点击切换导航
  void changeNavigation(NavigationModel? model) {
    currentNavigation.value = model;
  }
}
