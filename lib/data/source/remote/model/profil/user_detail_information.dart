class UserInformationDetailResponse {
  final UserInformationDetail? data;
  final String? message;

  UserInformationDetailResponse({
    this.data,
    this.message,
  });

  factory UserInformationDetailResponse.fromJson(Map<String, dynamic> json) =>
      UserInformationDetailResponse(
        data: UserInformationDetail.fromJson(json['data']),
        message: json['message'],
      );
}

class UserInformationDetail {
  final String? userID,
      nama,
      role,
      nim,
      nidn,
      nidk,
      jenisKelamin,
      kodeProdi,
      namaProdi,
      kodePT,
      namaPT,
      namaPengguna;

  UserInformationDetail({
    this.userID,
    this.nama,
    this.role,
    this.nim,
    this.nidn,
    this.nidk,
    this.jenisKelamin,
    this.kodeProdi,
    this.namaProdi,
    this.kodePT,
    this.namaPT,
    this.namaPengguna,
  });
  factory UserInformationDetail.fromJson(Map<String, dynamic> json) =>
      UserInformationDetail(
        userID: json['user_id'],
        nama: json['nama'],
        role: json['role'],
        nim: json['nim'],
        nidn: json['nidn'],
        nidk: json['nidk'],
        jenisKelamin: json['jenis_kelamin'],
        kodeProdi: json['kode_prodi'],
        namaProdi: json['nama_prodi'],
        kodePT: json['kode_pt'],
        namaPT: json['nama_pt'],
        namaPengguna: json['username'],

      );

  @override
  bool operator ==(Object other) =>
     other is UserInformationDetail &&
        this.userID == other.userID &&
        this.nama == other.nama &&
        this.role == other.role &&
        this.nim == other.nim &&
        this.nidn == other.nidn &&
        this.nidk == other.nidk &&
        this.jenisKelamin == other.jenisKelamin &&
        this.kodeProdi == other.kodeProdi &&
        this.namaProdi == other.namaProdi &&
        this.kodePT == other.kodePT &&
        this.namaPT == other.namaPT &&
        this.namaPengguna == other.namaPengguna;

  @override
  int get hashCode => Object.hash( userID, nama, role, nim, nidn, nidk, jenisKelamin, kodeProdi, namaProdi, kodePT, namaPT, namaPengguna);
}
