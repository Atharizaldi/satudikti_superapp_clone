class AffiliationsScopus {
  Data? data;
  String? message;

  AffiliationsScopus({this.data, this.message});

  AffiliationsScopus.fromJson(Map<String, dynamic> json) {
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
  Affiliations? affiliations;
  int? page;
  int? items;
  String? orderBy;
  int? total;
  List<Documents>? documents;

  Results(
      {this.affiliations,
        this.page,
        this.items,
        this.orderBy,
        this.total,
        this.documents});

  Results.fromJson(Map<String, dynamic> json) {
    affiliations = json['affiliations'] != null
        ? new Affiliations.fromJson(json['affiliations'])
        : null;
    page = json['page'];
    items = json['items'];
    orderBy = json['order_by'];
    total = json['total'];
    if (json['documents'] != null) {
      documents = <Documents>[];
      json['documents'].forEach((v) {
        documents!.add(new Documents.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.affiliations != null) {
      data['affiliations'] = this.affiliations!.toJson();
    }
    data['page'] = this.page;
    data['items'] = this.items;
    data['order_by'] = this.orderBy;
    data['total'] = this.total;
    if (this.documents != null) {
      data['documents'] = this.documents!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Affiliations {
  String? affiliationId;
  String? codePddikti;
  String? fullname;

  Affiliations({this.affiliationId, this.codePddikti, this.fullname});

  Affiliations.fromJson(Map<String, dynamic> json) {
    affiliationId = json['affiliation_id'];
    codePddikti = json['code_pddikti'];
    fullname = json['fullname'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['affiliation_id'] = this.affiliationId;
    data['code_pddikti'] = this.codePddikti;
    data['fullname'] = this.fullname;
    return data;
  }
}

class Documents {
  String? id;
  String? quartile;
  String? title;
  String? publicationName;
  String? creator;
  String? page;
  String? issn;
  String? volume;
  String? coverDate;
  String? coverDisplayDate;
  String? citedbyCount;
  String? aggregationType;
  String? linkToScopusWebsite;

  Documents(
      {this.id,
        this.quartile,
        this.title,
        this.publicationName,
        this.creator,
        this.page,
        this.issn,
        this.volume,
        this.coverDate,
        this.coverDisplayDate,
        this.citedbyCount,
        this.aggregationType,
        this.linkToScopusWebsite});

  Documents.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    quartile = json['quartile'];
    title = json['title'];
    publicationName = json['publication_name'];
    creator = json['creator'];
    page = json['page'];
    issn = json['issn'];
    volume = json['volume'];
    coverDate = json['cover_date'];
    coverDisplayDate = json['cover_display_date'];
    citedbyCount = json['citedby_count'];
    aggregationType = json['aggregation_type'];
    linkToScopusWebsite = json['link_to_scopus_website'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['quartile'] = this.quartile;
    data['title'] = this.title;
    data['publication_name'] = this.publicationName;
    data['creator'] = this.creator;
    data['page'] = this.page;
    data['issn'] = this.issn;
    data['volume'] = this.volume;
    data['cover_date'] = this.coverDate;
    data['cover_display_date'] = this.coverDisplayDate;
    data['citedby_count'] = this.citedbyCount;
    data['aggregation_type'] = this.aggregationType;
    data['link_to_scopus_website'] = this.linkToScopusWebsite;
    return data;
  }
}

