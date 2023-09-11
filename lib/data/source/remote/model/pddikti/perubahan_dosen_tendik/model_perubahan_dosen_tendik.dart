import 'package:collection/collection.dart';

class PerubahanDosenTendikResponse {
  final DataPerubahanDosenTendikResponse? data;
  final String? message;

  PerubahanDosenTendikResponse({this.data, this.message});

  factory PerubahanDosenTendikResponse.fromJson(Map<String, dynamic> json) =>
      PerubahanDosenTendikResponse(
          data: DataPerubahanDosenTendikResponse.fromJson(json['data']),
          message: json['message']);

  @override
  bool operator ==(Object other) =>
    other is PerubahanDosenTendikResponse &&
        data == other.data &&
        message == other.message;

  @override
  int get hashCode => Object.hash( data, message);
}

class DataPerubahanDosenTendikResponse {
  final List<ListPerubahanDosenTendikResponse> listPerubahanDosenTendikResponse;

  DataPerubahanDosenTendikResponse(
      {required this.listPerubahanDosenTendikResponse});
  factory DataPerubahanDosenTendikResponse.fromJson(List<dynamic> rawList) =>
      DataPerubahanDosenTendikResponse(
          listPerubahanDosenTendikResponse: rawList.map((item) {
        return ListPerubahanDosenTendikResponse.fromJson(item);
      }).toList());

  @override
  bool operator ==(Object other) {
    return other is DataPerubahanDosenTendikResponse &&
        IterableEquality().equals(listPerubahanDosenTendikResponse,
            other.listPerubahanDosenTendikResponse);
  }

  @override
  int get hashCode {
    return const IterableEquality().hash(listPerubahanDosenTendikResponse);
  }
}

class ListPerubahanDosenTendikResponse {
  final String? nidn;
  final String? namaStatusUsulan;
  final String? tanggalPengajuan;
  final String? perguruanTinggi;
  final String? prodi;
  final String? jenjangPendidikan;
  final int? tahunMasuk;
  final String? gelarAkademi;
  final String? bidangStudi;
  final String? namaDosen;
  final String? noKtp;
  final String? tempatLahir;
  final String? tanggalLahir;
  final String? jenisKelamin;
  final String? nip;
  final int? statusAktif;
  final String? nomorSk;
  final String? jabatanFungsional;
  final String? tmtSk;
  final int? tahunSertifikasi;
  final String? noPtps;
  final String? noRegistrasi;
  final String? pangkat;
  final String? skPangkat;
  final String? tanggalSk;
  final String? tmtSkDitangguhkan;
  final int? lamaTahunMasaKerja;
  final int? lamaBulanMasaKerja;
  final String? tanggalIjazah;
  final String? statusIkatanKerja;
  final String? statusMulaiDosen;
  final String? ketKeluar;
  final String? statusPegawai;
  final String? dokumenValid;
  final String? jenis;
  final String? catatan;
  final String? nama;
  final String? tUpdateTime;

  ListPerubahanDosenTendikResponse({
    this.nidn,
    this.namaStatusUsulan,
    this.tanggalPengajuan,
    this.perguruanTinggi,
    this.prodi,
    this.jenjangPendidikan,
    this.tahunMasuk,
    this.gelarAkademi,
    this.bidangStudi,
    this.namaDosen,
    this.noKtp,
    this.tempatLahir,
    this.tanggalLahir,
    this.jenisKelamin,
    this.nip,
    this.statusAktif,
    this.nomorSk,
    this.jabatanFungsional,
    this.tmtSk,
    this.tahunSertifikasi,
    this.noPtps,
    this.noRegistrasi,
    this.pangkat,
    this.skPangkat,
    this.tanggalSk,
    this.tmtSkDitangguhkan,
    this.lamaTahunMasaKerja,
    this.lamaBulanMasaKerja,
    this.tanggalIjazah,
    this.statusIkatanKerja,
    this.statusMulaiDosen,
    this.ketKeluar,
    this.statusPegawai,
    this.dokumenValid,
    this.jenis,
    this.catatan,
    this.nama,
    this.tUpdateTime,
  });
  factory ListPerubahanDosenTendikResponse.fromJson(
          Map<String, dynamic> json) =>
      ListPerubahanDosenTendikResponse(
          nidn: json["nidn"],
          namaStatusUsulan: json['nama_status_usulan'] ?? "",
          tanggalPengajuan: json['tgl_pengajuan'],
          perguruanTinggi: json['nm_sp'],
          jenjangPendidikan: json['nm_jenj_didik'],
          prodi: json['nm_sms'],
          tahunMasuk: json['thn_masuk'],
          gelarAkademi: json['nm_gelar_akad'],
          bidangStudi: json['nm_bid_studi'],
          namaDosen: json['nama_dosen'],
          noKtp: json['nomor_ktp'],
          tempatLahir: json['tempat_lahir'],
          tanggalLahir: json['tanggal_lahir'],
          jenisKelamin: json['jenis_kelamin'],
          nip: json['nip_baru'],
          statusAktif: json['status_aktif'],
          nomorSk: json['sk_jabfung'],
          jabatanFungsional: json['nm_jabfung'],
          tmtSk: json['tmt_sk_jabfung'],
          tahunSertifikasi: json['thn_sert'],
          noPtps: json['sk_sert'],
          noRegistrasi: json['nrg'],
          pangkat: json['nm_pangkat'],
          skPangkat: json['sk_pangkat'],
          tanggalSk: json['tgl_sk_pangkat'],
          tmtSkDitangguhkan: json['tmt_sk_pangkat'],
          lamaTahunMasaKerja: json['masa_kerja_gol_thn'],
          lamaBulanMasaKerja: json['masa_kerja_gol_bln'],
          tanggalIjazah: json['tanggal_ijazah'],
          statusIkatanKerja: json['nm_ikatan_kerja'],
          statusMulaiDosen: json['mulai_masuk_dosen'],
          ketKeluar: json['ket_keluar'],
          dokumenValid: json['dokumen_valid'],
          jenis: json['jenis'],
          nama: json['nama_dosen'] ?? '',
          catatan: json['catatanpdd'] ?? "",
          tUpdateTime: json['t_updatetime'] ?? '-',
          statusPegawai: json['nm_stat_pegawai']);

