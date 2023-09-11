import 'package:app/common/internetCheck.dart';
import 'package:app/data/source/remote/model/tracer/TracerPie.dart';
import 'package:app/domain/usecases/tracer/getHorizontalPieChart.dart';
import 'package:app/domain/usecases/tracer/getHorizontalTable.dart';
import 'package:app/domain/usecases/tracer/getPekerjaanDibawahEnamBulanPieChart.dart';
import 'package:app/domain/usecases/tracer/getPekerjaanTable.dart';
import 'package:app/domain/usecases/tracer/getVerticalPieChart.dart';
import 'package:app/domain/usecases/tracer/getVerticalTable.dart';
import 'package:app/presentation/pages/beranda/tracerStudy/statistik/hasilStatistik/bloc/statistik_event.dart';
import 'package:app/presentation/pages/beranda/tracerStudy/statistik/hasilStatistik/bloc/statistik_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StatistikTracerBloc
    extends Bloc<StatistikTracerEvent, StatistikTracerState> {
  GetHorizontalPieChart getHorizontalPieChart;
  GetHorizontalTable getHorizontalTable;
  GetVerticalPieChart getVerticalPieChart;
  GetVerticalTable getVerticalTable;
  GetPekerjaanDibawahEnamBulanPieChart getPekerjaanDibawahEnamBulanPieChart;
  GetPekerjaanTable getPekerjaanTable;

  StatistikTracerBloc({
    required this.getHorizontalPieChart,
    required this.getHorizontalTable,
    required this.getVerticalPieChart,
    required this.getVerticalTable,
    required this.getPekerjaanDibawahEnamBulanPieChart,
    required this.getPekerjaanTable,
  }) : super(StatistikTracerLoadingState()) {
    on<GetStatistikTracerEvent>(_getStatistik);
  }

  void _getStatistik(
      GetStatistikTracerEvent event, Emitter<StatistikTracerState> emit) async {
    //emit(StatistikTracerLoadingState());
    TracerPie? horizontalPie =
        TracerPie(data: Data(categories: [], series: []), message: "");
    List<dynamic> horizontalTablePt = [];
    List<dynamic> horizontalTableSelaras = [];
    List<dynamic> horizontalTableSelarasPersentase = [];
    List<dynamic> horizontalTableSelarasGabungan = [];
    List<dynamic> horizontalTableTidakSelaras = [];
    List<dynamic> horizontalTableTidakSelarasPersentase = [];
    List<dynamic> horizontalTableTidakSelarasGabungan = [];

    TracerPie? verticalPie =
        TracerPie(data: Data(categories: [], series: []), message: "");
    List<dynamic> verticalTablePt = [];
    List<dynamic> verticalTableTinggi = [];
    List<dynamic> verticalTableTinggiPersentase = [];
    List<dynamic> verticalTableTinggiGabungan = [];
    List<dynamic> verticalTableSama = [];
    List<dynamic> verticalTableSamaPersentase = [];
    List<dynamic> verticalTableSamaGabungan = [];
    List<dynamic> verticalTableRendah = [];
    List<dynamic> verticalTableRendahPersentase = [];
    List<dynamic> verticalTableRendahGabungan = [];

    TracerPie? pekerjaanDibawahEnamBulanPie =
        TracerPie(data: Data(categories: [], series: []), message: "");
    List<dynamic> pekerjaanTablePt = [];
    List<dynamic> pekerjaanTableYa = [];
    List<dynamic> pekerjaanTableYaPersentase = [];
    List<dynamic> pekerjaanTableYaGabungan = [];
    List<dynamic> pekerjaanTableTidak = [];
    List<dynamic> pekerjaanTableTidakPersentase = [];
    List<dynamic> pekerjaanTableTidakGabungan = [];

    final hasInternet = await InternetCheck().hasConnection();
    if (hasInternet) {
      emit(StatistikTracerLoadingState());

      final resultHorizontalPie =
          await getHorizontalPieChart.execute(event.kodePt!);
      await resultHorizontalPie.fold(
        (failure) {
          horizontalPie = null;
          emit(StatistikTracerErrorState());
        },
        (response) async {
          if (response.data.series[0].data == null) {
            emit(StatistikTracerErrorState());
          } else {
            horizontalPie = response;
          }
        },
      );

      final resultVerticalPie =
          await getVerticalPieChart.execute(event.kodePt!);
      await resultVerticalPie.fold(
        (failure) {
          verticalPie = null;
          emit(StatistikTracerErrorState());
        },
        (response) async {
          if (response.data.series[0].data == null) {
            emit(StatistikTracerErrorState());
          } else {
            verticalPie = response;
          }
        },
      );

      final resultPekerjaanDibawahEnamBulanPie =
          await getPekerjaanDibawahEnamBulanPieChart.execute(event.kodePt!);

      await resultPekerjaanDibawahEnamBulanPie.fold(
        (failure) {
          pekerjaanDibawahEnamBulanPie = null;
          emit(StatistikTracerErrorState());
        },
        (response) async {
          if (response.data.series[0].data == null) {
            emit(StatistikTracerErrorState());
          } else {
            pekerjaanDibawahEnamBulanPie = response;
          }
        },
      );
      final resultHorizontalTable =
          await getHorizontalTable.execute(event.kodePt!);

      await resultHorizontalTable.fold((failure) {
        emit(StatistikTracerErrorState());
      }, (response) async {
        if (response.data.series[1].data == null ||
            response.data.series[2].data == null ||
            response.data.series[3].data == null ||
            response.data.series[4].data == null) {
          emit(StatistikTracerErrorState());
        } else {
          horizontalTablePt = response.data.series[0].data!;

          horizontalTableSelaras = response.data.series[1].data!;
          horizontalTableSelarasPersentase = response.data.series[3].data!;

          horizontalTableTidakSelaras = response.data.series[2].data!;
          horizontalTableTidakSelarasPersentase = response.data.series[4].data!;

          for (int i = 0; i < horizontalTableSelaras.length; i++) {
            horizontalTableSelarasGabungan.add(
                horizontalTableSelaras[i].toString() +
                    "(" +
                    horizontalTableSelarasPersentase[i].toString() +
                    "%)");
          }
          for (int i = 0; i < horizontalTableTidakSelaras.length; i++) {
            horizontalTableTidakSelarasGabungan.add(
                horizontalTableTidakSelaras[i].toString() +
                    "(" +
                    horizontalTableTidakSelarasPersentase[i].toString() +
                    "%)");
          }
        }
        // Logger().d(response.data.series[1].data);
      });

      final resultVerticalTable = await getVerticalTable.execute(event.kodePt!);

      await resultVerticalTable.fold((failure) {
        emit(StatistikTracerErrorState());
      }, (response) async {
        if (response.data.series[1].data == null ||
            response.data.series[2].data == null ||
            response.data.series[3].data == null ||
            response.data.series[4].data == null) {
          emit(StatistikTracerErrorState());
        } else {
          verticalTablePt = response.data.series[0].data!;

          verticalTableTinggi = response.data.series[1].data!;
          verticalTableTinggiPersentase = response.data.series[4].data!;

          verticalTableSama = response.data.series[2].data!;
          verticalTableSamaPersentase = response.data.series[5].data!;

          verticalTableRendah = response.data.series[3].data!;
          verticalTableRendahPersentase = response.data.series[3].data!;

          for (int i = 0; i < verticalTableTinggi.length; i++) {
            verticalTableTinggiGabungan.add(verticalTableTinggi[i].toString() +
                "(" +
                verticalTableTinggiPersentase[i].toString() +
                "%)");
          }
          for (int i = 0; i < verticalTableSama.length; i++) {
            verticalTableSamaGabungan.add(verticalTableSama[i].toString() +
                "(" +
                verticalTableSamaPersentase[i].toString() +
                "%)");
          }
          for (int i = 0; i < verticalTableRendah.length; i++) {
            verticalTableRendahGabungan.add(verticalTableRendah[i].toString() +
                "(" +
                verticalTableRendahPersentase[i].toString() +
                "%)");
          }
        }
      });

      final resultPekerjaanTable =
          await getPekerjaanTable.execute(event.kodePt!);

      await resultPekerjaanTable.fold((failure) {
        emit(StatistikTracerErrorState());
      }, (response) async {
        if (response.data.series[1].data == null ||
            response.data.series[2].data == null ||
            response.data.series[3].data == null ||
            response.data.series[4].data == null) {
          emit(StatistikTracerErrorState());
        } else {
          pekerjaanTablePt = response.data.series[0].data!;

          pekerjaanTableYa = response.data.series[1].data!;
          pekerjaanTableYaPersentase = response.data.series[3].data!;

          pekerjaanTableTidak = response.data.series[2].data!;
          pekerjaanTableTidakPersentase = response.data.series[4].data!;

          for (int i = 0; i < pekerjaanTableYa.length; i++) {
            pekerjaanTableYaGabungan.add(pekerjaanTableYa[i].toString() +
                "(" +
                pekerjaanTableYaPersentase[i].toString() +
                "%)");
          }
          for (int i = 0; i < pekerjaanTableTidak.length; i++) {
            pekerjaanTableTidakGabungan.add(pekerjaanTableTidak[i].toString() +
                "(" +
                pekerjaanTableTidakPersentase[i].toString() +
                "%)");
          }
        }
      });

      if (horizontalPie != null &&
          verticalPie != null &&
          pekerjaanDibawahEnamBulanPie != null &&
          horizontalTablePt.isNotEmpty &&
          horizontalTableSelaras.isNotEmpty &&
          horizontalTableTidakSelaras.isNotEmpty &&
          verticalTablePt.isNotEmpty &&
          verticalTableTinggi.isNotEmpty &&
          verticalTableSama.isNotEmpty &&
          verticalTableRendah.isNotEmpty &&
          pekerjaanTablePt.isNotEmpty &&
          pekerjaanTableYa.isNotEmpty &&
          pekerjaanTableTidak.isNotEmpty) {
        emit(StatistikTracerLoadedState(
            verticalPie: verticalPie!,
            verticalTablePt: verticalTablePt,
            verticalTableTinggi: verticalTableTinggiGabungan,
            verticalTableSama: verticalTableSamaGabungan,
            verticalTableRendah: verticalTableRendahGabungan,
            pekerjaanDibawahEnamBulanPie: pekerjaanDibawahEnamBulanPie!,
            pekerjaanTablePt: pekerjaanTablePt,
            pekerjaanTableYa: pekerjaanTableYaGabungan,
            pekerjaanTableTidak: pekerjaanTableTidakGabungan,
            horizontalPie: horizontalPie!,
            horizontalTablePt: horizontalTablePt,
            horizontalTableSelaras: horizontalTableSelarasGabungan,
            horizontalTableTidakSelaras: horizontalTableTidakSelarasGabungan));
      } else {
        emit(StatistikTracerErrorState());
      }
    } else {
      emit(StatistikTracerNoInternetState());
    }

    //r.data.series[0].data[0][0] = Selaras
    //r.data.series[0].data[0][1] = Value Selaras

    //r.data.series[0].data[1][0] = Tidak Selaras
    //r.data.series[0].data[1][1] = Value Tidak Selaras

    //r.data.series[0].data[2][0] = Selaras Persentase
    //r.data.series[0].data[2][1] = Value Selaras Persentasi

    //r.data.series[0].data[3][0] = Tidak Selaras Persentase
    //r.data.series[0].data[3][1] = Value Tidak Selaras Persentasi
  }
}
