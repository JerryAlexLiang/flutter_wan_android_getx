import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_wan_android_getx/app_user_login_state_controller.dart';
import 'package:flutter_wan_android_getx/base/base_getx_with_page_refresh_controller.dart';
import 'package:flutter_wan_android_getx/constant/constant.dart';
import 'package:flutter_wan_android_getx/http/dio_method.dart';
import 'package:flutter_wan_android_getx/http/dio_util.dart';
import 'package:flutter_wan_android_getx/http/request_api.dart';
import 'package:flutter_wan_android_getx/model/total_user_info_model.dart';
import 'package:flutter_wan_android_getx/res/strings.dart';
import 'package:flutter_wan_android_getx/utils/logger_util.dart';
import 'package:flutter_wan_android_getx/utils/sp_util.dart';
import 'package:flutter_wan_android_getx/widget/state/load_state.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class MineController extends BaseGetXWithPageRefreshController {
  //标题栏透明比例
  final _percent = 0.0.obs;

  get percent => _percent.value;

  set percent(value) => _percent.value = value;

  // /// 个人用户信息
  // final userInfo = UserInfoModel().obs;
  // final coinInfo = CoinInfo().obs;

  // final userNickName = "".obs;

  /// 登录注册退出
  // final loginController = Get.put(LoginRegisterController());

  @override
  void onInit() {
    super.onInit();
    refreshLoadState = LoadState.success;
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

    appStateController.updateUserInfo();
  }

  // updateUserInfo() {
  //   if (loginState) {
  //     // 获取本地化存储用户数据
  //     var localUserInfo = SpUtil.getUserInfo();
  //     if (localUserInfo != null) {
  //       // userNickName.value = localUserInfo.nickname!;
  //       appStateController.userInfo.value.nickname = localUserInfo.nickname!;
  //     }
  //
  //     Fluttertoast.showToast(msg: '已登录');
  //   }else{
  //     appStateController.userInfo.value.nickname = '登录';
  //     Fluttertoast.showToast(msg: '未登录');
  //   }
  // }

  @override
  void onReadyInitData() {
    super.onReadyInitData();
    if(loginState){
      getUserInfo();
    }
  }

  Future<void> getUserInfo() async {
    refreshLoadState = LoadState.success;

    handleRequestWithRefreshPaging(
      loadingType: Constant.showLoadingDialog,
      future: DioUtil().request(RequestApi.getUserInfo, method: DioMethod.get),
      onSuccess: (response) {
        refreshLoadState = LoadState.success;
        var model = TotalUserInfoModel.fromJson(response);
        if (model.userInfo != null) {
          // userInfo.value = model.userInfo!;
          // coinInfo.value = model.coinInfo!;
          // userNickName.value = model.userInfo!.nickname!;

          appStateController.userInfo.value = model.userInfo!;
          appStateController.coinInfo.value = model.coinInfo!;

          // 本地化存储
          SpUtil.saveUserInfo(model.userInfo!);
          Fluttertoast.showToast(msg: StringsConstant.refreshSuccess.tr);
        }
      },
      onFail: (value) {
        refreshLoadState = LoadState.success;
        EasyLoading.showInfo('${value.message}');
      },
      onError: (error) {
        refreshLoadState = LoadState.success;
        EasyLoading.showError(error.message);
      },
    );
  }
}
