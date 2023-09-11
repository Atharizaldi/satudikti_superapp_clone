class GarudaPaper {
  Data? data;
  String message;
  GarudaPaper({this.data, required this.message});

  factory GarudaPaper.fromJson(Map<String, dynamic> json) =>
      GarudaPaper(data: Data.fromJson(json['data']), message: json['message']);
}

class Data {
  final int page;
  final int items;
  final int total;
  final List<ListPaperGaruda> listPaperGaruda;

  Data(
      {required this.page,
      required this.items,
      required this.total,
      required this.listPaperGaruda});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
      page: json['page'],
      items: json['items'],
      total: json['total'],
      listPaperGaruda: List.from(json['documents'])
          .map((e) => ListPaperGaruda.fromJson(e))
          .toList());
}

class ListPaperGaruda {
  final String title;
  final String publisher;
  final String sourceName;
  final JournalPaper journalPaper;
  final String sourceIssue;
  final String abstract;
  final String downloadOriginal;
  final String downloadBibtex;
  final String downloadRis;

  ListPaperGaruda(
      {required this.title,
      required this.publisher,
      required this.sourceName,
      required this.journalPaper,
      required this.sourceIssue,
      required this.abstract,
      required this.downloadOriginal,
      required this.downloadBibtex,
      required this.downloadRis});

  factory ListPaperGaruda.fromJson(Map<String, dynamic> json) =>
      ListPaperGaruda(
          title: json['title'],
          publisher: json['publisher'],
          sourceName: json['source_name'],
          journalPaper: JournalPaper.fromJson(json['journal']),
          sourceIssue: json['source_issue'],
          abstract: json['abstract'],
          downloadOriginal: json['download_original'],
          downloadBibtex: json['download_bibtex'],
          downloadRis: json['download_ris']);
}

class JournalPaper {
  final String journalName;
  final String journalIssn;
  final String journalEissn;
  final String journalDescription;
  JournalPaper(
      {required this.journalName,
      required this.journalIssn,
      required this.journalEissn,
      required this.journalDescription});

  factory JournalPaper.fromJson(Map<String, dynamic> json) => JournalPaper(
      journalName: json['journal_name'],
      journalIssn: json['journal_issn'],
      journalEissn: json['journal_eissn'],
      journalDescription: json['journal_description']);
}
