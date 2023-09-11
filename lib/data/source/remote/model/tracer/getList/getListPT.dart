class GetTracerListPT {
  GetTracerListPT({
    required this.data,
    required this.message,
  });

  late final List<DataPtTracer> data;
  late final String message;

  GetTracerListPT.fromJson(Map<String, dynamic> json) {
    data =
        List.from(json['data']).map((e) => DataPtTracer.fromJson(e)).toList();
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['data'] = data.map((e) => e.toJson()).toList();
    _data['message'] = message;
    return _data;
  }

  @override
  bool operator ==(Object other) {
    return other is GetTracerListPT &&
        data == other.data &&
        message == other.message;
  }
  @override
  int get hashCode {
    return data.hashCode ^ message.hashCode;
  }

}

class DataPtTracer {
  DataPtTracer({
    required this.kodePt,
    required this.namaPt,
  });

  late final String kodePt;
  late final String namaPt;

  DataPtTracer.fromJson(Map<String, dynamic> json) {
    kodePt = json['kode_pt'];
    namaPt = json['nama_pt'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['kode_pt'] = kodePt;
    _data['nama_pt'] = namaPt;
    return _data;
  }

  @override
  bool operator ==(Object other) {
    return other is DataPtTracer &&
    kodePt == other.kodePt &&
    namaPt == other.namaPt;
  }
  @override
  int get hashCode {
    return kodePt.hashCode ^ namaPt.hashCode;
  }
  
}
