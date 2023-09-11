
class GetKuesioner{
  GetKuesioner({
    required this.data,
    required this.message,
    required this.pages,
  });

  late final List<Question> data;
  late final String message;
  late final int pages;

  GetKuesioner.fromJson(Map<String, dynamic> json){
    data = List.from(json['data']).map((e) => Question.fromJson(e)).toList();
    message = json['message'];
    pages = json['pages'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['data'] = data.map((e) => e.toJson()).toList();
    _data['message'] = message;
    _data['pages'] = pages;
    return _data;
  }

}

class Question{

  Question({
    required this.questionId,
    required this.order,
    required this.pages,
    required this.isRequired,
    required this.question,
    required this.answerType,
    this.sourceData,
    this.relationWith,
    this.rangeLabel,
    this.answerList,
    required this.hasChild,
    required this.isChild,
    this.child,
  });

  late final int questionId;
  late final int order;
  late final int pages;
  late final bool isRequired;
  late final String question;
  late final AnswerType answerType;
  late final String? sourceData;
  late final int? relationWith;
  late final List<String>? rangeLabel;
  late final List<AnswerList>? answerList;
  late final bool hasChild;
  late final bool isChild;
  late final List<Child>? child;

  Question.fromJson(Map<String, dynamic> json){
    questionId = json['question_id'];
    order = json['order'];
    pages = json['pages'];
    isRequired = json['is_required'];
    question = json['question'];
    answerType = AnswerType.fromJson(json['answer_type']);
    sourceData = json['source_data'] == null ? null : json['source_data'];
    relationWith = json['relation_with'] == null ? null : json['relation_with'];
    rangeLabel = json['range_label'] == null ? null : List.from(json['range_label']);
    answerList = json['answer_list'] == null ? null : List.from(json['answer_list']).map((e) => AnswerList.fromJson(e)).toList();
    hasChild = json['has_child'];
    isChild = json['is_child'];
    child = json['child'] == null ? null : List.from(json['child']).map((e) => Child.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['question_id']  = questionId;
    _data['order']        = order;
    _data['pages']        = pages;
    _data['is_required']  = isRequired;
    _data['question']     = question;
    _data['answer_type']  = answerType.toJson();
    _data['source_data']  = sourceData == null ? null : sourceData;
    _data['relation_with']= relationWith == null ? null : relationWith;
    _data['range_label']  = rangeLabel == null ? null : rangeLabel;
    _data['answer_list']  = answerList == null ? null : answerList?.map((e) => e.toJson()).toList();
    _data['has_child']    = hasChild;
    _data['is_child']     = isChild;
    _data['child']        = child == null ? null : child!.map((e) => e.toJson()).toList();
    return _data;
  }

}

class AnswerType{

  AnswerType({
    required this.answerTypeId,
    required this.type,
  });
  late final int answerTypeId;
  late final String type;

  AnswerType.fromJson(Map<String, dynamic> json){
    answerTypeId = json['answer_type_id'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['answer_type_id'] = answerTypeId;
    _data['type'] = type;
    return _data;
  }

}

class AnswerList{

  AnswerList({
    required this.answerListId,
    required this.answerLabel,
    required this.extraAnswer,
    this.extraAnswerType,
  });

  late final int answerListId;
  late final String answerLabel;
  late final bool extraAnswer;
  late final String? extraAnswerType;

  AnswerList.fromJson(Map<String, dynamic> json){
    answerListId = json['answer_list_id'];
    answerLabel = json['answer_label'];
    extraAnswer = json['extra_answer'];
    extraAnswerType = json['extra_answer_type'] == null ? null : json['extra_answer_type'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['answer_list_id'] = answerListId;
    _data['answer_label'] = answerLabel;
    _data['extra_answer'] = extraAnswer;
    _data['extra_answer_type'] = extraAnswerType == null ? null : extraAnswerType;
    return _data;
  }

}

class Child{
  Child({
    required this.questionId,
    required this.parentId,
    required this.order,
    required this.pages,
    required this.isRequired,
    required this.question,
    required this.answerType,
    this.sourceData,
    this.relationWith,
    this.rangeLabel,
    this.answerList,
    required this.hasChild,
    required this.isChild,
    this.child,
  });

  late final int questionId;
  late final int? parentId;
  late final int order;
  late final int pages;
  late final bool isRequired;
  late final String question;
  late final AnswerType answerType;
  late final String? sourceData;
  late final int? relationWith;
  late final List<String>? rangeLabel;
  late final List<AnswerList>? answerList;
  late final bool hasChild;
  late final bool isChild;
  late final List<Child>? child;

  Child.fromJson(Map<String, dynamic> json){
    questionId = json['question_id'];
    parentId = json['parent_id'] == null ? null : json['parent_id'];
    order = json['order'];
    pages = json['pages'];
    isRequired = json['is_required'];
    question = json['question'];
    answerType = AnswerType.fromJson(json['answer_type']);
    sourceData = json['source_data'] == null ? null : json['source_data'];
    relationWith = json['relation_with'] == null ? null : json['relation_with'];
    rangeLabel = json['range_label'] == null ? null : List.from(json['range_label']);
    answerList = json['answer_list'] == null ? null : List.from(json['answer_list']).map((e) => AnswerList.fromJson(e)).toList();
    hasChild = json['has_child'];
    isChild = json['is_child'];
    child = json['child'] == null ? null : List.from(json['child']).map((e) => Child.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['question_id']  = questionId;
    _data['order']        = order;
    _data['pages']        = pages;
    _data['is_required']  = isRequired;
    _data['question']     = question;
    _data['answer_type']  = answerType.toJson();
    _data['source_data']  = sourceData == null ? null : sourceData;
    _data['relation_with']= relationWith == null ? null : relationWith;
    _data['range_label']  = rangeLabel == null ? null : rangeLabel;
    _data['answer_list']  = answerList == null ? null : answerList?.map((e) => e.toJson()).toList();
    _data['has_child']    = hasChild;
    _data['is_child']     = isChild;
    _data['child']        = child == null ? null : child!.map((e) => e.toJson()).toList();
    return _data;
  }

}