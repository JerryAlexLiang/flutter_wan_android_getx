import 'package:flutter_wan_android_getx/generated/json/base/json_convert_content.dart';
import 'package:get/get.dart';

/// 类名: article_data_model.dart
/// 创建日期: 11/19/21 on 2:27 PM
/// 描述: 文章接口Model
/// 作者: 杨亮

class ArticleDataModel with JsonConvert<ArticleDataModel> {
  int? curPage;
  List<ArticleDataModelDatas>? datas;
  int? offset;
  bool? over;
  int? pageCount;
  int? size;
  int? total;
}

class ArticleDataModelDatas with JsonConvert<ArticleDataModelDatas> {
  String? apkLink;
  int? audit;
  String? author; // 作者
  bool? canEdit;
  int? chapterId;
  String? chapterName; // 分类副名称
  bool? collect; // 是否收藏
  int? courseId;
  String? desc; // 简述
  String? descMd;
  String? envelopePic; // 封面
  bool? fresh; // 新条目
  String? host;
  int? id;
  String? link;
  String? niceDate; // 分享时间（格式化）
  String? niceShareDate;
  String? origin;
  String? prefix;
  String? projectLink;
  int? publishTime;
  int? realSuperChapterId;
  int? selfVisible;
  int? shareDate;
  String? shareUser; // 分享作者
  int? superChapterId;
  String? superChapterName; // 分类主名称
  List<ArticleDataModelDatasTags>? tags; // 分类
  String? title; // 主标题
  int? type;
  int? userId;
  int? visible;
  int? zan;

  /// 可观察变量 isCollect 是否收藏
  final _isCollect = false.obs;

  get isCollect => _isCollect.value;

  set isCollect(value) => _isCollect.value = value;
}

class ArticleDataModelDatasTags with JsonConvert<ArticleDataModelDatasTags> {
  String? name; // 分类名称
  String? url; // 分类路由
}
