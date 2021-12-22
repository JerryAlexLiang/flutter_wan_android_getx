import 'package:flutter_wan_android_getx/model/article_data_model.dart';

/// 类名: navigation_model.dart
/// 创建日期: 12/21/21 on 6:12 PM
/// 描述: 导航
/// 作者: 杨亮

class NavigationModel {
  List<ArticleDataModelDatas>? articles;
  int? cid;
  String? name;

  NavigationModel({this.articles, this.cid, this.name});

  NavigationModel.fromJson(Map<String, dynamic> json) {
    if (json['articles'] != null) {
      articles = <ArticleDataModelDatas>[];
      json['articles'].forEach((v) {
        articles!.add(ArticleDataModelDatas().fromJson(v));
      });
    }
    cid = json['cid'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (articles != null) {
      data['articles'] = articles!.map((v) => v.toJson()).toList();
    }
    data['cid'] = cid;
    data['name'] = name;
    return data;
  }
}
