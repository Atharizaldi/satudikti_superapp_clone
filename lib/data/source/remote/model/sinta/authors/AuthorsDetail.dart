class AuthorsDetail {
  String? message;
  Data? data;

  AuthorsDetail({this.message, this.data});

  AuthorsDetail.fromJson(Map<String, dynamic> json) {
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
  Author? author;

  Data({this.author});

  Data.fromJson(Map<String, dynamic> json) {
    author =
    json['author'] != null ? new Author.fromJson(json['author']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.author != null) {
      data['author'] = this.author!.toJson();
    }
    return data;
  }
}

class Author {
  String? id;
  String? nidn;
  String? name;
  String? country;
  String? sintaScoreV33Year;
  String? sintaScoreV3Overall;
  Affiliation? affiliation;
  String? affiliationScoreV33year;
  String? affiliationScoreV3Overall;
  Program? program;
  Scopus? scopus;
  Wos? wos;
  Garuda? garuda;
  Google? google;
  String? linkProfile;

  Author(
      {this.id,
        this.nidn,
        this.name,
        this.country,
        this.sintaScoreV33Year,
        this.sintaScoreV3Overall,
        this.affiliation,
        this.affiliationScoreV33year,
        this.affiliationScoreV3Overall,
        this.program,
        this.scopus,
        this.wos,
        this.garuda,
        this.google,
        this.linkProfile});

  Author.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nidn = json['nidn'];
    name = json['name'];
    country = json['country'];
    sintaScoreV33Year = json['sinta_score_v33_year'];
    sintaScoreV3Overall = json['sinta_score_v3_overall'];
    affiliation = json['affiliation'] != null
        ? new Affiliation.fromJson(json['affiliation'])
        : null;
    affiliationScoreV33year = json['affiliation_score_v3_3year'];
    affiliationScoreV3Overall = json['affiliation_score_v3_overall'];
    program =
    json['program'] != null ? new Program.fromJson(json['program']) : null;
    scopus =
    json['scopus'] != null ? new Scopus.fromJson(json['scopus']) : null;
    wos = json['wos'] != null ? new Wos.fromJson(json['wos']) : null;
    garuda =
    json['garuda'] != null ? new Garuda.fromJson(json['garuda']) : null;
    google =
    json['google'] != null ? new Google.fromJson(json['google']) : null;
    linkProfile = json['link_profile'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nidn'] = this.nidn;
    data['name'] = this.name;
    data['country'] = this.country;
    data['sinta_score_v33_year'] = this.sintaScoreV33Year;
    data['sinta_score_v3_overall'] = this.sintaScoreV3Overall;
    if (this.affiliation != null) {
      data['affiliation'] = this.affiliation!.toJson();
    }
    data['affiliation_score_v3_3year'] = this.affiliationScoreV33year;
    data['affiliation_score_v3_overall'] = this.affiliationScoreV3Overall;
    if (this.program != null) {
      data['program'] = this.program!.toJson();
    }
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
    data['link_profile'] = this.linkProfile;
    return data;
  }
}

class Affiliation {
  String? id;
  String? code;
  String? name;

  Affiliation({this.id, this.code, this.name});

  Affiliation.fromJson(Map<String, dynamic> json) {
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

class Program {
  String? code;
  String? level;
  String? name;

  Program({this.code, this.level, this.name});

  Program.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    level = json['level'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['level'] = this.level;
    data['name'] = this.name;
    return data;
  }
}

class Scopus {
  String? totalDocument;
  String? totalCitation;
  String? totalCitedDoc;
  String? hIndex;
  String? i10Index;
  String? gIndex;
  String? gIndex3year;

  Scopus(
      {this.totalDocument,
        this.totalCitation,
        this.totalCitedDoc,
        this.hIndex,
        this.i10Index,
        this.gIndex,
        this.gIndex3year});

  Scopus.fromJson(Map<String, dynamic> json) {
    totalDocument = json['total_document'];
    totalCitation = json['total_citation'];
    totalCitedDoc = json['total_cited_doc'];
    hIndex = json['h_index'];
    i10Index = json['i10_index'];
    gIndex = json['g_index'];
    gIndex3year = json['g_index_3year'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_document'] = this.totalDocument;
    data['total_citation'] = this.totalCitation;
    data['total_cited_doc'] = this.totalCitedDoc;
    data['h_index'] = this.hIndex;
    data['i10_index'] = this.i10Index;
    data['g_index'] = this.gIndex;
    data['g_index_3year'] = this.gIndex3year;
    return data;
  }
}

class Wos {
  String? totalDocument;
  String? totalCitation;
  String? totalCitedDoc;
  String? hIndex;

  Wos(
      {this.totalDocument,
        this.totalCitation,
        this.totalCitedDoc,
        this.hIndex});

  Wos.fromJson(Map<String, dynamic> json) {
    totalDocument = json['total_document'];
    totalCitation = json['total_citation'];
    totalCitedDoc = json['total_cited_doc'];
    hIndex = json['h_index'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_document'] = this.totalDocument;
    data['total_citation'] = this.totalCitation;
    data['total_cited_doc'] = this.totalCitedDoc;
    data['h_index'] = this.hIndex;
    return data;
  }
}

class Garuda {
  String? totalDocument;
  String? totalCitation;
  String? totalCitedDoc;

  Garuda({this.totalDocument, this.totalCitation, this.totalCitedDoc});

  Garuda.fromJson(Map<String, dynamic> json) {
    totalDocument = json['total_document'];
    totalCitation = json['total_citation'];
    totalCitedDoc = json['total_cited_doc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_document'] = this.totalDocument;
    data['total_citation'] = this.totalCitation;
    data['total_cited_doc'] = this.totalCitedDoc;
    return data;
  }
}

class Google {
  String? totalDocument;
  String? totalCitation;
  String? totalCitedDoc;
  String? hIndex;
  String? i10Index;
  String? gIndex;

  Google(
      {this.totalDocument,
        this.totalCitation,
        this.totalCitedDoc,
        this.hIndex,
        this.i10Index,
        this.gIndex});

  Google.fromJson(Map<String, dynamic> json) {
    totalDocument = json['total_document'];
    totalCitation = json['total_citation'];
    totalCitedDoc = json['total_cited_doc'];
    hIndex = json['h_index'];
    i10Index = json['i10_index'];
    gIndex = json['g_index'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_document'] = this.totalDocument;
    data['total_citation'] = this.totalCitation;
    data['total_cited_doc'] = this.totalCitedDoc;
    data['h_index'] = this.hIndex;
    data['i10_index'] = this.i10Index;
    data['g_index'] = this.gIndex;
    return data;
  }
}

