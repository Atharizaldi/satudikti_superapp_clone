import 'package:collection/collection.dart';

class TracerTable {
  TracerTable({
    required this.data,
    required this.message,
  });

  DataTable data;
  String message;

  factory TracerTable.fromJson(Map<String, dynamic> json) => TracerTable(
        data: DataTable.fromJson(json["data"]),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
        "message": message,
      };

  @override
  bool operator ==(Object other) =>
    other is TracerTable &&
        data == other.data &&
        message == other.message;

  @override
  int get hashCode => Object.hash( data, message);
}

class DataTable {
  DataTable({
    required this.categories,
    required this.series,
  });

  List<String> categories;
  List<Series> series;

  factory DataTable.fromJson(Map<String, dynamic> json) => DataTable(
        categories: List<String>.from(json["categories"].map((x) => x)),
        series:
            List<Series>.from(json["series"].map((x) => Series.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "categories": List<dynamic>.from(categories.map((x) => x)),
        "series": List<dynamic>.from(series.map((x) => x.toJson())),
      };

  @override
  bool operator ==(Object other) =>
     other is DataTable &&
        IterableEquality().equals(series, other.series) &&
        IterableEquality().equals(categories, other.categories);

  @override
  int get hashCode => Object.hash( series, categories);
}

class Series {
  Series({
    required this.name,
    required this.data,
  });

  String name;
  List<dynamic>? data;

  factory Series.fromJson(Map<String, dynamic> json) => Series(
        name: json["name"],
        data: json["data"] != null
            ? List<dynamic>.from(json["data"].map((x) => x))
            : null,
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "data": List<dynamic>.from(data!.map((x) => x)),
      };

  @override
  bool operator ==(Object other) =>
     other is Series &&
        name == other.name &&
        IterableEquality().equals(data, other.data);

  @override
  int get hashCode => Object.hash( name, data);
}
