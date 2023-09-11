class ProfilePAKDetail {
  ProfilePAKDetail({
    required this.data,
    required this.message,
  });
  late final ProfilePAK data;
  late final String message;

  ProfilePAKDetail.fromJson(Map<String, dynamic> json) {
    data = ProfilePAK.fromJson(json['data']);
    message = json['message'];
  }
}

class ProfilePAK {
  ProfilePAK({
    required this.nama,
    required this.nidn,
    required this.status,
  });
  late final String nama;
  late final String nidn;
  late final bool status;

  ProfilePAK.fromJson(Map<String, dynamic> json) {
    nama = json['nama'];
    nidn = json['nidn'];
    status = json['status'];
  }
}
