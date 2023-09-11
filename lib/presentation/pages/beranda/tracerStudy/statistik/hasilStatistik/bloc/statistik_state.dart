import 'package:app/data/source/remote/model/tracer/TracerPie.dart';
import 'package:equatable/equatable.dart';

abstract class StatistikTracerState extends Equatable {
  const StatistikTracerState();
}

class StatistikTracerLoadingState extends StatistikTracerState {
  @override
  List<Object> get props => [];
}

class StatistikTracerErrorState extends StatistikTracerState {
  @override
  List<Object> get props => [];
}

class StatistikTracerNoInternetState extends StatistikTracerState {
  @override
  List<Object> get props => [];
}

class StatistikTracerLoadedState extends StatistikTracerState {
  final TracerPie horizontalPie;
  final List<dynamic> horizontalTablePt;
  final List<dynamic> horizontalTableSelaras;
  final List<dynamic> horizontalTableTidakSelaras;

  final TracerPie verticalPie;
  final List<dynamic> verticalTablePt;
  final List<dynamic> verticalTableTinggi;
  final List<dynamic> verticalTableSama;
  final List<dynamic> verticalTableRendah;

  final TracerPie pekerjaanDibawahEnamBulanPie;
  final List<dynamic> pekerjaanTablePt;
  final List<dynamic> pekerjaanTableYa;
  final List<dynamic> pekerjaanTableTidak;

  StatistikTracerLoadedState({
    required this.verticalPie,
    required this.verticalTablePt,
    required this.verticalTableTinggi,
    required this.verticalTableSama,
    required this.verticalTableRendah,
    required this.pekerjaanDibawahEnamBulanPie,
    required this.pekerjaanTablePt,
    required this.pekerjaanTableYa,
    required this.pekerjaanTableTidak,
    required this.horizontalPie,
    required this.horizontalTablePt,
    required this.horizontalTableSelaras,
    required this.horizontalTableTidakSelaras,
  });

  @override
  List<Object> get props => [
        horizontalPie,
        horizontalTablePt,
        horizontalTableSelaras,
        verticalPie,
        pekerjaanDibawahEnamBulanPie
      ];
}
