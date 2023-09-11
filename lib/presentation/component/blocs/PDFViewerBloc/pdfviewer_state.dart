part of 'pdfviewer_bloc.dart';

abstract class PdfviewerState extends Equatable {
  const PdfviewerState();

  @override
  List<Object> get props => [];
}

class PdfviewerInitial extends PdfviewerState {}

class PdfviewerLoading extends PdfviewerState {}

class PdfViewerLoaded extends PdfviewerState {
  final int currentPage;
  final int totalPages;

  PdfViewerLoaded({required this.currentPage, required this.totalPages});
}
