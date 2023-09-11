part of 'file_list_bloc.dart';

abstract class FileListEvent extends Equatable {
  const FileListEvent();

  @override
  List<Object> get props => [];
}

class GetFileListEvent extends FileListEvent {}

class DownloadPDFEvent extends FileListEvent {
  final String id;
  DownloadPDFEvent({required this.id});
}
