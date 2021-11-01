import 'package:flutter_wan_android_getx/page/model/language.dart';

languageFromJson(Language data, Map<String, dynamic> json) {
	if (json['name'] != null) {
		data.name = json['name'].toString();
	}
	if (json['language'] != null) {
		data.language = json['language'].toString();
	}
	if (json['country'] != null) {
		data.country = json['country'].toString();
	}
	if (json['isSelect'] != null) {
		data.isSelect = json['isSelect'];
	}
	return data;
}

Map<String, dynamic> languageToJson(Language entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['name'] = entity.name;
	data['language'] = entity.language;
	data['country'] = entity.country;
	data['isSelect'] = entity.isSelect;
	return data;
}