import 'package:collection/collection.dart';

class TracerPie {
  TracerPie({
    required this.data,
    required this.message,
  });

  Data data;
  String message;

  factory TracerPie.fromJson(Map<String, dynamic> json) => TracerPie(
        data: Data.fromJson(json["data"]),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
        "message": message,
      };

  @override
  bool operator ==(Object other) =>
     other is TracerPie && data == other.data && message == other.message;

  @override
  int get hashCode => Object.hash( data, message);
}

class Data {
  Data({
    required this.categories,
    required this.series,
  });

  List<String> categories;
  List<Series> series;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
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
    other is Data &&
        IterableEquality().equals(series, other.series) &&
        IterableEquality().equals(categories, other.categories);

  @override
  int get hashCode => Object.hash( series, categories);
}

class Series {
  Series({
    required this.name,
    required this.type,
    required this.data,
  });

  String name;
  String type;
  List<List<dynamic>>? data;

  factory Series.fromJson(Map<String, dynamic> json) => Series(
        name: json["name"],
        type: json["type"],
        data: json["data"] != null
            ? List<List<dynamic>>.from(
                json["data"].map((x) => List<dynamic>.from(x.map((x) => x))))
            : null,
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "type": type,
        "data": List<dynamic>.from(
            data!.map((x) => List<dynamic>.from(x.map((x) => x)))),
      };

  @override
  bool operator ==(Object other) =>
     other is Series &&
        name == other.name &&
        type == other.type &&
        IterableEquality().equals(data, other.data);

  @override
  int get hashCode => Object.hash( name, type, data);
}
