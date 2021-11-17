import 'package:flutter_wan_android_getx/http/handle_dio_error.dart';
import 'package:flutter_wan_android_getx/utils/connectivity_utils.dart';
import 'package:flutter_wan_android_getx/utils/logger_util.dart';
import 'package:flutter_wan_android_getx/widget/state/load_state.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

/// 类名: base_getx_controller.dart
/// 创建日期: 11/16/21 on 3:04 PM
/// 描述: BaseGetController
/// 作者: 杨亮

class BaseGetXController extends GetxController {
  /// 加载状态
  final _loadState = LoadState.simpleLoading.obs;

  get loadState => _loadState.value;

  set loadState(value) => _loadState.value = value;

  /// 错误提示
  final _httpErrorMsg = ''.obs;

  get httpErrorMsg => _httpErrorMsg.value;

  set httpErrorMsg(value) => _httpErrorMsg.value = value;

  @override
  void onReady() async {
    super.onReady();
    var connectivityState = await ConnectivityUtils.checkConnectivity();

    LoggerUtil.d('BaseGetController ==> checkConnectivity $connectivityState');

    if (connectivityState != ConnectivityState.none) {
      onReadyInitData();
      LoggerUtil.d('BaseGetController ==> onReady() initData');
    } else {
      Get.snackbar('提示', '网络异常，请检查你的网络!');
      LoggerUtil.d('BaseGetController ==> onReady() errorNet');
      loadState = LoadState.fail;
      // httpErrorMsg = '网络异常，请检查你的网络';
      httpErrorMsg = '未连接网络';
    }
  }

  /// onReady() 时期请求数据
  void onReadyInitData() {}

  void refreshData() {}

  void handleRequest({
    required bool isLoading,
    required bool isSimpleLoading,
    required Future<dynamic> future,
    required Function(dynamic value) success,
  }) async {
    Fluttertoast.showToast(msg: 'start load');
    if (isLoading) {
      if (isSimpleLoading) {
        loadState = LoadState.simpleLoading;
      } else {
        loadState = LoadState.multipleLoading;
      }
    }
    await Future.delayed(const Duration(seconds: 1));

    future.then((value) {
      Fluttertoast.showToast(msg: 'start load');

      /// 网络请求成功
      success(value);
    }).onError<ResultException>((error, stackTrace) {
      /// 网络请求失败
      if (isLoading) {
        // 加载状态设置为fail
        loadState = LoadState.fail;
        // LoadErrorMsg 文字内容
        httpErrorMsg = '${error.code}  ${error.message}';
      }
      LoggerUtil.e(
          'BaseGetController onError ====> errCode: ${error.code} ${error.message}');
    });
  }
}
