class ModelStatistikGaruda {
  final DataModelStatistikGaruda? data;

  ModelStatistikGaruda({this.data});

  factory ModelStatistikGaruda.fromJson(Map<String, dynamic> json) =>
      ModelStatistikGaruda(
          data: DataModelStatistikGaruda.fromJson(json['data']));
}

class DataModelStatistikGaruda {
  final List<ListStatistikGaruda>? listData;

  DataModelStatistikGaruda({this.listData});
  factory DataModelStatistikGaruda.fromJson(Map<String, dynamic> json) =>
      DataModelStatistikGaruda(
          listData: List.from(json['tableau'])
              .map((e) => ListStatistikGaruda.fromJson(e))
              .toList());
}

class ListStatistikGaruda {
  final String? attribute;
  final int? value;

  ListStatistikGaruda({this.attribute, this.value});
  factory ListStatistikGaruda.fromJson(Map<String, dynamic> json) =>
      ListStatistikGaruda(
          attribute: json['module_atribut'], value: json['module_value']);
}
