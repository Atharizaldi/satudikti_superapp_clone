class PenilaianDosen {
  final dynamic data;
  final String message;
  PenilaianDosen({required this.data, required this.message});

  factory PenilaianDosen.fromJson(Map<String, dynamic> json) =>
      PenilaianDosen(data: json["data"], message: json["message"]);

  // @override
  // bool operator ==(Object other) {
  //   return
  // }
}
