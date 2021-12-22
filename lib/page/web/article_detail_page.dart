import 'package:flutter/material.dart';
import 'package:flutter_wan_android_getx/constant/constant.dart';
import 'package:flutter_wan_android_getx/model/article_data_model.dart';
import 'package:flutter_wan_android_getx/page/search/article_detail_controller.dart';
import 'package:flutter_wan_android_getx/theme/app_color.dart';
import 'package:flutter_wan_android_getx/widget/article_detail_web_app_bar.dart';
import 'package:flutter_wan_android_getx/widget/state/favorite_lottie_widget.dart';
import 'package:flutter_wan_android_getx/widget/state/loading_lottie_rocket_widget.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ArticleDetailPage extends GetView<ArticleDetailController> {
  const ArticleDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var arguments = Get.arguments;
    final ArticleDataModelDatas model = arguments['data'];
    final bool showCollect = arguments['showCollect'];

    return WillPopScope(
      child: Scaffold(
        appBar: ArticleDetailWebAppBar(
          model: model,
          showCollect: showCollect,
        ),
        body: webViewContainer(context, model),
      ),
      onWillPop: () => controller.onWillPop(),
    );
  }

  Stack webViewContainer(BuildContext context, ArticleDataModelDatas model) {
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