  @override
  bool operator ==(Object other) {
    return other is ListPerubahanDosenTendikResponse &&
        nidn == other.nidn &&
        nama == other.nama &&
        catatan == other.catatan &&
        tUpdateTime == other.tUpdateTime &&
        jenis == other.jenis &&
        dokumenValid == other.dokumenValid &&
        namaStatusUsulan == other.namaStatusUsulan &&
        tanggalPengajuan == other.tanggalPengajuan &&
        perguruanTinggi == other.perguruanTinggi &&
        jenjangPendidikan == other.jenjangPendidikan &&
        prodi == other.prodi &&
        tahunMasuk == other.tahunMasuk &&
        gelarAkademi == other.gelarAkademi &&
        bidangStudi == other.bidangStudi &&
        namaDosen == other.namaDosen &&
        noKtp == other.noKtp &&
        tempatLahir == other.tempatLahir &&
        tanggalLahir == other.tanggalLahir &&
        nip == other.nip &&
        statusAktif == other.statusAktif &&
        nomorSk == other.nomorSk &&
        jabatanFungsional == other.jabatanFungsional &&
        tmtSk == other.tmtSk &&
        tahunSertifikasi == other.tahunSertifikasi &&
        noPtps == other.noPtps &&
        noRegistrasi == other.noRegistrasi &&
        pangkat == other.pangkat &&
        skPangkat == other.skPangkat &&
        tanggalSk == other.tanggalSk &&
        tmtSkDitangguhkan == other.tmtSkDitangguhkan &&
        lamaTahunMasaKerja == other.lamaTahunMasaKerja &&
        lamaBulanMasaKerja == other.lamaBulanMasaKerja &&
        tanggalIjazah == other.tanggalIjazah &&
        statusIkatanKerja == other.statusIkatanKerja &&
        statusMulaiDosen == other.statusMulaiDosen &&
        ketKeluar == other.ketKeluar &&
        statusPegawai == other.statusPegawai;
  }

  @override
  int get hashCode {
    return nidn.hashCode ^
    nama.hashCode ^
    catatan.hashCode ^
    tUpdateTime.hashCode ^
    jenis.hashCode ^
    dokumenValid.hashCode ^
    namaStatusUsulan.hashCode ^
    tanggalPengajuan.hashCode ^
    perguruanTinggi.hashCode ^
    jenjangPendidikan.hashCode ^
    prodi.hashCode ^
    tahunMasuk.hashCode ^
    gelarAkademi.hashCode ^
    bidangStudi.hashCode ^
    namaDosen.hashCode ^
    noKtp.hashCode ^
    tempatLahir.hashCode ^
    tanggalLahir.hashCode ^
    nip.hashCode ^
    statusAktif.hashCode ^
    nomorSk.hashCode ^
    jabatanFungsional.hashCode ^
    tmtSk.hashCode ^
    tahunSertifikasi.hashCode ^
    noPtps.hashCode ^
    noRegistrasi.hashCode ^
    pangkat.hashCode ^
    skPangkat.hashCode ^
    tanggalSk.hashCode ^
    tmtSkDitangguhkan.hashCode ^
    lamaTahunMasaKerja.hashCode ^
    lamaBulanMasaKerja.hashCode ^
    tanggalIjazah.hashCode ^
    statusIkatanKerja.hashCode ^
    statusMulaiDosen.hashCode ^
    ketKeluar.hashCode ^
    statusPegawai.hashCode;
  }

}
