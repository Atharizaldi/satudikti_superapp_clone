class AuthorsList {
  String? message;
  Data? data;

  AuthorsList({this.message, this.data});

  AuthorsList.fromJson(Map<String, dynamic> json) {
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
  List<Authors>? authors;

  Data({this.page, this.items, this.total, this.orderBy, this.authors});

  Data.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    items = json['items'];
    total = json['total'];
    orderBy = json['order_by'];
    if (json['authors'] != null) {
      authors = <Authors>[];
      json['authors'].forEach((v) {
        authors!.add(new Authors.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['page'] = this.page;
    data['items'] = this.items;
    data['total'] = this.total;
    data['order_by'] = this.orderBy;
    if (this.authors != null) {
      data['authors'] = this.authors!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Authors {
  String? id;
  String? nidn;
  String? name;
  String? score;
  Affiliation? affiliation;

  Authors({this.id, this.nidn, this.name, this.score, this.affiliation});

  Authors.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nidn = json['nidn'];
    name = json['name'];
    score = json['score'];
    affiliation = json['affiliation'] != null
        ? new Affiliation.fromJson(json['affiliation'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nidn'] = this.nidn;
    data['name'] = this.name;
    data['score'] = this.score;
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

