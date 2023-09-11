class FAQList {
  FAQList({
    required this.data,
    required this.message,
  });
  late final Data data;
  late final String message;

  FAQList.fromJson(Map<String, dynamic> json) {
    data = Data.fromJson(json['data']);
    message = json['message'];
  }
}

class Data {
  Data({
    required this.faq,
  });
  late final List<Faq> faq;

  Data.fromJson(Map<String, dynamic> json) {
    try {
      faq = List.from(json['faq']).map((e) => Faq.fromJson(e)).toList();
    } catch (e) {
      faq = [];
    }
  }
}

class Faq {
  Faq({
    required this.jawaban,
    required this.pertanyaan,
  });
  late final String jawaban;
  late final String pertanyaan;

  Faq.fromJson(Map<String, dynamic> json) {
    jawaban = json['jawaban'];
    pertanyaan = json['pertanyaan'];
  }
}
