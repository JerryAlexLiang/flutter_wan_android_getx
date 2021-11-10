import 'package:flutter_wan_android_getx/model/hot_search_model.dart';

hotSearchModelFromJson(HotSearchModel data, Map<String, dynamic> json) {
	if (json['id'] != null) {
		data.id = json['id'] is String
				? double.tryParse(json['id'])
				: json['id'].toDouble();
	}
	if (json['link'] != null) {
		data.link = json['link'].toString();
	}
	if (json['name'] != null) {
		data.name = json['name'].toString();
	}
	if (json['order'] != null) {
		data.order = json['order'] is String
				? double.tryParse(json['order'])
				: json['order'].toDouble();
	}
	if (json['visible'] != null) {
		data.visible = json['visible'] is String
				? double.tryParse(json['visible'])
				: json['visible'].toDouble();
	}
	return data;
}

Map<String, dynamic> hotSearchModelToJson(HotSearchModel entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['id'] = entity.id;
	data['link'] = entity.link;
	data['name'] = entity.name;
	data['order'] = entity.order;
	data['visible'] = entity.visible;
	return data;
}