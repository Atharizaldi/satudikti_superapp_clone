class AutoGenerate {
  AutoGenerate({
    required this.data,
    required this.message,
  });
  late final Data data;
  late final String message;

  AutoGenerate.fromJson(Map<String, dynamic> json) {
    data = Data.fromJson(json['data']);
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['data'] = data.toJson();
    _data['message'] = message;
    return _data;
  }
}

class Data {
  Data({
    required this.modul,
  });
  late final List<Modul> modul;

  Data.fromJson(Map<String, dynamic> json) {
    modul = List.from(json['modul']).map((e) => Modul.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['modul'] = modul.map((e) => e.toJson()).toList();
    return _data;
  }
}

class Modul {
  Modul({
    required this.moduleName,
    required this.moduleKeyword,
    required this.moduleDescription,
    required this.moduleWebsite,
  });
  late final String moduleName;
  late final String moduleKeyword;
  late final String moduleDescription;
  late final String moduleWebsite;

  Modul.fromJson(Map<String, dynamic> json) {
    moduleName = json['module_name'];
    moduleKeyword = json['module_keyword'];
    moduleDescription = json['module_description'];
    moduleWebsite = json['module_website'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['module_name'] = moduleName;
    _data['module_keyword'] = moduleKeyword;
    _data['module_description'] = moduleDescription;
    _data['module_website'] = moduleWebsite;
    return _data;
  }
}
