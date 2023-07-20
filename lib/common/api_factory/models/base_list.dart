class BaseListModel {
  int? id;
  String? name;
  bool isSelected = false;

  BaseListModel({this.id, this.name, this.isSelected = false});

  factory BaseListModel.fromJson(Map<String, dynamic> json) {
    return BaseListModel(
      id: json['id'],
      name: json['name'],
      isSelected: false,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}
