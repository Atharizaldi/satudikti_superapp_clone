class JournalsDetail {
  String? message;
  Data? data;

  JournalsDetail({this.message, this.data});

  JournalsDetail.fromJson(Map<String, dynamic> json) {
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

  Data({this.journal});

  Data.fromJson(Map<String, dynamic> json) {
    journal =
    json['journal'] != null ? new Journal.fromJson(json['journal']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.journal != null) {
      data['journal'] = this.journal!.toJson();
    }
    return data;
  }
}

class Journal {
  String? id;
  String? title;
  String? institution;
  String? publisher;
  String? pissn;
  String? eissn;
  List<String>? subjects;
  String? impact3y;
  String? accreditation;
  Citations? citations;

  Journal(
      {this.id,
        this.title,
        this.institution,
        this.publisher,
        this.pissn,
        this.eissn,
        this.subjects,
        this.impact3y,
        this.accreditation,
        this.citations});

  Journal.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    institution = json['institution'];
    publisher = json['publisher'];
    pissn = json['pissn'];
    eissn = json['eissn'];
    subjects = json['subjects'].cast<String>();
    impact3y = json['impact_3y'];
    accreditation = json['accreditation'];
    citations = json['citations'] != null
        ? new Citations.fromJson(json['citations'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['institution'] = this.institution;
    data['publisher'] = this.publisher;
    data['pissn'] = this.pissn;
    data['eissn'] = this.eissn;
    data['subjects'] = this.subjects;
    data['impact_3y'] = this.impact3y;
    data['accreditation'] = this.accreditation;
    if (this.citations != null) {
      data['citations'] = this.citations!.toJson();
    }
    return data;
  }
}

class Citations {
  int? i2009;
  int? i2010;
  int? i2011;
  int? i2012;
  int? i2013;
  int? i2014;
  int? i2015;
  int? i2016;
  int? i2017;
  int? i2018;
  int? i2019;
  int? i2020;
  int? i2021;
  int? i2022;

  Citations(
      {this.i2009,
        this.i2010,
        this.i2011,
        this.i2012,
        this.i2013,
        this.i2014,
        this.i2015,
        this.i2016,
        this.i2017,
        this.i2018,
        this.i2019,
        this.i2020,
        this.i2021,
        this.i2022});

  Citations.fromJson(Map<String, dynamic> json) {
    i2009 = json['2009'];
    i2010 = json['2010'];
    i2011 = json['2011'];
    i2012 = json['2012'];
    i2013 = json['2013'];
    i2014 = json['2014'];
    i2015 = json['2015'];
    i2016 = json['2016'];
    i2017 = json['2017'];
    i2018 = json['2018'];
    i2019 = json['2019'];
    i2020 = json['2020'];
    i2021 = json['2021'];
    i2022 = json['2022'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['2009'] = this.i2009;
    data['2010'] = this.i2010;
    data['2011'] = this.i2011;
    data['2012'] = this.i2012;
    data['2013'] = this.i2013;
    data['2014'] = this.i2014;
    data['2015'] = this.i2015;
    data['2016'] = this.i2016;
    data['2017'] = this.i2017;
    data['2018'] = this.i2018;
    data['2019'] = this.i2019;
    data['2020'] = this.i2020;
    data['2021'] = this.i2021;
    data['2022'] = this.i2022;
    return data;
  }
}

