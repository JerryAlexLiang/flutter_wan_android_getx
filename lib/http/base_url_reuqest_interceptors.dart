import 'package:dio/dio.dart';
import 'package:flutter_wan_android_getx/http/request_api.dart';

/// 该拦截器用来检查是否是不同域名的请求，如果不是同一域名，则不适用于初始化时配置的BaseUrl
class BaseUrlRequestInterceptors extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    String? baseUrl = options.extra['newBaseUrl'];
    if (baseUrl != null && baseUrl.isNotEmpty) {
      options.baseUrl = baseUrl;

      // if (baseUrl.startsWith("https://www.mxnzp.com")) {
      if (baseUrl.startsWith(RequestApi.mxnzpBaseUrl)) {
        options.headers = {
          "app_id": "dlgpsborkcrsfpkl",
          "app_secret": "MGlJSnVRaW5oU0M1U3JvSjkyUjU1UT09",
        };
      }
    }
    handler.next(options);
  }
}
