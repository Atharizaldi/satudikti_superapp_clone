import 'package:app/injection.dart' as di;
import 'package:app/presentation/component/constant.dart';
import 'package:app/presentation/component/customSliverBar.dart';
import 'package:app/presentation/pages/beranda/pddikti/cubit/tab_bar/tab_bar_cubit.dart';
import 'package:app/presentation/pages/beranda/sivil/bloc/sivil_bloc.dart';
import 'package:app/presentation/pages/beranda/sivil/component/text_field_sivil.dart';
import 'package:app/presentation/pages/beranda/tracerStudy/statistik/hasilStatistik/bloc/statistik_bloc.dart';
import 'package:app/presentation/pages/beranda/tracerStudy/statistik/hasilStatistik/bloc/statistik_event.dart';
import 'package:app/presentation/pages/beranda/tracerStudy/statistik/hasilStatistik/hasilStatistikTracer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logger/logger.dart';

import '../component/alertinfo_card.dart';

class StatistikTracer extends StatefulWidget {
  const StatistikTracer({Key? key}) : super(key: key);

  @override
  _StatistikTracerState createState() => _StatistikTracerState();
}

class _StatistikTracerState extends State<StatistikTracer> {
  late SivilBloc _sivilBloc;
  List<String>? recentDocument;
  TextEditingController ptTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _sivilBloc = BlocProvider.of<SivilBloc>(context);
    return Container(
      decoration: BoxDecoration(gradient: sliverBgGradient),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: CustomSliverBar(
          expandedHeight: 260.w,
          appBarTitle: "Statistik",
          header: FlexibleSpaceBar(
            background: Header(),
          ),
          child: Container(
            color: whiteBgPage,
            padding: EdgeInsets.only(
              left: 16.w,
              right: 16.w,
              top: 32.w,
              bottom: 200.h,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _informasi(),
                SizedBox(
                  height: 20.h,
                ),
                _textField(),
                SizedBox(
                  height: 28.h,
                ),
                _buttonCari(),
                SizedBox(
                  height: 30.h,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _informasi() {
    return AlertInfoCard(
      textinfo: 'Silahkan masukan nama perguruan tinggi yang ingin anda cari.',
      textdescription: 'Contoh: Akademi, Institut, Politeknik, Universitas dan Sekolah Tinggi',);
  }

  Widget _textField() {
    return Column(
      children: [
        _typeFormPerguruanTinggi(),
        SizedBox(
          height: 20.h,
        ),
      ],
    );
  }

  Widget _typeFormPerguruanTinggi() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            children: [
              WidgetSpan(
                child: Image.asset(
                  'assets/sivil/icon_perguruantinggi.png',
                  width: 21.w,
                  height: 19.w,
                ),
              ),
              WidgetSpan(
                child: SizedBox(
                  width: 8.w,
                ),
              ),
              TextSpan(
                text: 'Perguruan Tinggi',
                style: TextStyle(
                    color: blue4,
                    fontSize: 12.sp,
                    letterSpacing: 0.5,
                    fontWeight: FontWeight.w400),
              ),
              TextSpan(
                text: '*',
                style: TextStyle(
                    color: Colors.red,
                    fontSize: 12.sp,
                    letterSpacing: 0.5,
                    fontWeight: FontWeight.w400),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 6.h,
        ),
        textFieldPT(context, ptTextController),
      ],
    );
  }

  Widget _buttonCari() {
    return BlocBuilder<SivilBloc, SivilState>(
      builder: (context, state) {
        if (state is SivilInitialState) {
          String kodePt = state.pt?.kode ?? '';
          bool isTextFilled = allFieldFilled(kodePt);
          return Align(
            alignment: Alignment.center,
            child: GestureDetector(
              onTap: () {
                if (isTextFilled) {
                  Logger().i(kodePt);
                  String namaPt = ptTextController.text;
                  _onClickHasilStatistik(kodePt, namaPt);
                  FocusManager.instance.primaryFocus?.unfocus();
                } else {
                  SnackBar isiPt = SnackBar(
                    content: Text(
                      'Harap isi semua kolom terlebih dahulu',
                      style: TextStyle(fontSize: 12.sp),
                    ),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(isiPt);
                }
              },
              child: Container(
                height: 50.h,
                width: 358.w,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: biruMuda2,
                  borderRadius: BorderRadius.circular(5.r),
                ),
                child: Text(
                  'Cari',
                  style: TextStyle(
                    color: white,
                    fontSize: 14.sp,
                    letterSpacing: 0.5,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          );
        }
        return Container();
      },
    );
  }

  void _onClickHasilStatistik(String kodePt, String namaPt) {
    ptTextController.clear();
    _sivilBloc..add(ClearEvent());
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MultiBlocProvider(
          providers: [
            BlocProvider<StatistikTracerBloc>(
              create: (BuildContext context) =>
                  di.locator<StatistikTracerBloc>()
                    ..add(GetStatistikTracerEvent(kodePt)),
            ),
            BlocProvider(
              create: (context) => TabBarCubit(),
            ),
            BlocProvider(
              create: (context) => di.locator<SivilBloc>(),
            ),
          ],
          child: HasilStatistik(
            namaPt: namaPt,
            kodePt: kodePt,
          ),
        ),
      ),
    );
  }

  bool allFieldFilled(String? kodePt) {
    bool ptAvailable = kodePt != null && kodePt != "";
    if (ptAvailable) {
      return true;
    } else {
      return false;
    }
  }

  @override
  void dispose() {
    ptTextController.dispose();
    super.dispose();
  }
}

class Header extends StatelessWidget {
  const Header({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(gradient: beasiswaBgGradient),
      child: Stack(
        children: [
          Positioned(
            right: -4.w,
            bottom: -6.w,
            child: Opacity(
              opacity: 0.75,
              child: Image.asset(
                'assets/ijazahln/ilus_caript.png',
                width: 182.w,
                height: 182.w,
              ),
            ),
          ),
          Positioned(
            left: 23.w,
            bottom: 70.w,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Data Tracer Study",
                  style: TextStyle(
                      color: whiteBgPage,
                      fontWeight: FontWeight.bold,
                      fontSize: 20.sp,
                      letterSpacing: 0.08.sp),
                ),
                SizedBox(
                  height: 12.h,
                ),
                Container(
                  width: 250.w,
                  child: Text(
                    "Cari Perguruan Tinggi untuk menemukan statistik pada Tracer Study",
                    style: TextStyle(
                        color: white,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
