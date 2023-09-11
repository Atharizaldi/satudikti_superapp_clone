class UserInformationResponse {
  final UserInformation? data;
  final bool? error;
  final num? errorCode;

  UserInformationResponse({
    this.data,
    this.error,
    this.errorCode,
  });

  factory UserInformationResponse.fromJson(Map<String, dynamic> json) =>
      UserInformationResponse(
        data: UserInformation.fromJson(json['data']),
        error: json['error'],
        errorCode: json['error_code'],
      );
}

class UserInformation {
  final String? idPengguna, nik, namaPengguna, username;

  UserInformation(
      {this.idPengguna, this.nik, this.namaPengguna, this.username});
  factory UserInformation.fromJson(Map<String, dynamic> json) =>
      UserInformation(
        idPengguna: json['id_pengguna'],
        nik: json['judul_file'],
        namaPengguna: json['nm_pengguna'],
        username: json["username"],
      );

  @override
  bool operator ==(Object other) =>
    other is UserInformation &&
        this.idPengguna == other.idPengguna &&
        this.nik == other.nik &&
        this.namaPengguna == other.namaPengguna &&
        this.username == other.username;

  @override
  int get hashCode => Object.hash( idPengguna, nik, namaPengguna, username);


}
