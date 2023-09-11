import 'package:collection/collection.dart';

class GetAkreditasiPT {
  GetAkreditasiPT({
    required this.data,
    required this.message,
  });
  late final Data data;
  late final String message;

  GetAkreditasiPT.fromJson(Map<String, dynamic> json) {
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
    return other is GetAkreditasiPT &&
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
    required this.akreditasi,
  });
  late final List<Akreditasi> akreditasi;

  Data.fromJson(Map<String, dynamic> json) {
    akreditasi = List.from(json['akreditasi'])
        .map((e) => Akreditasi.fromJson(e))
        .toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['akreditasi'] = akreditasi.map((e) => e.toJson()).toList();
    return _data;
  }

  @override
  bool operator ==(Object other) {
    return other is Data &&
        IterableEquality().equals(akreditasi, other.akreditasi);
  }
  @override
  int get hashCode {
    return const IterableEquality().hash(akreditasi);
  }

}

class Akreditasi {
  Akreditasi({
    required this.nilai,
  });
  late final String nilai;

  Akreditasi.fromJson(Map<String, dynamic> json) {
    nilai = json['nilai'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['nilai'] = nilai;
    return _data;
  }

  @override
  bool operator ==(Object other) {
    return other is Akreditasi && nilai == other.nilai;
  }
  @override
  int get hashCode {
    return nilai.hashCode;
  }
}