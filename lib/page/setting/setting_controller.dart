import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_wan_android_getx/app_user_login_state_controller.dart';
import 'package:flutter_wan_android_getx/base/base_getx_controller.dart';
import 'package:flutter_wan_android_getx/constant/constant.dart';
import 'package:flutter_wan_android_getx/http/dio_method.dart';
import 'package:flutter_wan_android_getx/http/dio_util.dart';
import 'package:flutter_wan_android_getx/http/request_api.dart';
import 'package:flutter_wan_android_getx/res/strings.dart';
import 'package:flutter_wan_android_getx/utils/sp_util.dart';
import 'package:get/get.dart';

/// 类名: setting_controller.dart
/// 创建日期: 12/9/21 on 6:11 PM
/// 描述: 设置界面
/// 作者: 杨亮

class SettingController extends BaseGetXController {



  /// 退出登录
  void gotoLogout() {
    handleRequest(
      loadingType: Constant.showLoadingDialog,
      future: DioUtil().request(RequestApi.goToLogout, method: DioMethod.get),
      onSuccess: (response) {
        // 清除Cookies
        DioUtil().clearCookie();
        loginState = false;
        appStateController.updateUserInfo();
        // 清除保存的用户数据
        SpUtil.clearUserInfo();
        EasyLoading.showSuccess(StringsConstant.logoutSuccess.tr);
        Get.back();
      },
      onFail: (value) {
        EasyLoading.showError('${StringsConstant.logoutFail.tr},$value');
      },
      onError: (value) {
        EasyLoading.showError('${StringsConstant.logoutFail.tr},$value');
      },
    );
  }
}
