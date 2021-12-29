import 'package:flutter/material.dart';
import 'package:flutter_wan_android_getx/app_user_login_state_controller.dart';
import 'package:flutter_wan_android_getx/page/login_register/login_register_page.dart';

/// 类名: auth_middle_page.dart
/// 创建日期: 12/10/21 on 11:10 AM
/// 描述: 登录中转页面
/// 作者: 杨亮

class AuthMiddlePage extends StatelessWidget {
  const AuthMiddlePage({
    Key? key,
    required this.child,
  }) : super(key: key);

  /// 已登录状态最重要跳转的页面
  final Widget child;

  @override
  Widget build(BuildContext context) {
    // bool? loginState = SpUtil.getLoginState();
    // bool loginState = isLogin;
    // return (loginState == true)
    //     ? child
    //     : LoginRegisterPage();

    return loginState ? child : LoginRegisterPage();
  }
}
