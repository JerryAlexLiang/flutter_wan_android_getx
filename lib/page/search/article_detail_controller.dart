import 'dart:async';
import 'dart:io';

import 'package:flutter_wan_android_getx/base/base_getx_controller.dart';
import 'package:flutter_wan_android_getx/constant/constant.dart';
import 'package:flutter_wan_android_getx/http/dio_method.dart';
import 'package:flutter_wan_android_getx/http/dio_util.dart';
import 'package:flutter_wan_android_getx/http/request_api.dart';
import 'package:flutter_wan_android_getx/page/search/search_controller.dart';
import 'package:flutter_wan_android_getx/utils/logger_util.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:sprintf/sprintf.dart';
import 'package:webview_flutter/webview_flutter.dart';

/// 类名: article_detail_controller.dart
/// 创建日期: 11/29/21 on 1:50 PM
/// 描述: 文章详情控制器
/// 作者: 杨亮
class ArticleDetailController extends BaseGetXController {
  /// 收藏动画显示与否
  final _collectAnimation = false.obs;

  get collectAnimation => _collectAnimation.value;

  set collectAnimation(value) => _collectAnimation.value = value;

  /// 取消收藏动画显示与否
  final _unCollectAnimation = false.obs;

  get unCollectAnimation => _unCollectAnimation.value;

  set unCollectAnimation(value) => _unCollectAnimation.value = value;

  final searchController = Get.find<SearchController>();

  late WebViewController webViewController;

  /////进度条
  final _webProgress = 0.0.obs;

  get webProgress => _webProgress.value;

  set webProgress(value) => _webProgress.value = value;

  /// 第一次进入WebView显示加载页面
  final _isFirstInitWeb = true.obs;

  get isFirstInitWeb => _isFirstInitWeb.value;

  set isFirstInitWeb(value) => _isFirstInitWeb.value = value;


  @override
  void onInit() {
    super.onInit();
    if (Platform.isAndroid) {
      WebView.platform = SurfaceAndroidWebView();
    }
  }

  /// WebView加载页面进度
  void updateWebProgress(int progress) {
    webProgress = (progress / 100).toDouble();
  }

  //WebView创建时回调
  Future<void> onWebViewCreated(WebViewController controller) async {
    //WebView控制器，通过WebViewController可以实现Web内的前进、后退等操作
    webViewController = controller;
    LoggerUtil.d('currentUrl : ${webViewController.currentUrl()}');
    // //加载一个url
    // controller.loadUrl(widget.item.link);
    // controller.canGoBack().then((value) => print('是否能后退: $value'));
    // controller.currentUrl().then((value) => print('当前Url: $value'));
    // controller.canGoForward().then((value) => print('是否能前进: $value'));
  }

  void reloadWebView() {
    // 刷新页面
    webViewController.reload();
    isFirstInitWeb = false;
  }

  Future<bool> onWillPop() async {
    //点击返回键时回调
    if (await webViewController.canGoBack()) {
      //如果WebView可以返回
      webViewController.goBack();
      //WebView返回，界面不返回
      return false;
    } else {
      //否则界面返回，且恢复第一次进入标志
      isFirstInitWeb = true;
      return true;
    }
  }

  /// 收藏、取消收藏（站内文章）  collectInsideArticle
  void collectInsideArticle(int articleId, int index) async {
    // 收藏站内文章
    var collectUrl = sprintf(RequestApi.collectInsideArticle, [articleId]);
    // 取消收藏站内文章
    var unCollectUrl = sprintf(RequestApi.unCollectInsideArticle, [articleId]);

    // 获取文章列表可观察变量 isCollect 是否收藏状态
    var currentCollectState = searchController.searchResult[index].isCollect;

    /// 当前状态为未收藏时，点击发送收藏请求，反之，发送取消收藏请求
    String requestURL =
        currentCollectState == false ? collectUrl : unCollectUrl;

    handleRequest(
        loadingType: Constant.noLoading,
        // 此接口使用sprintf插件进行String格式化操作  static const String collectInsideArticle = '/lg/collect/%s/json';
        future: DioUtil().request(requestURL, method: DioMethod.post),
        onStart: () {
          /// 点击之前状态为 未收藏 时 假状态
          if (currentCollectState == false) {
            // 显示收藏动画
            collectAnimation = true;
            searchController.searchResult[index].isCollect = true;
          } else {
            /// 点击之前状态为 已收藏 时 假状态
            // 显示加载动画
            unCollectAnimation = true;
            searchController.searchResult[index].isCollect = false;
          }
        },
        onSuccess: (response) async {
          await Future.delayed(const Duration(milliseconds: 1000));

          /// 点击之前状态为 未收藏 时
          if (currentCollectState == false) {
            // 收藏请求成功 隐藏收藏动画
            collectAnimation = false;
            searchController.searchResult[index].isCollect = true;
            Fluttertoast.showToast(msg: '收藏成功');
          } else {
            /// 点击之前状态为 已收藏 时
            // 取消收藏请求成功
            // 隐藏显示加载动画
            unCollectAnimation = false;
            searchController.searchResult[index].isCollect = false;
            Fluttertoast.showToast(msg: '取消收藏成功');
          }
        },
        onFail: (value) async {
          /// 点击之前状态为 未收藏 时 恢复状态
          if (currentCollectState == false) {
            // 收藏请求失败 隐藏收藏动画
            collectAnimation = false;
            searchController.searchResult[index].isCollect = false;
            Fluttertoast.showToast(msg: '收藏失败');
          } else {
            /// 点击之前状态为 已收藏 时  恢复状态
            // 取消收藏请求失败
            // 隐藏显示加载动画
            unCollectAnimation = false;
            searchController.searchResult[index].isCollect = true;
            Fluttertoast.showToast(msg: '取消收藏失败');
          }
        },
        onError: (value) {
          /// 点击之前状态为 未收藏 时 恢复状态
          if (currentCollectState == false) {
            //收藏请求失败  隐藏收藏动画
            searchController.searchResult[index].isCollect = false;
            collectAnimation = false;
            Fluttertoast.showToast(msg: '收藏失败');
          } else {
            /// 点击之前状态为 已收藏 时  恢复状态
            // 取消收藏请求失败
            // 隐藏显示加载动画
            unCollectAnimation = false;
            searchController.searchResult[index].isCollect = true;
            Fluttertoast.showToast(msg: '取消收藏失败');
          }
        });
  }
}
