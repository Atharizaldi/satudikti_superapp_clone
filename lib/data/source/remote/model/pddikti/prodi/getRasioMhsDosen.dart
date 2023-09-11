import 'package:collection/collection.dart';

class GetRasioMhsDosen {
  GetRasioMhsDosen({
    required this.data,
    required this.message,
  });
  late final Data data;
  late final String message;

  GetRasioMhsDosen.fromJson(Map<String, dynamic> json) {
    data = Data.fromJson(json['data']);
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['data'] = data.toJson();
    _data['message'] = message;
    return _data;
  }

  @override
  bool operator ==(Object other) {
    return other is GetRasioMhsDosen &&
        data == other.data &&
        message == other.message;
  }

  @override
  int get hashCode {
    return data.hashCode ^ message.hashCode;
  }
}

class Data {
  Data({
    required this.rasio,
  });
  late final List<Rasio> rasio;

  Data.fromJson(Map<String, dynamic> json) {
    rasio = List.from(json['rasio']).map((e) => Rasio.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['rasio'] = rasio.map((e) => e.toJson()).toList();
    return _data;
  }

  @override
  bool operator ==(Object other) {
    return other is Data && IterableEquality().equals(rasio, other.rasio);
  }

  @override
  int get hashCode {
    return const IterableEquality().hash(rasio);
  }
}

class Rasio {
  Rasio({
    required this.tahun,
    required this.rasio,
  });
  late final String tahun;
  late final String rasio;

  Rasio.fromJson(Map<String, dynamic> json) {
    tahun = json['tahun'] ?? '-';
    rasio = json['rasio'] ?? '-';
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['tahun'] = tahun;
    _data['rasio'] = rasio;
    return _data;
  }

  @override
  bool operator ==(Object other) {
    return other is Rasio && tahun == other.tahun && rasio == other.rasio;
  }

  @override
  int get hashCode {
    return tahun.hashCode ^ rasio.hashCode;
  }
}
