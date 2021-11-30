import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter_wan_android_getx/config/config.dart';
import 'package:flutter_wan_android_getx/http/base_url_reuqest_interceptors.dart';
import 'package:flutter_wan_android_getx/http/dio_interceptors.dart';
import 'package:flutter_wan_android_getx/http/dio_method.dart';
import 'package:flutter_wan_android_getx/http/handle_dio_error.dart';
import 'package:flutter_wan_android_getx/http/request_api.dart';
import 'package:flutter_wan_android_getx/utils/connectivity_utils.dart';
import 'package:flutter_wan_android_getx/utils/logger_util.dart';
import 'package:get/get.dart' as get_x;

/// 封装网络请求

class DioUtil {
  /// 1、设置常量变量

  /// 连接超时时间
  static const int connectTimeout = 6 * 1000;

  /// 响应超时时间
  static const int receiveTimeout = 6 * 1000;

  /// 请求的URL前缀
  static String baseUrl = RequestApi.baseUrl;

  /// 是否开启网络缓存,默认false
  static bool cacheEnable = false;

  /// 最大缓存时间(按秒), 默认缓存七天,可自行调节
  static const int maxCacheAge = 7 * 24 * 60 * 60;

  /// 最大缓存条数(默认一百条)
  static const int maxCacheCount = 100;

  /// 1、设置常量变量

  /// 2、初始化Dio

  //使用单例模式进行Dio封装
  //在每个页面中都会用到网络请求，那么如果我们每次请求的时候都去实例化一个Dio，无非是增加了系统不必要的开销，
  // 而使用单例模式对象一旦创建每次访问都是同一个对象，不需要再次实例化该类的对象.
  // // 通过静态变量的私有构造器来创建的单例模式

  static final DioUtil _instance = DioUtil._init();

  factory DioUtil() => _instance;

  /// 声明Dio变量
  late Dio _dio;

  Dio get dio => _dio;

  /// 取消请求
  final CancelToken _cancelToken = CancelToken();

  // /// cookie
  // CookieJar cookieJar = CookieJar();

  //对Dio请求进行初始化
  //对 超时时间 、响应时间 、BaseUrl 进行统一设置
  DioUtil._init() {
    //初始化基本选型
    BaseOptions options = BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: connectTimeout,
      receiveTimeout: receiveTimeout,

      /// 请求的Content-Type，默认值是"application/json; charset=utf-8".
      /// 如果您想以"application/x-www-form-urlencoded"格式编码请求数据,
      /// 可以设置此选项为 `Headers.formUrlEncodedContentType`,  这样[Dio]
      /// 就会自动编码请求体.
      contentType: 'application/json; charset=utf-8',

      /// [responseType] 表示期望以那种格式(方式)接受响应数据。
      /// 目前 [ResponseType] 接受三种类型 `JSON`, `STREAM`, `PLAIN`.
      ///
      /// 默认值是 `JSON`, 当响应头中content-type为"application/json"时，dio 会自动将响应内容转化为json对象。
      /// 如果想以二进制方式接受响应数据，如下载一个二进制文件，那么可以使用 `STREAM`.
      ///
      /// 如果想以文本(字符串)格式接收响应数据，请使用 `PLAIN`.
      responseType: ResponseType.json,
    );

    //初始化Dio
    _dio = Dio(options);

    /// 4、拦截器
    /// 通过1，2，3 已经把Restful API 风格简化成了一个方法，通过DioMethod 来标明不同的请求方式。
    /// 在我们平时开发的过程中，需要在请求前、响应前、错误时对某一些接口做特殊的处理，那我们就需要用到拦截器。
    /// Dio 为我们提供了自定义拦截器功能，很容易轻松的实现对请求、响应、错误时进行拦截。

    /// 添加拦截器
    _dio.interceptors.add(DioInterceptors());
    _dio.interceptors.add(BaseUrlRequestInterceptors());

    /// 刷新token拦截器(lock/unlock)
    //在开发过程中，客户端和服务器打交道的时候，往往会用一个token来做校验，因为每个公司处理刷新token的逻辑都不一样，
    // eg:需要给所有的请求头中添加一个refreshToken，如果refreshToken不存在，我们先去请求refreshToken，
    // 获取到refreshToken后，再发起后续请求。
    // 由于请求refreshToken的过程是异步的，我们需要在请求过程中锁定后续请求（因为它们需要refreshToken), 直到refreshToken请求成功后，再解锁
    // _dio.interceptors.add(DioTokenInterceptors());

    /// 添加转换器
    //转换器Transformer用于对请求数据和响应数据进行编解码处理。
    // Dio实现了一个默认转换器DefaultTransformer作为默认的 Transformer.
    // 如果想对请求/响应数据进行自定义编解码处理，可以提供自定义转换器.
    // _dio.transformer = DioTransformer();

    /// 添加cookie管理器 cookie的使用需要用到两个第三方组件 dio_cookie_manager 和 cookie_jar
    //由服务器生成的一小段文本信息，发送给浏览器，浏览器把cookie以k-v形式保存到本地某个目录下的文本文件内，下一次请求同一网站时会把该cookie发送给服务器。
    //1、cookie_jar：Dart 中 http 请求的 cookie 管理器，通过它您可以轻松处理复杂的 cookie 策略和持久化 cookie
    //2、dio_cookie_manager： CookieManager 拦截器可以帮助我们自动管理请求/响应 cookie。 CookieManager 依赖于 cookieJar 包
    // _dio.interceptors.add(CookieManager(cookieJar));

    /// 添加缓存拦截器
    // _dio.interceptors.add(DioCacheInterceptors());

    /// 4、拦截器

