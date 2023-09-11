import 'package:collection/collection.dart';

class Tableau {
  Tableau({
    required this.data,
    required this.message,
  });

  late final Data data;
  late final String message;

  Tableau.fromJson(Map<String, dynamic> json) {
    data = Data.fromJson(json['data']);
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['data'] = data.toJson();
    _data['message'] = message;
    return _data;
  }

  @override
  bool operator ==(Object other) =>
    other is Tableau &&
    data == other.data &&
    message == other.message;

  @override
  int get hashCode => Object.hash( data, message);
}

class Data {
  Data({
    required this.tableauPddikti,
  });

  late final List<TableauPddikti> tableauPddikti;

  Data.fromJson(Map<String, dynamic> json) {
    tableauPddikti = List.from(json['tableau'])
        .map((e) => TableauPddikti.fromJson(e))
        .toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['tableau'] = tableauPddikti.map((e) => e.toJson()).toList();
    return _data;
  }

  @override
  bool operator ==(Object other) {
    return other is Data &&
        IterableEquality().equals(tableauPddikti, other.tableauPddikti);
  }
  @override
  int get hashCode {
    return const IterableEquality().hash(tableauPddikti);
  }

}

class TableauPddikti {
  TableauPddikti({
    required this.tableauKey,
    required this.moduleAtribut,
    required this.moduleValue,
  });

  late final String tableauKey;
  late final String moduleAtribut;
  late final int moduleValue;

  TableauPddikti.fromJson(Map<String, dynamic> json) {
    tableauKey = json['tableau_key'];
    moduleAtribut = json['module_atribut'];
    moduleValue = json['module_value'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['tableau_key'] = tableauKey;
    _data['module_atribut'] = moduleAtribut;
    _data['module_value'] = moduleValue;
    return _data;
  }

  @override
  bool operator ==(Object other) =>
     other is TableauPddikti &&
    tableauKey == other.tableauKey &&
    moduleAtribut == other.moduleAtribut &&
    moduleValue == other.moduleValue;

  @override
  int get hashCode => Object.hash( tableauKey, moduleAtribut,moduleValue);
}
