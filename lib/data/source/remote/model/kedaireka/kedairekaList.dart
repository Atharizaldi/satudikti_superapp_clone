class ModelKedairekaIndustri {
  final DataModelKedaireka? data;

  ModelKedairekaIndustri({this.data});

  factory ModelKedairekaIndustri.fromJson(Map<String, dynamic> json) =>
      ModelKedairekaIndustri(data: DataModelKedaireka.fromJson(json['data']));
}

class DataModelKedaireka {
  final List<ListKedairekaIndustri>? listData;

  DataModelKedaireka({this.listData});
  factory DataModelKedaireka.fromJson(Map<String, dynamic> json) =>
      DataModelKedaireka(
          listData: List.from(json['list'])
              .map((e) => ListKedairekaIndustri.fromJson(e))
              .toList());
}

class ListKedairekaIndustri {
  final String? title;
  final String? categories;
  final List<dynamic>? description;
  final UserProfileKedaireka? userProfile;

  ListKedairekaIndustri(
      {this.title, this.description, this.userProfile, this.categories});
  factory ListKedairekaIndustri.fromJson(Map<String, dynamic> json) =>
      ListKedairekaIndustri(
          userProfile: UserProfileKedaireka.fromJson(json['user_profile']),
          title: json['title'],
          description: json['description'],
          categories: json['categories']);
}

class UserProfileKedaireka {
  final String? nama;
  final String? namaPT;
  final String? namaUniv;

  UserProfileKedaireka({this.nama, this.namaPT, this.namaUniv});

  factory UserProfileKedaireka.fromJson(Map<String, dynamic> json) =>
      UserProfileKedaireka(
          nama: json['name'],
          namaPT: json['company_name'],
          namaUniv: json['organisation_name']);
}
