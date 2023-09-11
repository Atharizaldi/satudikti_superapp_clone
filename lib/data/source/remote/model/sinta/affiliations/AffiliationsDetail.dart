class AffiliationsDetail {
  Data? data;
  String? message;

  AffiliationsDetail({this.data, this.message});

  AffiliationsDetail.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = this.message;
    return data;
  }
}

class Data {
  String? status;
  String? message;
  int? identifier;
  String? remoteIp;
  Results? results;

  Data(
      {this.status,
        this.message,
        this.identifier,
        this.remoteIp,
        this.results});

  Data.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    identifier = json['identifier'];
    remoteIp = json['remote_ip'];
    results =
    json['results'] != null ? new Results.fromJson(json['results']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['identifier'] = this.identifier;
    data['remote_ip'] = this.remoteIp;
    if (this.results != null) {
      data['results'] = this.results!.toJson();
    }
    return data;
  }
}

class Results {
  List<Affiliations>? affiliations;

  Results({this.affiliations});

  Results.fromJson(Map<String, dynamic> json) {
    if (json['affiliations'] != null) {
      affiliations = <Affiliations>[];
      json['affiliations'].forEach((v) {
        affiliations!.add(new Affiliations.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.affiliations != null) {
      data['affiliations'] = this.affiliations!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Affiliations {
  String? id;
  String? codePddikti;
  String? name;
  String? abbreviaton;
  String? country;
  Scopus? scopus;
  Wos? wos;
  Wos? garuda;
  Wos? google;
  String? sintaScoreV3Overall;
  String? sintaScoreV33year;
  String? sintaScoreV3ProductivityOverall;
  String? sintaScoreV3Productivity3year;
  String? linkProfile;
  String? logo;
  Province? province;
  Province? city;

  Affiliations(
      {this.id,
        this.codePddikti,
        this.name,
        this.abbreviaton,
        this.country,
        this.scopus,
        this.wos,
        this.garuda,
        this.google,
        this.sintaScoreV3Overall,
        this.sintaScoreV33year,
        this.sintaScoreV3ProductivityOverall,
        this.sintaScoreV3Productivity3year,
        this.linkProfile,
        this.logo,
        this.province,
        this.city});

  Affiliations.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    codePddikti = json['code_pddikti'];
    name = json['name'];
    abbreviaton = json['abbreviaton'];
    country = json['country'];
    scopus =
    json['scopus'] != null ? new Scopus.fromJson(json['scopus']) : null;
    wos = json['wos'] != null ? new Wos.fromJson(json['wos']) : null;
    garuda = json['garuda'] != null ? new Wos.fromJson(json['garuda']) : null;
    google = json['google'] != null ? new Wos.fromJson(json['google']) : null;
    sintaScoreV3Overall = json['sinta_score_v3_overall'];
    sintaScoreV33year = json['sinta_score_v3_3year'];
    sintaScoreV3ProductivityOverall =
    json['sinta_score_v3_productivity_overall'];
    sintaScoreV3Productivity3year = json['sinta_score_v3_productivity_3year'];
    linkProfile = json['link_profile'];
    logo = json['logo'];
    province = json['province'] != null
        ? new Province.fromJson(json['province'])
        : null;
    city = json['city'] != null ? new Province.fromJson(json['city']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['code_pddikti'] = this.codePddikti;
    data['name'] = this.name;
    data['abbreviaton'] = this.abbreviaton;
    data['country'] = this.country;
    if (this.scopus != null) {
      data['scopus'] = this.scopus!.toJson();
    }
    if (this.wos != null) {
      data['wos'] = this.wos!.toJson();
    }
    if (this.garuda != null) {
      data['garuda'] = this.garuda!.toJson();
    }
    if (this.google != null) {
      data['google'] = this.google!.toJson();
    }
    data['sinta_score_v3_overall'] = this.sintaScoreV3Overall;
    data['sinta_score_v3_3year'] = this.sintaScoreV33year;
    data['sinta_score_v3_productivity_overall'] =
        this.sintaScoreV3ProductivityOverall;
    data['sinta_score_v3_productivity_3year'] =
        this.sintaScoreV3Productivity3year;
    data['link_profile'] = this.linkProfile;
    data['logo'] = this.logo;
    if (this.province != null) {
      data['province'] = this.province!.toJson();
    }
    if (this.city != null) {
      data['city'] = this.city!.toJson();
    }
    return data;
  }
}

class Scopus {
  String? totalDocumentByScopus;
  String? totalCitationByScopus;
  String? documentInQ1;
  String? documentInQ2;
  String? documentInQ3;
  String? documentInQ4;
  String? documentInNoQ;
  String? totalDocument;
  String? totalCitation;
  String? totalCitedDocument;

  Scopus(
      {this.totalDocumentByScopus,
        this.totalCitationByScopus,
        this.documentInQ1,
        this.documentInQ2,
        this.documentInQ3,
        this.documentInQ4,
        this.documentInNoQ,
        this.totalDocument,
        this.totalCitation,
        this.totalCitedDocument});

  Scopus.fromJson(Map<String, dynamic> json) {
    totalDocumentByScopus = json['total_document_by_scopus'];
    totalCitationByScopus = json['total_citation_by_scopus'];
    documentInQ1 = json['document_in_Q1'];
    documentInQ2 = json['document_in_Q2'];
    documentInQ3 = json['document_in_Q3'];
    documentInQ4 = json['document_in_Q4'];
    documentInNoQ = json['document_in_noQ'];
    totalDocument = json['total_document'];
    totalCitation = json['total_citation'];
    totalCitedDocument = json['total_cited_document'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_document_by_scopus'] = this.totalDocumentByScopus;
    data['total_citation_by_scopus'] = this.totalCitationByScopus;
    data['document_in_Q1'] = this.documentInQ1;
    data['document_in_Q2'] = this.documentInQ2;
    data['document_in_Q3'] = this.documentInQ3;
    data['document_in_Q4'] = this.documentInQ4;
    data['document_in_noQ'] = this.documentInNoQ;
    data['total_document'] = this.totalDocument;
    data['total_citation'] = this.totalCitation;
    data['total_cited_document'] = this.totalCitedDocument;
    return data;
  }
}

class Wos {
  String? totalDocument;
  String? totalCitation;
  String? totalCitedDocument;

  Wos({this.totalDocument, this.totalCitation, this.totalCitedDocument});

  Wos.fromJson(Map<String, dynamic> json) {
    totalDocument = json['total_document'];
    totalCitation = json['total_citation'];
    totalCitedDocument = json['total_cited_document'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_document'] = this.totalDocument;
    data['total_citation'] = this.totalCitation;
    data['total_cited_document'] = this.totalCitedDocument;
    return data;
  }
}

class Province {
  String? id;
  String? code;
  String? name;

  Province({this.id, this.code, this.name});

  Province.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['code'] = this.code;
    data['name'] = this.name;
    return data;
  }
}