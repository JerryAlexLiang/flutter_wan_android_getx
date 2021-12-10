/// 类名: user_info_model.dart
/// 创建日期: 12/9/21 on 3:06 PM
/// 描述: 登录返回信息
/// 作者: 杨亮

class UserInfoModel {
  bool? admin;
  List<int?>? chapterTops;
  int? coinCount;
  List<int?>? collectIds;
  String? email;
  String? icon;
  int? id;
  String? nickname;
  String? password;
  String? publicName;
  String? token;
  int? type;
  String? username;

  UserInfoModel(
      {this.admin,
      this.chapterTops,
      this.coinCount,
      this.collectIds,
      this.email,
      this.icon,
      this.id,
      this.nickname,
      this.password,
      this.publicName,
      this.token,
      this.type,
      this.username});

  UserInfoModel.fromJson(Map<String, dynamic> json) {
    admin = json['admin'];
    chapterTops = json['chapterTops'].cast<int>();
    coinCount = json['coinCount'];
    collectIds = json['collectIds'].cast<int>();
    email = json['email'];
    icon = json['icon'];
    id = json['id'];
    nickname = json['nickname'];
    password = json['password'];
    publicName = json['publicName'];
    token = json['token'];
    type = json['type'];
    username = json['username'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['admin'] = admin;
    data['chapterTops'] = chapterTops;
    data['coinCount'] = coinCount;
    data['collectIds'] = collectIds;
    data['email'] = email;
    data['icon'] = icon;
    data['id'] = id;
    data['nickname'] = nickname;
    data['password'] = password;
    data['publicName'] = publicName;
    data['token'] = token;
    data['type'] = type;
    data['username'] = username;
    return data;
  }
}
