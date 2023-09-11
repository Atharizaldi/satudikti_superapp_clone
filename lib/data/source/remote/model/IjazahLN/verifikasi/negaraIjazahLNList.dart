class NegaraIjazahLNList {
  NegaraIjazahLNList({
    required this.data,
    required this.message,
  });
  late final Data data;
  late final String message;

  NegaraIjazahLNList.fromJson(Map<String, dynamic> json) {
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
    required this.negara,
  });
  late final List<Negara> negara;

  Data.fromJson(Map<String, dynamic> json) {
    negara = List.from(json['negara']).map((e) => Negara.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['negara'] = negara.map((e) => e.toJson()).toList();
    return _data;
  }
}

class Negara {
  Negara({
    required this.negaraId,
    required this.negaraName,
  });
  late final String negaraId;
  late final String negaraName;

  Negara.fromJson(Map<String, dynamic> json) {
    try {
      negaraId = json['negara_id'];
      negaraName = json['negara_name'];
    } catch (e) {}
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['negara_id'] = negaraId;
    _data['negara_name'] = negaraName;
    return _data;
  }
}
