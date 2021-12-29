import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:flutter_wan_android_getx/model/article_data_model.dart';
import 'package:flutter_wan_android_getx/page/home/home_controller.dart';
import 'package:flutter_wan_android_getx/routes/app_routes.dart';
import 'package:flutter_wan_android_getx/widget/cached_network_image_view.dart';
import 'package:get/get.dart';

/// 类名: home_banner.dart
/// 创建日期: 12/15/21 on 6:05 PM
/// 描述: Home Banner
/// 作者: 杨亮

class HomeBannerWidget extends GetView<HomeController> {
  const HomeBannerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Swiper(
        loop: true,
        autoplay: true,
        //scale：两侧item的缩放比
        scale: 0.95,
        //viewportFraction：视图宽度，即显示的item的宽度屏占比
        viewportFraction: 0.85,
        //指示器
        pagination: const SwiperPagination(
          alignment: Alignment.bottomRight,
          margin: EdgeInsets.only(
            bottom: 10,
            right: 30,
          ),
          // builder: SwiperPagination.dots,
          builder: SwiperPagination.fraction,
        ),
        itemCount: controller.homeBannerList.length,
        itemBuilder: (context, index) {
          return bannerItemView(index);
        },
        onTap: (index) {
          var homeBannerModel = controller.homeBannerList[index];
          // 构造Bean对象
          ArticleDataModelDatas model = ArticleDataModelDatas();
          model.id = homeBannerModel.id;
          model.title = homeBannerModel.title;
          model.type = homeBannerModel.type;
          model.envelopePic = homeBannerModel.imagePath;
          model.link = homeBannerModel.url;
          // 跳转文章详情Web页
          Get.toNamed(
            AppRoutes.articleDetailPage,
            arguments: {
              "data": model,
              "index": index,
              "showCollect":false,
            },
          );
        },
      );
    });
  }

  Widget bannerItemView(int index) {
    return CachedNetworkImageView(
      visible:
          controller.homeBannerList[index].imagePath != null ? true : false,
      borderRadius: 10,
      imageUrl: controller.homeBannerList[index].imagePath,
      fit: BoxFit.cover,
      width: Get.width,
      height: 120.h,
    );
  }
}
