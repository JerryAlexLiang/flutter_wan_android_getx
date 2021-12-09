// import 'dart:collection';
//
// import 'package:dio/dio.dart';
// import 'package:flutter_wan_android_getx/http/dio_util.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// /// 简单的缓存策略：
// /// 1、将请求的url作为key，对请求的返回值在一个指定时间段类进行缓存，
// /// 2、另外设置一个最大缓存数，当超过最大缓存数后移除最早的一条缓存。
// /// 3、但是也得提供一种针对特定接口或请求决定是否启用缓存的机制，这种机制可以指定哪些接口或那次请求不应用缓存，
// /// 这种机制是很有必要的，比如登录接口就不应该缓存，又比如用户在下拉刷新时就不应该再应用缓存。
//
// /// 在实现缓存之前我们先定义保存缓存信息的CacheObject类
// ///
// /// 需要实现具体的缓存策略，由于我们使用的是dio package，所以我们可以直接通过拦截器来实现缓存策略：
// /// 我们在程序退出后内存缓存将会消失，所以我们用shared_preferences 进行磁盘缓存数据。
//
// class CacheObject {
//   Response response;
//
//   //缓存创建的时间
//   int timeStamp = DateTime.now().millisecondsSinceEpoch;
//
//   int pageIndex;
//
//   CacheObject(
//     this.response,
//     this.timeStamp,
//     this.pageIndex,
//   );
//
//   @override
//   int get hashCode {
//     return response.realUri.hashCode;
//   }
//
//   @override
//   bool operator ==(Object other) {
//     return response.hashCode == other.hashCode;
//   }
// }
//
// class DioCacheInterceptors extends Interceptor {
//   //为确保迭代器顺序和对象插入时间顺序一致，我们使用LinkedHashMap
//   LinkedHashMap cache = LinkedHashMap<String, CacheObject>();
//
//   late SharedPreferences preferences;
//
//   @override
//   void onRequest(
//       RequestOptions options, RequestInterceptorHandler handler) async {
//     //不开启网络缓存
//     if (!DioUtil.cacheEnable) return super.onRequest(options, handler);
//
//     //开启网络缓存
//
//     //是否刷新缓存
//     bool refresh = options.extra["refresh"] == true;
//
//     // 是否磁盘缓存
//     bool cacheDisk = options.extra["cacheDisk"] == true;
//     String key = options.extra["cacheKey"]??options.uri.toString();
//
//     // 如果是下拉刷新，先删除相关缓存
//     if (refresh) {
//       // 删除本地缓存
//       delete(options.uri.toString());
//     }
//
//     // 只有get请求才开启缓存
//     if (options.extra["noCache"] != true &&
//         options.method.toLowerCase() == 'get') {
//       String key = options.extra["cacheKey"] ?? options.uri.toString();
//       var ob = cache[key];
//       if (ob != null) {
//         // 内存缓存
//         if ((DateTime.now().millisecondsSinceEpoch - ob.timeStamp) / 1000 <
//             DioUtil.maxCacheAge) {
//           return handler.resolve(cache[key].response);
//         } else {
//           //若已过期则删除缓存，继续向服务器请求
//           cache.remove(key);
//         }
//
//         // 磁盘缓存
//       }
//     }
//     super.onRequest(options, handler);
//   }
//
//   @override
//   void onResponse(Response response, ResponseInterceptorHandler handler) async {
//     // 把响应的数据保存到缓存
//     if (DioUtil.cacheEnable) {
//       _saveCache(response);
//     }
//     super.onResponse(response, handler);
//   }
//
//   @override
//   void onError(DioError err, ErrorInterceptorHandler handler) async {
//     super.onError(err, handler);
//   }
//
//   void delete(String key) {
//     cache.remove(key);
//   }
//
//   void _saveCache(Response object) {
//     RequestOptions options = object.requestOptions;
//     if (options.extra["noCache"] != true &&
//         options.method.toLowerCase() == "get") {
//       // 如果缓存数量超过最大数量限制，则先移除最早的一条记录
//       if (cache.length == DioUtil.maxCacheCount) {
//         cache.remove(cache[cache.keys.first]);
//       }
//       String key = options.extra["cacheKey"] ?? options.uri.toString();
//       cache[key] = CacheObject(object);
//     }
//   }
// }
