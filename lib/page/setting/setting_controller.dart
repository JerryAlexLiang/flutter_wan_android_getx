import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_wan_android_getx/base/base_getx_controller.dart';
import 'package:flutter_wan_android_getx/constant/constant.dart';
import 'package:flutter_wan_android_getx/http/dio_method.dart';
import 'package:flutter_wan_android_getx/http/dio_util.dart';
import 'package:flutter_wan_android_getx/http/request_api.dart';

/// 类名: setting_controller.dart
/// 创建日期: 12/9/21 on 6:11 PM
/// 描述: 设置界面
/// 作者: 杨亮

class SettingController extends BaseGetXController {

  void gotoLogout() {
    handleRequest(
      loadingType: Constant.lottieRocketLoading,
      future: DioUtil().request(RequestApi.goToLogout, method: DioMethod.get),
      onSuccess: (response) {
        DioUtil().clearCookie();
        isLogin = false;
        EasyLoading.showSuccess('退出登录成功');
      },
      onFail: (value) {
        isLogin = true;
        EasyLoading.showError('退出登录失败,$value');
      },
      onError: (value){
        isLogin = true;
        EasyLoading.showError('退出登录失败,$value');
      }
    );
  }
}
