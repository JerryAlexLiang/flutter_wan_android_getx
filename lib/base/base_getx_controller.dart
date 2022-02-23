import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_wan_android_getx/constant/constant.dart';
import 'package:flutter_wan_android_getx/http/base_response.dart';
import 'package:flutter_wan_android_getx/http/handle_dio_error.dart';
import 'package:flutter_wan_android_getx/utils/connectivity_utils.dart';
import 'package:flutter_wan_android_getx/utils/logger_util.dart';
import 'package:flutter_wan_android_getx/widget/state/load_state.dart';
import 'package:get/get.dart';

/// 类名: base_getx_controller.dart
/// 创建日期: 11/16/21 on 3:04 PM
/// 描述: 基于GetX的 BaseGetController
/// 作者: 杨亮

// /// 类型定义
// typedef Success<T> = Function(T data);
// typedef Fail = Function(int? code, String? msg);

class BaseGetXController extends GetxController {
  /// 加载状态
  final _loadState = LoadState.simpleShimmerLoading.obs;

  get loadState => _loadState.value;

  set loadState(value) => _loadState.value = value;

  /// 错误提示
  final _httpErrorMsg = ''.obs;

  get httpErrorMsg => _httpErrorMsg.value;

  set httpErrorMsg(value) => _httpErrorMsg.value = value;

  /// 收藏动画显示与否
  final _collectAnimation = false.obs;

  get collectAnimation => _collectAnimation.value;

  set collectAnimation(value) => _collectAnimation.value = value;

  /// 取消收藏动画显示与否
  final _unCollectAnimation = false.obs;

  get unCollectAnimation => _unCollectAnimation.value;

  set unCollectAnimation(value) => _unCollectAnimation.value = value;

  @override
  void onReady() async {
    super.onReady();
    var connectivityState = await ConnectivityUtils.checkConnectivity();

    LoggerUtil.d('BaseGetController ==> checkConnectivity $connectivityState');

    if (connectivityState != ConnectivityState.none) {
      onReadyInitData();
      LoggerUtil.d('BaseGetController ==> onReady() initData');
    } else {
      LoggerUtil.d('BaseGetController ==> onReady() errorNet');
      // 延迟1秒 显示加载loading
      await Future.delayed(const Duration(seconds: 1));
      Get.snackbar('提示', '网络异常，请检查你的网络!');
      loadState = LoadState.fail;
      httpErrorMsg = '网络异常，请检查你的网络';
    }
  }

  /// onReady() 时期请求数据
  void onReadyInitData() {}

  void httpManager({
    required String loadingType,
    required Future<dynamic> future,
    Function()? onStart,
    required Function(dynamic value) onSuccess,
    required Function(BaseResponse value) onFail,
    required Function(ResultException value)? onError,
  }) async {
    /// 是否显示加载页面、加载页面类型
    if (loadingType == Constant.showLoadingDialog) {
      /// 页面上加载Loading
      EasyLoading.show(status: 'loading...');
    } else if (loadingType == Constant.simpleShimmerLoading) {
      /// 覆盖页面-简单Shimmer动画
      loadState = LoadState.simpleShimmerLoading;
    } else if (loadingType == Constant.multipleShimmerLoading) {
      /// 覆盖页面-列表Shimmer动画
      loadState = LoadState.multipleShimmerLoading;
    } else if (loadingType == Constant.lottieRocketLoading) {
      loadState = LoadState.lottieRocketLoading;
    } else if (loadingType == Constant.noLoading) {
      loadState = LoadState.success;
      // return;
    }

    if (onStart != null) {
      onStart();
    }

    // await Future.delayed(const Duration(seconds: 1000));

    future.then((value) {
      LoggerUtil.d('BaseGetController ==> start handleRequest');

      /// 网络请求成功
      BaseResponse response = value;
      //拿到res.data就可以进行Json解析了，这里一般用来构造实体类
      var success = response.success;
      if (success != null) {
        if (success) {
          dismissEasyLoading();

          /// 请求成功
          var data = response.data;
          if (data != null) {
            loadState = LoadState.success;

            /// 在onSuccess()中也要判断具体的业务数据是否为空
            onSuccess(data);
          } else {
            loadState = LoadState.empty;
            dismissEasyLoading();
            onSuccess(data);
          }
          LoggerUtil.e(
              'BaseGetController handleRequest success ====> code: ${response.code}  message: ${response.message}');
        } else {
          /// 请求失败
          loadState = LoadState.fail;
          dismissEasyLoading();
          // 外部方法在后，可在方法里根据业务更改状态
          onFail(response);
          LoggerUtil.e(
              'BaseGetController handleRequest fail 1 ====> code: ${response.code} message: ${response.message}');
        }
      } else {
        /// 请求失败
        loadState = LoadState.fail;
        dismissEasyLoading();
        onFail(response);
        LoggerUtil.e(
            'BaseGetController handleRequest fail 2 ====> code: ${response.code} message: ${response.message}');
      }
    }).onError<ResultException>((error, stackTrace) {
      /// 网络请求失败
      if (loadingType != Constant.noLoading) {
        // 加载状态设置为fail
        loadState = LoadState.fail;
        // LoadErrorMsg 文字内容
        httpErrorMsg = '${error.code}  ${error.message}';
      }
      dismissEasyLoading();
      if (onError != null) {
        onError(error);
      }
      LoggerUtil.e(
          'BaseGetController handleRequest onError ====> code: ${error.code} message: ${error.message}');
    });
  }

  void dismissEasyLoading() {
    if (EasyLoading.isShow) {
      EasyLoading.dismiss();
    }
  }
}
