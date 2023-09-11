class AnswerKuesioner {
  String? answer;
  String? extraAnswer;
  String? questionId;
  String? alumniId;

  AnswerKuesioner({
    this.answer,
    this.extraAnswer,
    this.questionId,
    this.alumniId,
  });

  AnswerKuesioner.fromJson(Map<String, dynamic> json) {
    answer = json['answer'];
    extraAnswer = json['extra_answer'];
    questionId = json['question_id'];
    alumniId = json['alumni_id'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['answer'] = answer;
    _data['extra_answer'] = extraAnswer;
    _data['question_id'] = questionId;
    _data['alumni_id'] = alumniId;
    return _data;
  }
}
