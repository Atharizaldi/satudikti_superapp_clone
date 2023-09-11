class Config {
  String? message;
  List<Data>? data;

  Config({this.message, this.data});

  Config.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  int? moduleId;
  String? key;
  String? value;

  Data({this.id, this.moduleId, this.key, this.value});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    moduleId = json['module_id'];
    key = json['key'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['module_id'] = this.moduleId;
    data['key'] = this.key;
    data['value'] = this.value;
    return data;
  }
}
