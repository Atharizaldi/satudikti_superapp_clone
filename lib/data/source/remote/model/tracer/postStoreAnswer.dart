class PostStoreAnswerData {
  PostStoreAnswerData({
    this.data,
    required this.message,
    required this.status,
  });

  List<DataPostStoreAnswer>? data;
  late final String message;
  late final bool status;

  PostStoreAnswerData.fromJson(Map<String, dynamic> json) {
    data = json['data'] == null
        ? null
        : List.from(json['data'])
            .map((e) => DataPostStoreAnswer.fromJson(e))
            .toList();
    message = json['message'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['data'] = data == null ? null : data!.map((e) => e.toJson()).toList();
    _data['message'] = message;
    _data['status'] = status;
    return _data;
  }
}

class DataPostStoreAnswer {
  DataPostStoreAnswer({
    required this.message,
    required this.questionId,
  });

  late final List<String> message;
  late final String questionId;

  factory DataPostStoreAnswer.fromJson(Map<String, dynamic> json) =>
      DataPostStoreAnswer(
        message: List<String>.from(json["message"]),
        questionId: json["question_id"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "question_id": questionId,
      };
}
