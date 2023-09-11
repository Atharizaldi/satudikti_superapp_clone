class AuthorsScopus {
  String? message;
  Data? data;

  AuthorsScopus({this.message, this.data});

  AuthorsScopus.fromJson(Map<String, dynamic> json) {
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
  Authors? authors;
  int? page;
  int? items;
  int? total;
  String? orderBy;
  List<Scopus>? scopus;

  Data(
      {this.authors,
        this.page,
        this.items,
        this.total,
        this.orderBy,
        this.scopus});

  Data.fromJson(Map<String, dynamic> json) {
    authors =
    json['authors'] != null ? new Authors.fromJson(json['authors']) : null;
    page = json['page'];
    items = json['items'];
    total = json['total'];
    orderBy = json['order_by'];
    if (json['scopus'] != null) {
      scopus = <Scopus>[];
      json['scopus'].forEach((v) {
        scopus!.add(new Scopus.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.authors != null) {
      data['authors'] = this.authors!.toJson();
    }
    data['page'] = this.page;
    data['items'] = this.items;
    data['total'] = this.total;
    data['order_by'] = this.orderBy;
    if (this.scopus != null) {
      data['scopus'] = this.scopus!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Authors {
  String? id;
  String? nidn;
  String? name;
  Affiliation? affiliation;

  Authors({this.id, this.nidn, this.name, this.affiliation});

  Authors.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nidn = json['nidn'];
    name = json['name'];
    affiliation = json['affiliation'] != null
        ? new Affiliation.fromJson(json['affiliation'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nidn'] = this.nidn;
    data['name'] = this.name;
    if (this.affiliation != null) {
      data['affiliation'] = this.affiliation!.toJson();
    }
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

class Scopus {
  String? id;
  String? title;
  String? publicationName;
  String? creator;
  String? quartile;
  String? citedByCount;
  String? linkToScopusWebsite;

  Scopus(
      {this.id,
        this.title,
        this.publicationName,
        this.creator,
        this.quartile,
        this.citedByCount,
        this.linkToScopusWebsite});

  Scopus.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    publicationName = json['publication_name'];
    creator = json['creator'];
    quartile = json['quartile'];
    citedByCount = json['cited_by_count'];
    linkToScopusWebsite = json['link_to_scopus_website'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['publication_name'] = this.publicationName;
    data['creator'] = this.creator;
    data['quartile'] = this.quartile;
    data['cited_by_count'] = this.citedByCount;
    data['link_to_scopus_website'] = this.linkToScopusWebsite;
    return data;
  }
}

