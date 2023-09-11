part of 'pdfviewer_bloc.dart';

abstract class PdfviewerEvent extends Equatable {
  const PdfviewerEvent();

  @override
  List<Object> get props => [];
}

class ChangePagePDFEvent extends PdfviewerEvent {
  final int nextPages;
  final int totalPages;
  ChangePagePDFEvent({required this.nextPages, required this.totalPages});
}

// class ScrollNextPDFEvent extends PdfviewerEvent {
//   final int currentPage;
//   final int totalPages;
//   ScrollNextPDFEvent({required this.currentPage, required this.totalPages});
// }

// class ScrollPreviousPDFEvent extends PdfviewerEvent {
//   final int currentPage;
//   final int totalPages;
//   ScrollPreviousPDFEvent({required this.currentPage, required this.totalPages});
// }
