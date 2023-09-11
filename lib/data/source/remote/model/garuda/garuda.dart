class Garuda {
  Data? data;
  String message;
  Garuda({this.data, required this.message});

  factory Garuda.fromJson(Map<String, dynamic> json) =>
      Garuda(data: Data.fromJson(json['data']), message: json['message']);
}

class Data {
  final String status;
  final ResultGaruda resultGaruda;

  Data({required this.status, required this.resultGaruda});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
      status: json['status'],
      resultGaruda: ResultGaruda.fromJson(json['results']));
}

class ResultGaruda {
  final int page;
  final int items;
  final int total;
  final List<JournalGaruda> journalGaruda;

  ResultGaruda(
      {required this.page,
      required this.items,
      required this.total,
      required this.journalGaruda});

  factory ResultGaruda.fromJson(Map<String, dynamic> json) => ResultGaruda(
      page: json['page'],
      items: json['items'],
      total: json['total'],
      journalGaruda: List.from(json['journals'])
          .map((e) => JournalGaruda.fromJson(e))
          .toList());
}

class JournalGaruda {
  final String journalName;
  final String journalIssn;
  final String journalEissn;
  final PublisherGaruda publisherGaruda;
  final List<SubjectGaruda> subjectGaruda;
  final String journalDescription;

  JournalGaruda(
      {required this.journalName,
      required this.journalIssn,
      required this.journalEissn,
      required this.publisherGaruda,
      required this.subjectGaruda,
      required this.journalDescription});

  factory JournalGaruda.fromJson(Map<String, dynamic> json) => JournalGaruda(
      journalName: json['journal_name'],
      journalIssn: json['journal_issn'],
      journalEissn: json['journal_eissn'],
      publisherGaruda: PublisherGaruda.fromJson(json['publisher']),
      subjectGaruda: List<SubjectGaruda>.from(
          json["subject_garuda"].map((x) => SubjectGaruda.fromJson(x))),
      journalDescription: json['journal_description']);
}

class PublisherGaruda {
  final String name;

  PublisherGaruda({required this.name});

  factory PublisherGaruda.fromJson(Map<String, dynamic> json) =>
      PublisherGaruda(name: json['name']);
}

class SubjectGaruda {
  final String areaId;
  final String areaName;

  SubjectGaruda({required this.areaId, required this.areaName});

  factory SubjectGaruda.fromJson(Map<String, dynamic> json) =>
      SubjectGaruda(areaId: json['area_id'], areaName: json['area_name']);
}
