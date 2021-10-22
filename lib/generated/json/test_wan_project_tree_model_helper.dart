import 'package:flutter_wan_android_getx/test/test_wan_project_tree_model.dart';

testWanProjectTreeModelFromJson(TestWanProjectTreeModel data, Map<String, dynamic> json) {
	if (json['children'] != null) {
		data.children = (json['children'] as List).map((v) => v).toList().cast<dynamic>();
	}
	if (json['courseId'] != null) {
		data.courseId = json['courseId'] is String
				? double.tryParse(json['courseId'])
				: json['courseId'].toDouble();
	}
	if (json['id'] != null) {
		data.id = json['id'] is String
				? double.tryParse(json['id'])
				: json['id'].toDouble();
	}
	if (json['name'] != null) {
		data.name = json['name'].toString();
	}
	if (json['order'] != null) {
		data.order = json['order'] is String
				? double.tryParse(json['order'])
				: json['order'].toDouble();
	}
	if (json['parentChapterId'] != null) {
		data.parentChapterId = json['parentChapterId'] is String
				? double.tryParse(json['parentChapterId'])
				: json['parentChapterId'].toDouble();
	}
	if (json['userControlSetTop'] != null) {
		data.userControlSetTop = json['userControlSetTop'];
	}
	if (json['visible'] != null) {
		data.visible = json['visible'] is String
				? double.tryParse(json['visible'])
				: json['visible'].toDouble();
	}
	return data;
}

Map<String, dynamic> testWanProjectTreeModelToJson(TestWanProjectTreeModel entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['children'] = entity.children;
	data['courseId'] = entity.courseId;
	data['id'] = entity.id;
	data['name'] = entity.name;
	data['order'] = entity.order;
	data['parentChapterId'] = entity.parentChapterId;
	data['userControlSetTop'] = entity.userControlSetTop;
	data['visible'] = entity.visible;
	return data;
}