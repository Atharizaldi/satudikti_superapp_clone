class PtIjazahLNList {
  PtIjazahLNList({
    required this.data,
    required this.message,
  });
  late final Data data;
  late final String message;

  PtIjazahLNList.fromJson(Map<String, dynamic> json) {
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
    required this.perguruanTinggi,
  });
  late final List<PerguruanTinggi> perguruanTinggi;

  Data.fromJson(Map<String, dynamic> json) {
    perguruanTinggi = List.from(json['perguruan_tinggi'])
        .map((e) => PerguruanTinggi.fromJson(e))
        .toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['perguruan_tinggi'] = perguruanTinggi.map((e) => e.toJson()).toList();
    return _data;
  }
}

class PerguruanTinggi {
  PerguruanTinggi({
    required this.negaraId,
    required this.negaraName,
    required this.ptId,
    required this.ptName,
  });
  late final String negaraId;
  late final String negaraName;
  late final String ptId;
  late final String ptName;

  PerguruanTinggi.fromJson(Map<String, dynamic> json) {
    negaraId = json['negara_id'];
    negaraName = json['negara_name'];
    ptId = json['pt_id'];
    ptName = json['pt_name'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['negara_id'] = negaraId;
    _data['negara_name'] = negaraName;
    _data['pt_id'] = ptId;
    _data['pt_name'] = ptName;
    return _data;
  }
}
