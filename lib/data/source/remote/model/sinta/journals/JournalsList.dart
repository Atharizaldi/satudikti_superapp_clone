class JournalsList {
  String? message;
  Data? data;

  JournalsList({this.message, this.data});

  JournalsList.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? page;
  int? items;
  int? total;
  String? orderBy;
  List<Journals>? journals;

  Data({this.page, this.items, this.total, this.orderBy, this.journals});

  Data.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    items = json['items'];
    total = json['total'];
    orderBy = json['order_by'];
    if (json['journals'] != null) {
      journals = <Journals>[];
      json['journals'].forEach((v) {
        journals!.add(new Journals.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['page'] = this.page;
    data['items'] = this.items;
    data['total'] = this.total;
    data['order_by'] = this.orderBy;
    if (this.journals != null) {
      data['journals'] = this.journals!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Journals {
  String? id;
  String? title;
  String? urlJournal;
  String? institution;
  String? publisher;
  String? pissn;
  String? eissn;
  String? urlEditor;

  Journals(
      {this.id,
        this.title,
        this.urlJournal,
        this.institution,
        this.publisher,
        this.pissn,
        this.eissn,
        this.urlEditor});

  Journals.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    urlJournal = json['url_journal'];
    institution = json['institution'];
    publisher = json['publisher'];
    pissn = json['pissn'];
    eissn = json['eissn'];
    urlEditor = json['url_editor'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['url_journal'] = this.urlJournal;
    data['institution'] = this.institution;
    data['publisher'] = this.publisher;
    data['pissn'] = this.pissn;
    data['eissn'] = this.eissn;
    data['url_editor'] = this.urlEditor;
    return data;
  }
}

