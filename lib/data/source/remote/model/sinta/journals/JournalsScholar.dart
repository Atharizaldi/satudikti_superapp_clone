class JournalsScholar {
  String? message;
  Data? data;

  JournalsScholar({this.message, this.data});

  JournalsScholar.fromJson(Map<String, dynamic> json) {
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
  Journal? journal;
  int? page;
  int? items;
  int? total;
  String? orderBy;
  List<Google>? google;

  Data(
      {this.journal,
        this.page,
        this.items,
        this.total,
        this.orderBy,
        this.google});

  Data.fromJson(Map<String, dynamic> json) {
    journal =
    json['journal'] != null ? new Journal.fromJson(json['journal']) : null;
    page = json['page'];
    items = json['items'];
    total = json['total'];
    orderBy = json['order_by'];
    if (json['google'] != null) {
      google = <Google>[];
      json['google'].forEach((v) {
        google!.add(new Google.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.journal != null) {
      data['journal'] = this.journal!.toJson();
    }
    data['page'] = this.page;
    data['items'] = this.items;
    data['total'] = this.total;
    data['order_by'] = this.orderBy;
    if (this.google != null) {
      data['google'] = this.google!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Journal {
  String? id;
  String? title;
  String? accreditation;
  String? eissn;
  String? pissn;
  String? institution;

  Journal(
      {this.id,
        this.title,
        this.accreditation,
        this.eissn,
        this.pissn,
        this.institution});

  Journal.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    accreditation = json['accreditation'];
    eissn = json['eissn'];
    pissn = json['pissn'];
    institution = json['institution'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['accreditation'] = this.accreditation;
    data['eissn'] = this.eissn;
    data['pissn'] = this.pissn;
    data['institution'] = this.institution;
    return data;
  }
}

class Google {
  String? id;
  String? title;
  String? author;
  String? journalName;
  String? publishYear;
  String? citation;
  String? accreditation;

  Google(
      {this.id,
        this.title,
        this.author,
        this.journalName,
        this.publishYear,
        this.citation,
        this.accreditation});

  Google.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    author = json['author'];
    journalName = json['journal_name'];
    publishYear = json['publish_year'];
    citation = json['citation'];
    accreditation = json['accreditation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['author'] = this.author;
    data['journal_name'] = this.journalName;
    data['publish_year'] = this.publishYear;
    data['citation'] = this.citation;
    data['accreditation'] = this.accreditation;
    return data;
  }
}

