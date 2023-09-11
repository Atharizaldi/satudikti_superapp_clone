import 'package:equatable/equatable.dart';

class PraktisiSister extends Equatable {
  late final String message;
  late final List<PraktisiData> praktisiData;

  PraktisiSister({required this.message, required this.praktisiData});

  PraktisiSister.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    praktisiData =
        List.from(json['data']).map((e) => PraktisiData.fromJson(e)).toList();
  }
  @override
  List<Object?> get props => [message, praktisiData];
}

class PraktisiData extends Equatable {
  late final String pekerjaan;
  late final String instansi;
  late final String jabatan;
  late final String tglMulaiBekerja;
  late final String tglSelesaiBekerja;
  late final bool lnDN;

  // late final String luarDalamNegeri;

  PraktisiData(
      {required this.pekerjaan,
      required this.instansi,
      required this.jabatan,
      required this.tglMulaiBekerja,
      required this.lnDN,
      required this.tglSelesaiBekerja
      //required this.luarDalamNegeri;
      });

  PraktisiData.fromJson(Map<String, dynamic> json) {
    pekerjaan = json['pekerjaan'] != null ? json['pekerjaan'] : '-';
    instansi = json['instansi'] != null ? json['instansi'] : '-';
    jabatan = json['jabatan'] != null ? json['jabatan'] : '-';
    tglMulaiBekerja =
        json['tgl_mulai_bekerja'] != null ? json['tgl_mulai_bekerja'] : '-';
    tglSelesaiBekerja =
        json['tgl_selesai_bekerja'] != null ? json['tgl_selesai_bekerja'] : '-';
    lnDN = json['ln_dn'] != null ? json['ln_dn'] : false;

    //luarDalamNegeri = json['ln_dn'];
  }
  @override
  List<Object?> get props =>
      [pekerjaan, instansi, jabatan, tglMulaiBekerja, lnDN, tglSelesaiBekerja];
}
