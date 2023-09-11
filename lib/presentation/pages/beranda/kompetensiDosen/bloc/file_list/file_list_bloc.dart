import 'dart:async';

import 'package:app/common/internetCheck.dart';
import 'package:app/data/source/remote/model/kompetensiDosen/daftarUnduhan.dart';
import 'package:app/domain/usecases/kompetensi_dosen/download_unduhan.dart';
import 'package:app/domain/usecases/kompetensi_dosen/get_file_list.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'file_list_event.dart';
part 'file_list_state.dart';

class FileListBloc extends Bloc<FileListEvent, FileListState> {
  GetFileList getFileListUseCase;
  DownloadUnduhan downloadUnduhanUseCase;
  InternetCheck internetCheck;
  FileListBloc({
    required this.getFileListUseCase,
    required this.downloadUnduhanUseCase,
    required this.internetCheck,
  }) : super(FileListInitial()) {
    on<GetFileListEvent>(_onGetFileList);
    on<DownloadPDFEvent>(_onDownloadPDF);
  }

  FutureOr<void> _onGetFileList(
      GetFileListEvent event, Emitter<FileListState> emit) async {
    final isConnected = await internetCheck.hasConnection();

    if (isConnected) {
      final result = await getFileListUseCase.execute();

      result.fold((failure) {
        print("FAIL");
        emit(FileListError());
      }, (response) {
        print("SUCCESS");
        emit(FileListLoaded(filelist: response.data!.listDaftarUnduhan ?? []));
      });
    } else {
      emit(FileListNoInternet());
    }
  }

  void _onDownloadPDF(DownloadPDFEvent event, Emitter<FileListState> emit) {
    print("Exec");
    downloadUnduhanUseCase.execute(event.id);
  }
}
