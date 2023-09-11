class MBKMList {
  MBKMList({
    required this.data,
    this.meta,
  });
  late final List<Data> data;
  late final Null meta;

  MBKMList.fromJson(Map<String, dynamic> json) {
    data = List.from(json['data']).map((e) => Data.fromJson(e)).toList();
    meta = null;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['data'] = data.map((e) => e.toJson()).toList();
    _data['meta'] = meta;
    return _data;
  }
}

class Data {
  Data({
    required this.id,
    required this.namaKegiatan,
    required this.deskripsi,
    required this.isRunning,
    required this.url,
    required this.image,
    this.startDate,
    this.endDate,
  });
  late final int id;
  late final String namaKegiatan;
  late final String deskripsi;
  late final int isRunning;
  late final String? url;
  late final String? image;
  late final String? startDate;
  late final String? endDate;

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    namaKegiatan = json['nama_kegiatan'];
    deskripsi = json['deskripsi'];
    isRunning = json['is_running'];
    url = json['link_url'] == null ? null : json['link_url'];
    image = json['image'] == null ? null : json['image'];
    startDate = json['start_date'] == null ? null : json['start_date'];
    endDate = json['end_date'] == null ? null : json['end_date'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['nama_kegiatan'] = namaKegiatan;
    _data['deskripsi'] = deskripsi;
    _data['is_running'] = isRunning;
    _data['start_date'] = startDate;
    _data['end_date'] = endDate;
    return _data;
  }
}
