import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wan_android_getx/constant/constant.dart';
import 'package:flutter_wan_android_getx/utils/connectivity_utils.dart';

/// 类名: cached_network_image_view.dart
/// 创建日期: 11/25/21 on 6:14 PM
/// 描述: CachedNetworkImage组件封装
/// 作者: 杨亮

class CachedNetworkImageView extends StatelessWidget {
  const CachedNetworkImageView({
    Key? key,
    required this.visible,
    required this.borderRadius,
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

  final bool visible;
  final double? borderRadius;
  final Color borderColor;
  final double borderWidth;
  final bool isCircle;

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
      child: Container(
        decoration: imageDecorationCircle(),
        child: ClipRRect(
          borderRadius: borderRadius != null
              ? BorderRadius.circular(borderRadius!)
              : BorderRadius.circular(0),
          child: CachedNetworkImage(
            imageUrl: imageUrl!,
            fit: fit,
            width: width,
            height: height,
            placeholder: (context, url) {
              //PhysicalModel ，主要的功能就是设置widget四边圆角，可以设置阴影颜色，和z轴高度
              return PhysicalModel(
                color: placeholderColor.withOpacity(placeholderColorOpacity),
                borderRadius: borderRadius != null
                    ? BorderRadius.circular(borderRadius!)
                    : BorderRadius.circular(0),
                clipBehavior: Clip.antiAlias,
                child: SizedBox(
                  width: width,
                  height: height,
                  child: const Center(
                    child: CupertinoActivityIndicator(),
                  ),
                ),
              );
            },
            errorWidget: (context, url, error) {
              Widget? widgetError;

              ConnectivityUtils.checkConnectivity().then((value) {
                if (value != ConnectivityState.none) {
                  if (width > height) {
                    widgetError = PhysicalModel(
                      color: Colors.transparent,
                      borderRadius: borderRadius != null
                          ? BorderRadius.circular(borderRadius!)
                          : BorderRadius.circular(0),
                      clipBehavior: Clip.antiAlias,
                      child: CachedNetworkImage(
                        width: width,
                        height: height,
                        imageUrl: Constant.defaultImageUrlHorizontal,
                      ),
                    );
                  } else {
                    widgetError = PhysicalModel(
                      color: Colors.transparent,
                      borderRadius: borderRadius != null
                          ? BorderRadius.circular(borderRadius!)
                          : BorderRadius.circular(0),
                      clipBehavior: Clip.antiAlias,
                      child: CachedNetworkImage(
                        width: width,
                        height: height,
                        imageUrl: Constant.defaultImageUrlVertical,
                      ),
                    );
                  }
                } else {
                  if (width > height) {
                    widgetError = PhysicalModel(
                      color: Colors.transparent,
                      borderRadius: borderRadius != null
                          ? BorderRadius.circular(borderRadius!)
                          : BorderRadius.circular(0),
                      clipBehavior: Clip.antiAlias,
                      child: Image.asset(
                        'images/ic_background.png',
                        width: width,
                        height: height,
                        fit: fit,
                      ),
                    );
                  } else {
                    widgetError = PhysicalModel(
                      color: Colors.transparent,
                      borderRadius: borderRadius != null
                          ? BorderRadius.circular(borderRadius!)
                          : BorderRadius.circular(0),
                      clipBehavior: Clip.antiAlias,
                      child: Image.asset(
                        'images/launch_image.png',
                        width: width,
                        height: height,
                        fit: fit,
                      ),
                    );
                  }
                }
              });
              return widgetError!;
            },
          ),
        ),
      ),
    );
  }

  imageDecorationCircle() {
    return BoxDecoration(
      shape: isCircle ? BoxShape.circle : BoxShape.rectangle,
      border: Border.all(width: borderWidth, color: borderColor),
      borderRadius: isCircle
          ? null
          : borderRadius != null
              ? BorderRadius.circular(borderRadius!)
              : BorderRadius.circular(0),
      // boxShadow: const [
      //   BoxShadow(
      //     color: Colors.white,
      //     offset: Offset(0, 0),
      //     //模糊
      //     blurRadius: 3.0,
      //     //传播散布
      //     spreadRadius: 3.0,
      //   ),
      // ],
    );
  }
}
