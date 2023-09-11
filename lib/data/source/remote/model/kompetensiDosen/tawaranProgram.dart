import 'package:html_unescape/html_unescape.dart';

class TawaranProgram {
  final int id;
  final String? namaPeriode, skema, program, startDate, endDate;

  TawaranProgram({
    required this.id,
    this.namaPeriode,
    this.skema,
    this.program,
    this.startDate,
    this.endDate,
  });

  factory TawaranProgram.fromJson(Map<String, dynamic> json) {
    return TawaranProgram(
      id: json['id_periode'],
      namaPeriode: json['nm_periode'],
      skema: removeHtmlTags(json['skema']),
      program: json['program'],
      startDate: json['buka'],
      endDate: json['tutup'],
    );
  }

  static String removeHtmlTags(String htmlText) {
    final unescape = HtmlUnescape();
    String cleanedText = unescape.convert(htmlText);

    // Hapus karakter tambahan yang mungkin tersisa setelah menghapus tag HTML
    cleanedText = cleanedText.replaceAll('&nbsp;', '');

    return cleanedText.trim();
  }
}


class DataTawaranProgram {
  final List<TawaranProgram>? listTawaranProgram;

  DataTawaranProgram({this.listTawaranProgram});

  factory DataTawaranProgram.fromJson(Map<String, dynamic> json) {
    return DataTawaranProgram(
      listTawaranProgram: List.from(json['Grup Program Dosen'])
          .map<TawaranProgram>((e) => TawaranProgram.fromJson(e))
          .toList(),
    );
  }
}

class TawaranProgramResponse {
  final DataTawaranProgram? data;
  final String? message;

  TawaranProgramResponse({this.data, this.message});

  factory TawaranProgramResponse.fromJson(Map<String, dynamic> json) {
    return TawaranProgramResponse(
      data: DataTawaranProgram.fromJson(json['data']),
      message: json['message'],
    );
  }
}