import 'package:flutter_wan_android_getx/test/test_mxnzp_model.dart';

testMxnzpModelFromJson(TestMxnzpModel data, Map<String, dynamic> json) {
	if (json['origin'] != null) {
		data.origin = json['origin'].toString();
	}
	if (json['result'] != null) {
		data.result = json['result'].toString();
	}
	if (json['originLanguage'] != null) {
		data.originLanguage = json['originLanguage'].toString();
	}
	if (json['resultLanguage'] != null) {
		data.resultLanguage = json['resultLanguage'].toString();
	}
	return data;
}

Map<String, dynamic> testMxnzpModelToJson(TestMxnzpModel entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['origin'] = entity.origin;
	data['result'] = entity.result;
	data['originLanguage'] = entity.originLanguage;
	data['resultLanguage'] = entity.resultLanguage;
	return data;
}