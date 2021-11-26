import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wan_android_getx/utils/decoration_style.dart';

/// 类名: cached_network_image_view.dart
/// 创建日期: 11/25/21 on 6:14 PM
/// 描述: CachedNetworkImage组件封装
/// 作者: 杨亮

class CachedNetworkImageView extends StatelessWidget {
  const CachedNetworkImageView({
    Key? key,
    required this.visible,
    this.borderRadius = 0.0,
    required this.imageUrl,
    required this.fit,
    required this.width,
    required this.height,
    this.placeholderColor = Colors.grey,
    this.placeholderColorOpacity = 0.3,
    this.borderColor = Colors.transparent,
    this.borderWidth = 0.0,
    this.isCircle = false,
  }) : super(key: key);

  final bool visible; // 是否可见
  final double borderRadius; // 圆角弧度，isCircle=true时为圆形
  final Color borderColor; // 边框颜色
  final double borderWidth; // 边框宽度
  final bool isCircle; //是否为圆形

  final String? imageUrl;
  final BoxFit? fit;
  final double width;
  final double height;
  final Color placeholderColor;
  final double placeholderColorOpacity;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: visible,
      child: CachedNetworkImage(
        imageUrl: imageUrl!,
        fit: fit,
        width: width,
        height: height,
        imageBuilder: (context, imageProvider) {
          return Container(
            decoration: DecorationStyle.imageProviderDecorationCircle(
              imageProvider: imageProvider,
              fit: fit,
              isCircle: isCircle,
              borderRadius: borderRadius,
              borderWidth: borderWidth,
              borderColor: borderColor,
            ),
          );
        },
        placeholder: (context, url) {
          return Container(
            width: width,
            height: height,
            decoration: DecorationStyle.imageDecorationCircle(
              color: placeholderColor.withOpacity(placeholderColorOpacity),
              borderRadius: borderRadius,
              isCircle: isCircle,
            ),
            child: const Center(
              child: CupertinoActivityIndicator(),
            ),
          );
        },
        errorWidget: (context, url, error) {
          if (width >= height) {
            // 宽图-默认图片
            return Container(
              width: width,
              height: height,
              decoration: DecorationStyle.imageProviderDecorationCircle(
                fit: fit,
                isCircle: isCircle,
                borderRadius: borderRadius,
                borderWidth: borderWidth,
                borderColor: borderColor,
                imageProvider: const AssetImage('images/ic_background.png'),
              ),
            );
          } else {
            // 长图-默认图片
            return Container(
              width: width,
              height: height,
              decoration: DecorationStyle.imageProviderDecorationCircle(
                fit: fit,
                isCircle: isCircle,
                borderRadius: borderRadius,
                borderWidth: borderWidth,
                borderColor: borderColor,
                imageProvider: const AssetImage('images/launch_image.png'),
              ),
            );
          }
        },
      ),
    );
  }
}
