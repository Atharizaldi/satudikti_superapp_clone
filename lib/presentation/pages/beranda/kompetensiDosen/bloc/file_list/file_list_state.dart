part of 'file_list_bloc.dart';

abstract class FileListState extends Equatable {
  const FileListState();

  @override
  List<Object> get props => [];
}

class FileListInitial extends FileListState {}

class FileListError extends FileListState {}

class FileListNoInternet extends FileListState {}

class FileListLoaded extends FileListState {
  final List<DaftarUnduhan> filelist;

  FileListLoaded({required this.filelist});
}
