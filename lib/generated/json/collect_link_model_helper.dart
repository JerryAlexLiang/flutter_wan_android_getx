import 'package:flutter_wan_android_getx/model/collect_link_model.dart';

collectLinkModelFromJson(CollectLinkModel data, Map<String, dynamic> json) {
	if (json['desc'] != null) {
		data.desc = json['desc'].toString();
	}
	if (json['icon'] != null) {
		data.icon = json['icon'].toString();
	}
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
	if (json['userId'] != null) {
		data.userId = json['userId'] is String
				? double.tryParse(json['userId'])
				: json['userId'].toDouble();
	}
	if (json['visible'] != null) {
		data.visible = json['visible'] is String
				? double.tryParse(json['visible'])
				: json['visible'].toDouble();
	}
	if (json['collect'] != null) {
		data.collect = json['collect'];
	}
	return data;
}

Map<String, dynamic> collectLinkModelToJson(CollectLinkModel entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['desc'] = entity.desc;
	data['icon'] = entity.icon;
	data['id'] = entity.id;
	data['link'] = entity.link;
	data['name'] = entity.name;
	data['order'] = entity.order;
	data['userId'] = entity.userId;
	data['visible'] = entity.visible;
	data['collect'] = entity.collect;
	return data;
}