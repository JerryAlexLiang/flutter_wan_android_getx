import 'dart:convert';

import 'package:flutter_wan_android_getx/generated/json/base/json_convert_content.dart';

/// 根据服务器接口返回格式统一标准BaseResponse

class BaseResponse<T> {
  //消息（例如成功消息文字/错误消息文字）
  String? message;

  bool? success = false;

  //自定义code(可根据内部定义方式)
  int? code;

  //接口返回的数据
  T? data;

  BaseResponse({
    this.message,
    this.success,
    this.code,
    this.data,
  });

  BaseResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null && json['data'] != 'null') {
      data = JsonConvert.fromJsonAsT<T>(json['data']);
    }
    code = json['code'];
    message = json['message'];
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    // final Map<String, dynamic> data = new Map<String, dynamic>();
    // final Map<String, dynamic> data = Map<String, dynamic>();
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data;
    }
    data['code'] = code;
    data['message'] = message;
    data['success'] = success;
    return data;
  }

  @override
  String toString() {
    StringBuffer sb = StringBuffer('{');
    sb.write("\"message\":\"$message\"");
    sb.write(",\"code\":$code");
    sb.write(",\"success\":$success");
    sb.write(",\"data\":${json.encode(data)}");
    sb.write('}');
    return sb.toString();
  }
}

class BaseResponseCode {
  /// 成功
  static const int success = 0;

  /// 错误
  static const int error = 1;

  /// 更多
}

/// 异常处理
class ErrorEntity implements Exception {
  int? code;
  String? errorMessage;

  ErrorEntity({this.code, this.errorMessage});

  @override
  String toString() {
    if (errorMessage == null) return "Exception";
    return 'ErrorEntity{code: $code, errorMessage: $errorMessage}';
  }
}
