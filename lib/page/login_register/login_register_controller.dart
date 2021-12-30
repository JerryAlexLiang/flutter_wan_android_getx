import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_wan_android_getx/app_user_login_state_controller.dart';
import 'package:flutter_wan_android_getx/base/base_getx_controller.dart';
import 'package:flutter_wan_android_getx/constant/constant.dart';
import 'package:flutter_wan_android_getx/http/dio_method.dart';
import 'package:flutter_wan_android_getx/http/dio_util.dart';
import 'package:flutter_wan_android_getx/http/request_api.dart';
import 'package:flutter_wan_android_getx/model/user_info_model.dart';
import 'package:flutter_wan_android_getx/res/strings.dart';
import 'package:flutter_wan_android_getx/utils/keyboard_util.dart';
import 'package:flutter_wan_android_getx/utils/logger_util.dart';
import 'package:flutter_wan_android_getx/utils/sp_util.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

/// 类名: login_register_controller.dart
/// 创建日期: 12/8/21 on 2:33 PM
/// 描述: 注册登录
/// 作者: 杨亮

enum ButtonType { login, register }

class LoginRegisterController extends BaseGetXController {
  /// 登录注册类型
  final _buttonType = ButtonType.login.obs;

  get buttonType => _buttonType.value;

  set buttonType(value) => _buttonType.value = value;

  /// 登录注册按钮描述语
  final _switchButtonTypeDesc = StringsConstant.switchButtonRegisterDesc.tr.obs;

  get switchButtonTypeDesc => _switchButtonTypeDesc.value;

  set switchButtonTypeDesc(value) => _switchButtonTypeDesc.value = value;

  final _buttonTypeDesc = StringsConstant.loginContent.tr.obs;

  get buttonTypeDesc => _buttonTypeDesc.value;

  set buttonTypeDesc(value) => _buttonTypeDesc.value = value;

  /// 用户名
  final _userName = "".obs;

  get userName => _userName.value;

  set userName(value) => _userName.value = value;

  /// 密码
  final _password = "".obs;

  get password => _password.value;

  set password(value) => _password.value = value;

  /// 确认密码
  final _ensurePassword = "".obs;

  get ensurePassword => _ensurePassword.value;

  set ensurePassword(value) => _ensurePassword.value = value;

  late final TextEditingController textEditingControllerUserName;
  late final TextEditingController textEditingControllerUserPassword;
  late final TextEditingController textEditingControllerUserEnsurePassword;

  @override
  void onInit() {
    super.onInit();
    textEditingControllerUserName = TextEditingController();
    textEditingControllerUserPassword = TextEditingController();
    textEditingControllerUserEnsurePassword = TextEditingController();
  }

  /// 切换登录注册类型
  void switchLoginRegister(BuildContext context) {
    if (buttonType == ButtonType.login) {
      // 点击前是登陆类型，则切换为注册类型
      buttonType = ButtonType.register;
      // switchButtonTypeDesc = '已有账号，去登录';
      switchButtonTypeDesc = StringsConstant.switchButtonLoginDesc.tr;
      buttonTypeDesc = StringsConstant.registerContent.tr;
    } else {
      // 点击前是注册类型，则切换为登录类型
      buttonType = ButtonType.login;
      // switchButtonTypeDesc = '没有账号，去注册';
      switchButtonTypeDesc = StringsConstant.switchButtonRegisterDesc.tr;
      buttonTypeDesc = StringsConstant.loginContent.tr;
    }
    // 清空输入框
    userName = "";
    password = "";
    ensurePassword = "";
    textEditingControllerUserName.clear();
    textEditingControllerUserPassword.clear();
    textEditingControllerUserEnsurePassword.clear();
    KeyboardUtils.hideKeyboard(context);
  }

  /// 登录
  void goToLoginRegister() {
    if (userName.toString().trim().isEmpty) {
      Fluttertoast.showToast(msg: StringsConstant.userNameEmptyInfo.tr);
      return;
    }

    if (password.toString().trim().isEmpty) {
      Fluttertoast.showToast(msg: StringsConstant.passwordEmptyInfo.tr);
      return;
    }

    if (buttonType == ButtonType.register) {
      if (ensurePassword.toString().trim().isEmpty) {
        Fluttertoast.showToast(msg: StringsConstant.ensurePasswordEmptyInfo.tr);
        return;
      }

      if (userName.toString().trim().isNotEmpty &&
          password.toString().trim().isNotEmpty &&
          ensurePassword.toString().trim().isNotEmpty) {
        if (password.toString().trim() != ensurePassword.toString().trim()) {
          Fluttertoast.showToast(msg: StringsConstant.ensurePasswordFail.tr);
          return;
        }
      }
    }

    /// 登录 POST https://www.wanandroid.com/user/login
    /// 参数：username，password   登录后会在cookie中返回账号密码，只要在客户端做cookie持久化存储即可自动登录验证。
    /// 简单做法，存储账号密码（demo）
    var paramsLogin = {
      "username": userName.toString().trim(),
      "password": password.toString().trim(),
    };

    var paramsRegister = {
      "username": userName.toString().trim(),
      "password": password.toString().trim(),
      "repassword": ensurePassword.toString().trim(),
    };

    /// FormData参数
    dio.FormData formData = buttonType == ButtonType.login
        ? dio.FormData.fromMap(paramsLogin)
        : dio.FormData.fromMap(paramsRegister);

    String requestUrl = buttonType == ButtonType.login
        ? RequestApi.goToLogin
        : RequestApi.gotoRegister;

    httpManager(
      loadingType: Constant.showLoadingDialog,
      future:
          DioUtil().request(requestUrl, method: DioMethod.post, data: formData),
      onSuccess: (value) {
        UserInfoModel userInfoModel = UserInfoModel.fromJson(value);
        LoggerUtil.d('login success : ${userInfoModel.toJson()}');
        EasyLoading.showSuccess(StringsConstant.loginSuccess.tr);
        // 保存用户数据
        SpUtil.saveUserInfo(userInfoModel);
        appStateController.updateUserInfo();
        // 保存登录状态true
        loginState = true;
        Get.back();
      },
      onFail: (response) {
        EasyLoading.showError(
            '${StringsConstant.loginFail.tr} \n ${response.message}');
      },
      onError: (error) {
        EasyLoading.showError(
            '${StringsConstant.loginFail.tr} \n ${error.message}');
      },
    );
  }
}
