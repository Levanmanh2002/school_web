class MajorsData {
  String? sId;
  String? name;
  String? description;
  int? iV;

  MajorsData({this.sId, this.name, this.description, this.iV});

  MajorsData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    description = json['description'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    data['description'] = description;
    data['__v'] = iV;
    return data;
  }
}
