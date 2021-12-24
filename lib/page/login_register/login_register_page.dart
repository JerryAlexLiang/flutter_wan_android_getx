import 'package:flutter/material.dart';
import 'package:flutter_wan_android_getx/res/gaps.dart';
import 'package:flutter_wan_android_getx/res/r.dart';
import 'package:flutter_wan_android_getx/res/strings.dart';
import 'package:flutter_wan_android_getx/theme/app_theme.dart';
import 'package:flutter_wan_android_getx/utils/keyboard_util.dart';
import 'package:flutter_wan_android_getx/widget/custom_app_bar.dart';
import 'package:flutter_wan_android_getx/widget/edit_widget.dart';
import 'package:flutter_wan_android_getx/widget/ripple_view.dart';
import 'package:get/get.dart';

import 'login_register_controller.dart';

/// 类名: login_register_page.dart
/// 创建日期: 12/7/21 on 4:25 PM
/// 描述: 注册登录
/// 作者: 杨亮

class LoginRegisterPage extends StatelessWidget {
  /// 登录注册
  final controller = Get.put(LoginRegisterController());

  LoginRegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(R.iconSplashBg), fit: BoxFit.cover),
        ),
        child: ListView(
          children: [
            Obx(() {
              return CustomAppBar(
                centerTitle: controller.buttonType == ButtonType.login
                    ? StringsConstant.loginContent.tr
                    : StringsConstant.registerContent.tr,
                isBack: true,
                backImageColor: Colors.white,
                titleStyle:
                    context.subtitle1Style?.copyWith(color: Colors.white),
                backgroundColor: Colors.transparent,
              );
            }),
            Gaps.vGap15,
            const FlutterLogo(
              size: 100,
            ),
            Gaps.vGap32,
            // 用户名
            _inputUserName(),
            // 密码
            _inputPassword(),
            // 确认密码
            _inputEnsurePassword(),
            Gaps.vGap15,
            // 登录按钮
            _loginButton(),
            _infoText(),
            Gaps.vGap32,
            // 登录注册切换按钮
            _switchLoginRegisterTypeButton(context),
          ],
        ),
      ),
    );
  }

  /// 用户名
  Widget _inputUserName() {
    return EditWidget(
      textEditingController: controller.textEditingControllerUserName,
      iconWidget: const Icon(
        Icons.person_outline,
        color: Colors.white,
      ),
      hintText: StringsConstant.editUserNameHint.tr,
      keyboardType: TextInputType.text,
      onChanged: (value) => controller.userName = value,
    );
  }

  /// 密码
  Widget _inputPassword() {
    return EditWidget(
      textEditingController: controller.textEditingControllerUserPassword,
      iconWidget: const Icon(
        Icons.lock_outline,
        color: Colors.white,
      ),
      hintText: StringsConstant.editPasswordHint.tr,
      showPasswordType: true,
      onChanged: (value) => controller.password = value,
    );
  }

  /// 确认密码
  Widget _inputEnsurePassword() {
    return Obx(() {
      return Visibility(
        visible: controller.buttonType == ButtonType.register ? true : false,
        child: EditWidget(
          textEditingController:
              controller.textEditingControllerUserEnsurePassword,
          iconWidget: const Icon(
            Icons.lock_outline,
            color: Colors.white,
          ),
          hintText: StringsConstant.editEnsurePasswordHint.tr,
          showPasswordType: true,
          onChanged: (value) => controller.ensurePassword = value,
        ),
      );
    });
  }

  /// 登录按钮
  Widget _loginButton() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 25),
      child: MaterialButton(
        height: 45,
        color: Colors.blue,
        textColor: Colors.white,
        splashColor: Colors.red,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        onPressed: () => {
          KeyboardUtils.hideKeyboard(Get.context!),
          controller.goToLoginRegister(),
        },
        child: Obx(() {
          return Text(
            controller.buttonTypeDesc,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          );
        }),
      ),
    );
  }

  /// 登录注册切换按钮
  Widget _switchLoginRegisterTypeButton(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: RippleView(
        color: Colors.transparent,
        radius: 20,
        onTap: () => controller.switchLoginRegister(context),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.transparent.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          child: Obx(() {
            return Text(
              controller.switchButtonTypeDesc,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 15,
              ),
            );
          }),
        ),
      ),
    );
  }

  Widget _infoText() {
    return Obx(() {
      return Visibility(
        visible: controller.buttonType == ButtonType.register,
        child: Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
          child: RichText(
            text: TextSpan(children: [
              const WidgetSpan(
                alignment: PlaceholderAlignment.middle,
                child: Icon(
                  Icons.info_outline,
                  size: 15,
                  color: Colors.red,
                ),
              ),
              const WidgetSpan(
                alignment: PlaceholderAlignment.middle,
                child: Gaps.hGap5,
              ),
              WidgetSpan(
                alignment: PlaceholderAlignment.middle,
                child: Text(
                  StringsConstant.loginRegisterInfo.tr,
                  style: const TextStyle(
                    color: Colors.red,
                    fontSize: 12,
                  ),
                ),
              ),
            ]),
          ),
        ),
      );
    });
  }
}
