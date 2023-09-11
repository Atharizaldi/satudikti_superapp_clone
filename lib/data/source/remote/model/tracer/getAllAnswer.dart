class GetAllAnswer {
  Data? data;
  String? message;
  int? status;

  GetAllAnswer({this.data, this.message, this.status});

  GetAllAnswer.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    message = json['message'];
    status = json['status'];
  }
}

class Data {
  List<Answer>? answer;
  List<Questions>? questions;

  Data({this.answer, this.questions});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['answer'] != null) {
      answer = <Answer>[];
      json['answer'].forEach((v) {
        answer!.add(new Answer.fromJson(v));
      });
    }
    if (json['question'] != null) {
      questions = <Questions>[];
      json['question'].forEach((v) {
        questions!.add(new Questions.fromJson(v));
      });
    }
  }
}

class Answer {
  String? questionId;
  String? question;
  String? answer;
  String? extraAnswer;
  int? answerType;
  String? type;
  String? realAnswer;

  Answer(
      {this.questionId,
      this.question,
      this.answer,
      this.extraAnswer,
      this.answerType,
      this.type,
      this.realAnswer});

  Answer.fromJson(Map<String, dynamic> json) {
    questionId = json['question_id'];
    question = json['question'];
    answer = json['answer'];
    extraAnswer = json['extra_answer'];
    answerType = json['answer_type'];
    type = json['type'];
    realAnswer = json['real_answer'];
  }
}

class Questions {
  int? questionId;
  int? parentId;
  int? order;
  int? pages;
  bool? isRequired;
  String? question;
  AnswerType? answerType;
  // Null? custom;
  // Null? sourceData;
  // Null? relationWith;
  // Null? rangeLabel;
  List<AnswerLists>? answerLists;
  bool? hasChild;
  bool? isChild;
  List<Child>? child;
  String? createdAt;
  // Null? updatedAt;

  Questions({
    this.questionId,
    this.parentId,
    this.order,
    this.pages,
    this.isRequired,
    this.question,
    this.answerType,
    // this.custom,
    // this.sourceData,
    // this.relationWith,
    // this.rangeLabel,
    this.answerLists,
    this.hasChild,
    this.isChild,
    this.child,
    this.createdAt,
    // this.updatedAt
  });

  Questions.fromJson(Map<String, dynamic> json) {
    questionId = json['question_id'];
    parentId = json['parent_id'];
    order = json['order'];
    pages = json['pages'];
    isRequired = json['is_required'];
    question = json['question'];
    answerType = json['answer_type'] != null
        ? new AnswerType.fromJson(json['answer_type'])
        : null;
    // custom = json['custom'];
    // sourceData = json['source_data'];
    // relationWith = json['relation_with'];
    // rangeLabel = json['range_label'];
    if (json['answer_list'] != null) {
      answerLists = <AnswerLists>[];
      json['answer_list'].forEach((v) {
        answerLists!.add(new AnswerLists.fromJson(v));
      });
    }
    hasChild = json['has_child'];
    isChild = json['is_child'];
    if (json['child'] != null) {
      child = <Child>[];
      json['child'].forEach((v) {
        child!.add(new Child.fromJson(v));
      });
    }
    createdAt = json['created_at'];
    // updatedAt = json['updated_at'];
  }
}

class AnswerType {
  int? answerTypeId;
  String? type;

  AnswerType({this.answerTypeId, this.type});

  AnswerType.fromJson(Map<String, dynamic> json) {
    answerTypeId = json['answer_type_id'];
    type = json['type'];
  }
}

class AnswerLists {
  int? answerListId;
  String? answerLabel;
  bool? extraAnswer;
  String? extraAnswerType;

  AnswerLists(
      {this.answerListId,
      this.answerLabel,
      this.extraAnswer,
      this.extraAnswerType});

  AnswerLists.fromJson(Map<String, dynamic> json) {
    answerListId = json['answer_list_id'];
    answerLabel = json['answer_label'];
    extraAnswer = json['extra_answer'];
    extraAnswerType = json['extra_answer_type'];
  }
}

class Child {
  int? questionId;
  int? parentId;
  int? order;
  int? pages;
  bool? isRequired;
  String? question;
  AnswerType? answerType;
  String? custom;
  String? sourceData;
  int? relationWith;
  List<String>? rangeLabel;
  List<AnswerLists>? answerLists;
  bool? hasChild;
  bool? isChild;
  // Null? child;
  String? createdAt;
  // Null? updatedAt;

  Child({
    this.questionId,
    this.parentId,
    this.order,
    this.pages,
    this.isRequired,
    this.question,
    this.answerType,
    this.custom,
    this.sourceData,
    this.relationWith,
    this.rangeLabel,
    this.answerLists,
    this.hasChild,
    this.isChild,
    // this.child,
    this.createdAt,
    // this.updatedAt
  });

  Child.fromJson(Map<String, dynamic> json) {
    questionId = json['question_id'];
    parentId = json['parent_id'];
    order = json['order'];
    pages = json['pages'];
    isRequired = json['is_required'];
    question = json['question'];
    answerType = json['answer_type'] != null
        ? new AnswerType.fromJson(json['answer_type'])
        : null;
    custom = json['custom'];
    sourceData = json['source_data'];
    relationWith = json['relation_with'];
    rangeLabel =
        json['range_label'] == null ? null : List.from(json['range_label']);
    if (json['answer_list'] != null) {
      answerLists = <AnswerLists>[];
      json['answer_list'].forEach((v) {
        answerLists!.add(new AnswerLists.fromJson(v));
      });
    }
    hasChild = json['has_child'];
    isChild = json['is_child'];
    // child = json['child'];
    createdAt = json['created_at'];
    // updatedAt = json['updated_at'];
  }
}
