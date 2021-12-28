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

    /// 每次登录状态发生改变时更新数据
    ever(appStateController.isLogin, (callback) {
      onReadyInitData();
    });
  }

  @override
  void onReadyInitData() {
    super.onReadyInitData();
    if (appStateController.isLogin.value) {
      getUserInfo();
    }
  }

  Future<void> getUserInfo() async {
    refreshLoadState = LoadState.success;

    // await Future.delayed(const Duration(seconds: 3));

    handleRequestWithRefreshPaging(
      loadingType: Constant.noLoading,
      future: DioUtil().request(RequestApi.getUserInfo, method: DioMethod.get),
      onSuccess: (response) {
        refreshLoadState = LoadState.success;
        var model = TotalUserInfoModel.fromJson(response);
        if (model.userInfo != null) {
          appStateController.userInfo.value = model.userInfo!;
          appStateController.coinInfo.value = model.coinInfo!;

          // 本地化存储
          SpUtil.saveUserInfo(model.userInfo!);
          // Fluttertoast.showToast(msg: StringsConstant.refreshSuccess.tr);
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
