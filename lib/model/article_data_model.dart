import 'package:flutter_wan_android_getx/generated/json/base/json_convert_content.dart';

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
	String? author;
	bool? canEdit;
	int? chapterId;
	String? chapterName;
	bool? collect;
	int? courseId;
	String? desc;
	String? descMd;
	String? envelopePic;
	bool? fresh;
	String? host;
	int? id;
	String? link;
	String? niceDate;
	String? niceShareDate;
	String? origin;
	String? prefix;
	String? projectLink;
	int? publishTime;
	int? realSuperChapterId;
	int? selfVisible;
	int? shareDate;
	String? shareUser;
	int? superChapterId;
	String? superChapterName;
	List<ArticleDataModelDatasTags>? tags;
	String? title;
	int? type;
	int? userId;
	int? visible;
	int? zan;
}

class ArticleDataModelDatasTags with JsonConvert<ArticleDataModelDatasTags> {
	String? name;
	String? url;
}
