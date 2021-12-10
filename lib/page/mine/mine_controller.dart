import 'package:flutter/material.dart';
import 'package:flutter_wan_android_getx/base/base_getx_controller.dart';
import 'package:flutter_wan_android_getx/constant/constant.dart';
import 'package:flutter_wan_android_getx/http/dio_method.dart';
import 'package:flutter_wan_android_getx/http/dio_util.dart';
import 'package:flutter_wan_android_getx/http/request_api.dart';
import 'package:flutter_wan_android_getx/model/total_user_info_model.dart';
import 'package:flutter_wan_android_getx/model/user_info_model.dart';
import 'package:flutter_wan_android_getx/utils/logger_util.dart';
import 'package:flutter_wan_android_getx/utils/sp_util.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class MineController extends BaseGetXController {
  //标题栏透明比例
  final _percent = 0.0.obs;

  get percent => _percent.value;

  set percent(value) => _percent.value = value;

  /// 个人用户信息
  late final TotalUserInfoModel userInfoModel;

  final coinInfo = CoinInfo().obs;

  final userInfo = UserInfoModel().obs;

  //滚动控制器
  ScrollController scrollController = ScrollController();

  //下拉刷新控制器
  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  @override
  void onInit() {
    super.onInit();
    //滑动监听
    scrollController.addListener(() {
      var scrollerPercent = scrollController.offset / 140;
      if (scrollerPercent < 0) {
        scrollerPercent = 0;
      } else if (scrollerPercent > 1.0) {
        scrollerPercent = 1.0;
      }
      percent = scrollerPercent;
      LoggerUtil.d('=======> 滑动监听: $percent');
    });
    notifyUserInfo();
  }

  @override
  void onReadyInitData() {
    super.onReadyInitData();
  }

  Future<void> notifyUserInfo() async {
    handleRequest(
      loadingType: Constant.lottieRocketLoading,
      future: DioUtil().request(RequestApi.getUserInfo, method: DioMethod.get),
      onSuccess: (response) {
        var model = TotalUserInfoModel.fromJson(response);
        if (userInfoModel.userInfo != null) {
          userInfoModel = model;
          userInfo.value = userInfoModel.userInfo!;
          SpUtil.saveUserInfo(userInfoModel.userInfo!);
        }
      },
      onFail: (response) {},
    );
  }
}
