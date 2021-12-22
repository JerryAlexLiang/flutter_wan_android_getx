/// 类名: tree_model.dart
/// 创建日期: 12/22/21 on 5:43 PM
/// 描述: 体系数据-导航
/// 作者: 杨亮

class TreeModel {
  List<Children>? children;
  int? courseId;
  int? id;
  String? name;                 // 一级的名称
  int? order;
  int? parentChapterId;
  bool? userControlSetTop;
  int? visible;

  TreeModel(
      {this.children,
      this.courseId,
      this.id,
      this.name,
      this.order,
      this.parentChapterId,
      this.userControlSetTop,
      this.visible});

  TreeModel.fromJson(Map<String, dynamic> json) {
    if (json['children'] != null) {
      children = <Children>[];
      json['children'].forEach((v) {
        children!.add(Children.fromJson(v));
      });
    }
    courseId = json['courseId'];
    id = json['id'];
    name = json['name'];
    order = json['order'];
    parentChapterId = json['parentChapterId'];
    userControlSetTop = json['userControlSetTop'];
    visible = json['visible'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (children != null) {
      data['children'] = children!.map((v) => v.toJson()).toList();
    }
    data['courseId'] = courseId;
    data['id'] = id;
    data['name'] = name;
    data['order'] = order;
    data['parentChapterId'] = parentChapterId;
    data['userControlSetTop'] = userControlSetTop;
    data['visible'] = visible;
    return data;
  }
}

class Children {
  int? courseId;
  int? id;                     // id会在查看该目录下所有文章时有用
  String? name;                // 子名称
  int? order;
  int? parentChapterId;
  bool? userControlSetTop;
  int? visible;

  Children(
      {this.courseId,
      this.id,
      this.name,
      this.order,
      this.parentChapterId,
      this.userControlSetTop,
      this.visible});

  Children.fromJson(Map<String, dynamic> json) {
    courseId = json['courseId'];
    id = json['id'];
    name = json['name'];
    order = json['order'];
    parentChapterId = json['parentChapterId'];
    userControlSetTop = json['userControlSetTop'];
    visible = json['visible'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['courseId'] = courseId;
    data['id'] = id;
    data['name'] = name;
    data['order'] = order;
    data['parentChapterId'] = parentChapterId;
    data['userControlSetTop'] = userControlSetTop;
    data['visible'] = visible;
    return data;
  }
}
