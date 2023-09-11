class StatusPengajuanUsulan{
  StatusPengajuanUsulan({
    required this.data,
    required this.message,
  });
  late final data;
  late final message;

  factory StatusPengajuanUsulan.fromJson(Map<String, dynamic> json) =>
      StatusPengajuanUsulan(data: Data.fromJson(json['data']), message:
      json['message']);

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['data'] = data.toJson();
    _data['message'] = message;
    return _data;
  }
}

class Data {
  Data({
    required this.detailStatusPengajuan,
    required this.progressPengajuanUsulan
  });
  late final List<DetailStatusPengajuan> detailStatusPengajuan;
  late final List<ProgressPengajuanUsulan> progressPengajuanUsulan;

  factory Data.fromJson(Map<String, dynamic> json) =>
      Data(
          detailStatusPengajuan: List.from(json['detail']).map((e) =>
          DetailStatusPengajuan.fromJson(e)).toList(),
        progressPengajuanUsulan: List.from(json['log']).map((e) =>
            ProgressPengajuanUsulan.fromJson(e)).toList());

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['detail'] = detailStatusPengajuan.map((e) => e.toJson()).toList();
    _data['log'] = progressPengajuanUsulan.map((e) => e.toJson()).toList();
    return _data;
  }
}

class DetailStatusPengajuan {
  DetailStatusPengajuan({
    required this.ticket,
    required this.namaPt,
    required this.namaProdi,
    required this.namaProgram,
    required this.namaPengajuan,
    required this.namaUsulan,
  });
  late final String ticket;
  late final String namaPt;
  late final String namaProdi;
  late final String namaProgram;
  late final String namaPengajuan;
  late final String namaUsulan;

  factory DetailStatusPengajuan.fromJson(Map<String, dynamic> json) =>
      DetailStatusPengajuan(
          ticket: json['ticket'],
          namaPt: json['nama_pt'],
          namaProdi: json['nama_prodi'],
          namaProgram: json['nama_program'],
          namaPengajuan: json['nama_pengajuan'],
          namaUsulan: json['nama_usulan']
      );

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['ticket'] = ticket;
    _data['nama_pt'] = namaPt;
    _data['nama_prodi'] = namaProdi;
    _data['nama_program'] = namaProgram;
    _data['nama_pengajuan'] = namaPengajuan;
    _data['nama_usulan'] = namaUsulan;
    return _data;
  }
}

class ProgressPengajuanUsulan{
  ProgressPengajuanUsulan({
    required this.judul,
    required this.deskripsi,
    required this.tipeTiket,
    required this.status,
    required this.unit,
    required this.dateLog
  });

  late final judul;
  late final deskripsi;
  late final tipeTiket;
  late final status;
  late final unit;
  late final dateLog;

  factory ProgressPengajuanUsulan.fromJson(Map<String, dynamic> json) =>
      ProgressPengajuanUsulan(
          judul: json['judul'],
          deskripsi: json['deskripsi'],
          tipeTiket: json['tipe_tiket'],
          status: json['status'],
          unit: json['unit'],
          dateLog: json['date_log']
      );

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['judul'] = judul;
    _data['deskripsi'] = deskripsi;
    _data['tipe_tiket'] = tipeTiket;
    _data['status'] = status;
    _data['unit'] = unit;
    _data['date_log'] = dateLog;
    return _data;
  }
}
