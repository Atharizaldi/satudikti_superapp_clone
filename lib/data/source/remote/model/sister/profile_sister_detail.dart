class ProfileSisterDetail {
  ProfileSisterDetail({
    required this.data,
    required this.message,
  });
  late final ProfileSister data;
  late final String message;

  ProfileSisterDetail.fromJson(Map<String, dynamic> json) {
    data = ProfileSister.fromJson(json['data']);
    message = json['message'];
  }
}

class ProfileSister {
  ProfileSister({
    required this.nama,
    required this.nidn,
    required this.status,
  });
  late final String nama;
  late final String nidn;
  late final bool status;

  ProfileSister.fromJson(Map<String, dynamic> json) {
    nama = json['nama'];
    nidn = json['nidn'];
    status = json['status'];
  }
}
