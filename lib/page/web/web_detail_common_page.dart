import 'package:flutter/material.dart';
import 'package:flutter_wan_android_getx/constant/constant.dart';
import 'package:flutter_wan_android_getx/model/article_data_model.dart';
import 'package:flutter_wan_android_getx/model/collect_link_model.dart';
import 'package:flutter_wan_android_getx/page/collect/collect_article_list/collect_article_list_controller.dart';
import 'package:flutter_wan_android_getx/page/collect/collect_link_list/collect_link_list_controller.dart';
import 'package:flutter_wan_android_getx/page/search/article_detail_controller.dart';
import 'package:flutter_wan_android_getx/theme/app_color.dart';
import 'package:flutter_wan_android_getx/widget/article_detail_web_app_bar.dart';
import 'package:flutter_wan_android_getx/widget/custom_app_bar.dart';
import 'package:flutter_wan_android_getx/widget/state/favorite_lottie_widget.dart';
import 'package:flutter_wan_android_getx/widget/state/loading_lottie_rocket_widget.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

/// 类名: article_detail_page.dart
/// 创建日期: 12/24/21 on 2:07 PM
/// 描述: 文章详情Web页面Common
/// 作者: 杨亮

class WebDetailCommonPage extends GetView<ArticleDetailController> {
  const WebDetailCommonPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final collectLinkController = Get.find<CollectLinkListController>();
    
    var arguments = Get.arguments;
    final CollectLinkModel model = arguments['data'];

    return WillPopScope(
      child: Scaffold(
        appBar: CustomAppBar(
          centerTitle: model.name ?? "收藏链接",
          actionIcon: Obx(() {
            return Icon(
              Icons.favorite,
              size: 24,
              color:
                  model.isCollect ? Colors.red : Colors.grey.withOpacity(0.5),
            );
          }),
          onRightPressed: () => collectLinkController.requestUnCollectLink(model),
        ),
        body: webViewContainer(context, model),
      ),
      onWillPop: () => controller.onWillPop(),
    );
  }

  Stack webViewContainer(BuildContext context, CollectLinkModel model) {
    var url = '';
    if (model.link != null) {
      if (model.link!.isNotEmpty) {
        url = model.link!;
      } else {
        url = Constant.myGitHub;
      }
    } else {
      url = Constant.myGitHub;
    }
    return Stack(
      children: [
        WebView(
          allowsInlineMediaPlayback: true,
          zoomEnabled: true,
          // 默认禁止js
          javascriptMode: JavascriptMode.unrestricted,
          // 初始url
          initialUrl: url,
          gestureNavigationEnabled: true,
          onWebViewCreated: (webController) {
            controller.onWebViewCreated(webController);
          },
          // 页面开始加载时
          onPageStarted: (String url) async {
            controller.onPageStarted(url, model.link ?? "");
          },
          onProgress: (int progress) {
            // WebView加载页面进度
            controller.updateWebProgress(progress);
          },
          onPageFinished: (url) async {
            controller.onPageFinished(url, model.link ?? "");
          },
          navigationDelegate: (NavigationRequest request) {
            if (!request.url.contains('http')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
          onWebResourceError: (WebResourceError error) {
            controller.onWebResourceError(error, url, model.link ?? "");
          },
        ),
        Obx(() {
          // WebView加载页面进度
          return Visibility(
            visible: controller.webProgress < 1,
            child: LinearProgressIndicator(
              minHeight: 1,
              backgroundColor: AppColors.bgColor,
              color: AppColors.iconLightColor,
              value: controller.webProgress,
            ),
          );
        }),
        Obx(() {
          /// 收藏动画
          return Positioned(
            top: Get.height / 5,
            left: 0,
            right: 0,
            child: FavoriteLottieWidget(
              visible: controller.collectAnimation,
              animate: controller.collectAnimation,
              repeat: false,
              width: Get.width,
              height: Get.height / 3,
            ),
          );
        }),
        Obx(() {
          return Positioned(
            top: Get.height / 5,
            left: 0,
            right: 0,
            child: LoadingLottieRocketWidget(
              visible: controller.unCollectAnimation,
              animate: controller.unCollectAnimation,
              repeat: false,
              width: Get.width,
              height: Get.height / 3,
            ),
          );
        }),
      ],
    );
  }
}
