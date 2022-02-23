import 'package:flutter_wan_android_getx/generated/json/base/json_convert_content.dart';
import 'package:get/get.dart';

class CollectLinkModel with JsonConvert<CollectLinkModel> {
	String? desc;
	String? icon;
	double? id;
	String? link;
	String? name;
	double? order;
	double? userId;
	double? visible;
	bool? collect;

	/// 可观察变量 isCollect 是否收藏
	final Rx<bool>_isCollect = false.obs;

	get isCollect => _isCollect.value;

	set isCollect(value) => _isCollect.value = value;
}
