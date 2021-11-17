import 'package:dio/dio.dart';
import 'package:flutter_wan_android_getx/http/base_response.dart';
import 'package:flutter_wan_android_getx/http/handle_dio_error.dart';
import 'package:flutter_wan_android_getx/http/request_api.dart';
import 'package:flutter_wan_android_getx/utils/logger_util.dart';
import 'package:get/get.dart' as get_x;

/// 自定义拦截器

/// 1、错误统一处理
/// 我们发现虽然Dio框架已经封装了一个DioError类库，但如果需要对返回的错误进行统一弹窗处理或者路由跳转等就只能自定义了;

/// 2、请求前统一处理
/// 在我们发送请求的时候会碰到几种情况，比如需要对非open开头的接口自动加上一些特定的参数，获取需要在请求头增加统一的token;

/// 3、响应前统一处理
/// 在我们请求接口前可以对响应数据进行一些基础的处理，比如对响应的结果进行自定义封装，还可以针对单独的url 做特殊处理等。

class DioInterceptors extends Interceptor {
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    // ///////// 业务需求 /////////
    // //对非open的接口的请求参数全部增加userId
    // if (!options.path.contains("open")) {
    //   options.queryParameters["userId"] = "xxx";
    // }
    //
    // //头部添加token
    // options.headers["token"] = "xxx";
    //
    // //更多业务需求
    //
    // ///////// 业务需求 /////////

    /// 重点
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {
    ///////////// 根据公司的业务需求进行定制化处理 /////////////
    if (response.requestOptions.baseUrl.contains(RequestApi.baseUrl)) {
      //请求成功时对数据做基本处理 BaseUrl
      if (response.statusCode == 200) {
        if (response.data['errorCode'] == 0) {
          LoggerUtil.d("=======> wan success");
          response.data = BaseResponse(
            code: BaseResponseCode.success,
            message: '数据请求成功啦!',
            success: true,
            data: response.data['data'],
          );
        } else {
          LoggerUtil.d("=======> wan fail");
          response.data = BaseResponse(
            code: BaseResponseCode.error,
            message: "数据请求失败啦! ${response.data['errorMsg']}",
            success: false,
            data: null,
          );
          throw ResultException(
              response.data['errorCode'], response.data['errorMsg']);
        }
      } else {
        LoggerUtil.d("=======> wan error");
        response.data = BaseResponse(
          code: BaseResponseCode.error,
          message: "数据请求失败啦! ${response.data['errorMsg']}",
          success: false,
          data: null,
        );
        throw ResultException(
            response.data['errorCode'], response.data['errorMsg']);
      }
    }

    //对某些单独的url返回数据做特殊处理
    // if (response.requestOptions.baseUrl.contains("https://www.mxnzp.com")) {
    if (response.requestOptions.baseUrl.contains(RequestApi.mxnzpBaseUrl)) {
      if (response.statusCode == 200) {
        if (response.data['code'] == 1) {
          LoggerUtil.d("=======> mxnzp success");
          response.data = BaseResponse(
            code: BaseResponseCode.success,
            message: '数据请求成功啦!',
            success: true,
            data: response.data['data'],
          );
        } else {
          LoggerUtil.d("=======> mxnzp fail");
          response.data = BaseResponse(
            code: BaseResponseCode.error,
            message: "数据请求失败啦! ${response.data['msg']}",
            success: false,
            data: null,
          );
          throw ResultException(response.data['code'], response.data['msg']);
        }
      } else {
        LoggerUtil.d("=======> mxnzp error");
        response.data = BaseResponse(
          code: BaseResponseCode.error,
          message: "数据请求失败啦! ${response.data['msg']}",
          success: false,
          data: null,
        );
        throw ResultException(response.data['code'], response.data['msg']);
      }
    }

    ///////////// 根据公司的业务需求进行定制化处理 /////////////

    handler.next(response);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    ErrorEntity? errorEntity = createErrorEntity(err);
    if (errorEntity != null) {
      get_x.Get.snackbar(
          '提示', '${errorEntity.code}  ${errorEntity.errorMessage}');
      LoggerUtil.e(
          'Dio Request onError ====> errCode: ${errorEntity.code} errMsg: ${errorEntity.errorMessage}');
    }

    // switch(errorEntity.code){
    //   case 401 :
    //     //没有权限，重新登陆
    //     break;
    //
    //   default:
    // }

    handler.next(err); //continue

    super.onError(err, handler);
  }

  /// 错误信息 Error统一处理
  static ErrorEntity? createErrorEntity(DioError error) {
    switch (error.type) {
      case DioErrorType.cancel:
        return ErrorEntity(code: -1, errorMessage: "请求取消");

      case DioErrorType.connectTimeout:
        return ErrorEntity(code: -1, errorMessage: "连接超时");

      case DioErrorType.sendTimeout:
        return ErrorEntity(code: -1, errorMessage: "请求超时");

      case DioErrorType.receiveTimeout:
        return ErrorEntity(code: -1, errorMessage: "响应超时");

      case DioErrorType.response:
        try {
          int? errCode = error.response?.statusCode;
          var errMsg = error.message;
          LoggerUtil.e(
              'Dio Request onError DioErrorType.response : errCode: $errCode  errMsg: $errMsg');
          switch (errCode) {
            case 400:
              return ErrorEntity(code: errCode, errorMessage: "请求语法错误");
            case 401:
              return ErrorEntity(code: errCode, errorMessage: "没有权限");
            case 403:
              return ErrorEntity(code: errCode, errorMessage: "服务器拒绝执行");
            case 404:
              return ErrorEntity(code: errCode, errorMessage: "无法连接服务器");
            case 405:
              return ErrorEntity(code: errCode, errorMessage: "请求方法被禁止");
            case 500:
              return ErrorEntity(code: errCode, errorMessage: "服务器内部错误");
            case 502:
              return ErrorEntity(code: errCode, errorMessage: "无效的请求");
            case 503:
              return ErrorEntity(code: errCode, errorMessage: "服务器挂了");
            case 505:
              return ErrorEntity(code: errCode, errorMessage: "不支持HTTP协议请求");
            default:
              // return ErrorEntity(code: errCode, errorMessage: "未知错误");
              return ErrorEntity(
                code: errCode,
                errorMessage: error.response?.statusMessage,
              );
          }
        } on Exception catch (_) {
          return ErrorEntity(code: -1, errorMessage: "未知错误");
        }

      case DioErrorType.other:
        //other 其他错误类型
        var errMsg = error.message;
        var response = error.response;
        int? errCode;
        if (response != null) {
          errCode = error.response!.statusCode;
        }

        LoggerUtil.e(
            'Dio Request onError DioErrorType.response :  errMsg: $errMsg  errCode: $errCode');

        ErrorEntity? errorEntity;
        if (errMsg.contains('SocketException')) {
          errorEntity =
              ErrorEntity(code: errCode ?? 404, errorMessage: "网络异常，请检查你的网络!");
        } else if (errMsg.contains('HttpException')) {
          errorEntity =
              ErrorEntity(code: errCode ?? 404, errorMessage: "服务器异常");
        } else if (errMsg.contains('FormatException')) {
          errorEntity =
              ErrorEntity(code: errCode ?? 404, errorMessage: "数据解析错误!");
        }
        return errorEntity;

      default:
        return ErrorEntity(code: -1, errorMessage: error.message);
    }
  }
}
