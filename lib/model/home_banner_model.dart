/// 类名: home_banner_model.dart
/// 创建日期: 12/15/21 on 5:40 PM
/// 描述: 首页Banner
/// 作者: 杨亮

class HomeBannerModel {
  String? desc;
  int? id;
  String? imagePath;
  int? isVisible;
  int? order;
  String? title;
  int? type;
  String? url;

  HomeBannerModel(
      {this.desc,
        this.id,
        this.imagePath,
        this.isVisible,
        this.order,
        this.title,
        this.type,
        this.url});

  HomeBannerModel.fromJson(Map<String, dynamic> json) {
    desc = json['desc'];
    id = json['id'];
    imagePath = json['imagePath'];
    isVisible = json['isVisible'];
    order = json['order'];
    title = json['title'];
    type = json['type'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['desc'] = desc;
    data['id'] = id;
    data['imagePath'] = imagePath;
    data['isVisible'] = isVisible;
    data['order'] = order;
    data['title'] = title;
    data['type'] = type;
    data['url'] = url;
    return data;
  }
}

