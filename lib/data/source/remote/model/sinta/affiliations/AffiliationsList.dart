class AffiliationsList {
  Data? data;
  String? message;

  AffiliationsList({this.data, this.message});

  AffiliationsList.fromJson(Map<String, dynamic> json) {
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
  int? page;
  int? items;
  String? orderBy;
  int? total;
  List<Affiliations>? affiliations;

  Results({this.page, this.items, this.orderBy, this.total, this.affiliations});

  Results.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    items = json['items'];
    orderBy = json['order_by'];
    total = json['total'];
    if (json['affiliations'] != null) {
      affiliations = <Affiliations>[];
      json['affiliations'].forEach((v) {
        affiliations!.add(new Affiliations.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['page'] = this.page;
    data['items'] = this.items;
    data['order_by'] = this.orderBy;
    data['total'] = this.total;
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
  String? logo;
  String? country;
  String? sintaScoreV3_3year;
  Province? province;
  Province? city;

  Affiliations(
      {this.id,
      this.codePddikti,
      this.name,
      this.abbreviaton,
      this.logo,
      this.country,
      this.sintaScoreV3_3year,
      this.province,
      this.city});

  Affiliations.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    codePddikti = json['code_pddikti'];
    name = json['name'];
    abbreviaton = json['abbreviaton'];
    logo = json['logo'];
    country = json['country'];
    sintaScoreV3_3year = json['sinta_score_v3_3year'];
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
    data['logo'] = this.logo;
    data['country'] = this.country;
    data['sinta_score_v3_3year'] = this.sintaScoreV3_3year;
    if (this.province != null) {
      data['province'] = this.province!.toJson();
    }
    if (this.city != null) {
      data['city'] = this.city!.toJson();
    }
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
