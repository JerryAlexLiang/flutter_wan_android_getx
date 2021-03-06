import 'package:flutter_wan_android_getx/base/base_getx_controller.dart';
import 'package:flutter_wan_android_getx/model/total_user_info_model.dart';
import 'package:flutter_wan_android_getx/model/user_info_model.dart';
import 'package:flutter_wan_android_getx/res/strings.dart';
import 'package:flutter_wan_android_getx/utils/sp_util.dart';
import 'package:get/get.dart';

import 'model/article_data_model.dart';

/// 类名: app_user_login_state_controller.dart
/// 创建日期: 12/14/21 on 10:12 AM
/// 描述: 用户登录状态
/// 作者: 杨亮

class AppUserLoginStateController extends BaseGetXController {
  /// 登录状态
  final isLogin = false.obs;

  /// 个人用户信息
  final userInfo = UserInfoModel().obs;
  final coinInfo = CoinInfo().obs;

  // // 返回数据列表
  // final collectArticleList = RxList<ArticleDataModelDatas>();

  setLoginState(bool value) {
    isLogin.value = value;
  }

  void updateUserInfo() {
    if (loginState) {
      // 获取本地化存储用户数据
      var localUserInfo = SpUtil.getUserInfo();
      if (localUserInfo != null) {
        userInfo.value.nickname = localUserInfo.nickname!;
      }
    } else {
      userInfo.value.nickname = StringsConstant.loginContent.tr;
    }
  }
}

/// 登录状态
bool get loginState => Get.find<AppUserLoginStateController>().isLogin.value;

set loginState(value) =>
    Get.find<AppUserLoginStateController>().setLoginState(value);

AppUserLoginStateController get appStateController =>
    Get.find<AppUserLoginStateController>();
