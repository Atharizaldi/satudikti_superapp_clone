import 'package:app/common/internetCheck.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'pdfviewer_event.dart';
part 'pdfviewer_state.dart';

class PdfviewerBloc extends Bloc<PdfviewerEvent, PdfviewerState> {
  InternetCheck internetCheck;
  PdfviewerBloc({required this.internetCheck}) : super(PdfviewerInitial()) {
    on<ChangePagePDFEvent>(_onChangePagePDFEvent);
  }

  void _onChangePagePDFEvent(
      ChangePagePDFEvent event, Emitter<PdfviewerState> emit) {
    emit(PdfviewerLoading());
    emit(PdfViewerLoaded(
        currentPage: event.nextPages, totalPages: event.totalPages));
  }
}
