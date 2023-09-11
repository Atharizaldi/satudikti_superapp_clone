import 'package:equatable/equatable.dart';

class DownloaderGMagz extends Equatable {
  late final String message;
  late final int status;

  DownloaderGMagz({required this.message, required this.status});

  DownloaderGMagz.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
  }

  @override
  List<Object> get props => [message, status];
}