    /// 设置Http代理(设置即开启)
    // 在调试模式下需要抓包调试，所以我们使用代理，并禁用HTTPS证书校验
    if (!Config.isRelease && Config.proxyEnable) {
      (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
          (client) {
        client.findProxy = (uri) {
          return "Proxy ${Config.proxyIp}:${Config.proxyPort}";
        };
        //代理工具会提供一个抓包的自签名证书，会通不过证书校验，所以我们禁用证书校验
        client.badCertificateCallback =
            (X509Certificate cert, String host, int port) => true;
      };
    }

    if (Config.isDebug) {
      openLog();
    }
  }

  /// 2、初始化Dio

  /// 3、封装请求类

  /// 对Restful APi风格进行统一封装
  /// 不管是get()还是post()请求，Dio内部最终都会调用request方法，只是传入的method不一样，所以我们这里定义一个枚举类型在一个方法中进行处理;

  Future<T> request<T>(
    String path, {
    DioMethod method = DioMethod.get,
    Map<String, dynamic>? params,
    data,
    Options? options,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
    String? newBaseUrl,
  }) async {
    const _methodValues = {
      DioMethod.get: 'get',
      DioMethod.post: 'post',
      DioMethod.put: 'put',
      DioMethod.delete: 'delete',
      DioMethod.patch: 'patch',
      DioMethod.head: 'head',
    };

    options ??= Options(
      method: _methodValues[method],
      extra: {
        'newBaseUrl': newBaseUrl,
      },
      headers: headerToken(),
    );

    try {
      /// 请求前先检查网络连接
      var connectivityState = await ConnectivityUtils.checkConnectivity();
      LoggerUtil.d('DioUtil ==> checkConnectivity $connectivityState');
      if (connectivityState == ConnectivityState.none) {
        // 延迟1秒 显示加载loading
        await Future.delayed(const Duration(seconds: 1));
        get_x.Get.snackbar('提示', '90005 网络异常，请检查你的网络');
        throw ResultException(90005, '网络异常，请检查你的网络');
      }

      Response response;
      response = await _dio.request(
        path,
        data: data,
        queryParameters: params,
        options: options,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response.data;
    } on DioError catch (e) {
      // rethrow;
      throw HandleDioError.handleError(e);
    } finally {
      //还原BaseUrL
      _dio.options.baseUrl = baseUrl;
    }
  }

  /// 请求时添加Cookie
  Map<String, dynamic> headerToken() {
    /// 自定义header，如果需要添加token信息，则调用此参数
    // 用户信息
    //UserEntity? info = SpUtil.getUserInfo();
    //   if(info == null){
    //     return null;
    //   }


    Map<String, dynamic> httpHeaders = {
      'Cookie':
      // 'loginUserName=1935990239@qq.com;loginUserPassword=1935990239SMILE',
      'loginUserName=123456Handsome;loginUserPassword=123456',
    };

    return httpHeaders;
  }

  // ///请求类
  // Future request<T>(
  //   String path, {
  //   DioMethod method = DioMethod.get,
  //   Map<String, dynamic>? params,
  //   data,
  //   Options? options,
  //   ProgressCallback? onSendProgress,
  //   ProgressCallback? onReceiveProgress,
  //   String? newBaseUrl,
  //   required Success? success,
  //   required Fail? fail,
  // }) async {
  //   const _methodValues = {
  //     DioMethod.get: 'get',
  //     DioMethod.post: 'post',
  //     DioMethod.put: 'put',
  //     DioMethod.delete: 'delete',
  //     DioMethod.patch: 'patch',
  //     DioMethod.head: 'head',
  //   };
  //
  //   options ??= Options(
  //     method: _methodValues[method],
  //     extra: {
  //       'newBaseUrl': newBaseUrl,
  //     },
  //   );
  //
  //   try {
  //     Response response;
  //     response = await _dio.request(
  //       path,
  //       data: data,
  //       queryParameters: params,
  //       options: options,
  //       onSendProgress: onSendProgress,
  //       onReceiveProgress: onReceiveProgress,
  //     );
  //
  //     if (success != null) {
  //       success(response.data);
  //     }
  //   } on DioError catch (e) {
  //     ErrorEntity? errorEntity = DioInterceptors.createErrorEntity(e);
  //     if (fail != null) {
  //       if (errorEntity != null) {
  //         fail(errorEntity.code, errorEntity.errorMessage);
  //       }
  //     }
  //   } finally {
  //     //还原BaseUrL
  //     _dio.options.baseUrl = baseUrl;
  //   }
  // }

  /// 取消网络请求
  /// 为什么我们需要有取消请求的功能，如果当我们的页面在发送请求时，
  /// 用户主动退出当前界面或者app应用程序退出的时候数据还没有响应，那我们就需要取消该网络请求，防止不必要的错误。
  void cancelRequests({CancelToken? token}) {
    token ?? _cancelToken.cancel("cancelled");
  }

  /// 5、统一日志打印
  void openLog() {
    _dio.interceptors.add(LogInterceptor(responseBody: true));
  }

  /// 设置Http代理(设置即开启)
  void setProxy({String? proxyAddress, bool enable = false}) {
    if (enable) {
      (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
          (HttpClient client) {
        client.findProxy = (uri) {
          return proxyAddress!;
        };
        client.badCertificateCallback =
            (X509Certificate cert, String host, int port) => true;
      };
    }
  }

  /// 设置https证书校验
  void setHttpsCertificateVerification({String? pem, bool enable = false}) {
    if (enable) {
      (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
          (client) {
        client.badCertificateCallback =
            (X509Certificate cert, String host, int port) {
          if (cert.pem == pem) {
            // 验证证书
            return true;
          }
          return false;
        };
      };
    }
  }
}
