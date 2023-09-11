import 'package:app/injection.dart' as di;
import 'package:app/presentation/component/constant.dart';
import 'package:app/presentation/component/customAppBar.dart';
import 'package:app/presentation/pages/beranda/pddikti/component/tabBarButton.dart';
import 'package:app/presentation/pages/beranda/pddikti/cubit/tab_bar/tab_bar_cubit.dart';
import 'package:app/presentation/pages/beranda/sivil/bloc/sivil_bloc.dart';
import 'package:app/presentation/pages/beranda/sivil/component/text_field_sivil.dart';
import 'package:app/presentation/pages/beranda/tracerStudy/statistik/hasilStatistik/bloc/statistik_bloc.dart';
import 'package:app/presentation/pages/beranda/tracerStudy/statistik/hasilStatistik/bloc/statistik_event.dart';
import 'package:app/presentation/pages/beranda/tracerStudy/statistik/hasilStatistik/keselarasanHorizontal/keselarasanHorizontal.dart';
import 'package:app/presentation/pages/beranda/tracerStudy/statistik/hasilStatistik/keselarasanVertical/keselarasanVertical.dart';
import 'package:app/presentation/pages/beranda/tracerStudy/statistik/hasilStatistik/pekerjaanDibawahEnamBulan/pekerjaanDibawahEnamBulan.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HasilStatistik extends StatefulWidget {
  final String? kodePt;
  final String? namaPt;

  HasilStatistik({Key? key, required this.kodePt, required this.namaPt})
      : super(key: key);

  @override
  _HasilStatistikState createState() => _HasilStatistikState();
}

class _HasilStatistikState extends State<HasilStatistik>
    with SingleTickerProviderStateMixin {
  //late SivilBloc _sivilBloc;
  late StatistikTracerBloc _statBloc;
  TextEditingController ptTextController = TextEditingController();
  late TabController tabController;

  @override
  void initState() {
    tabController = new TabController(length: 3, vsync: this);
    tabController.addListener(() {
      BlocProvider.of<TabBarCubit>(context).changeTabIndex(tabController.index);
    });
    ptTextController.text = widget.namaPt ?? "";

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _statBloc = BlocProvider.of<StatistikTracerBloc>(context);
    return BlocProvider(
      create: (context) => di.locator<StatistikTracerBloc>()
        ..add(GetStatistikTracerEvent(widget.kodePt)),
      child: Scaffold(
        appBar: CustomAppBar(
          title: "Statistik",
        ),
        body: Container(
          //margin: EdgeInsets.only(top: 20.h),
          child: Scaffold(
            backgroundColor: whiteBgPage,
            body: Container(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 18.0, vertical: 20),
                    child: Column(
                      children: [
                        _textField(),
                        _buttonCari(),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  hasilTracerTabBar(
                    context: context,
                    tabController: tabController,
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Expanded(
                    child: TabBarView(
                      controller: tabController,
                      children: [
                        KeselarasanHorizontal(
                          kodePt: widget.kodePt,
                          namaPt: widget.namaPt,
                        ),
                        KeselarasanVertical(
                          kodePt: widget.kodePt,
                          namaPt: widget.namaPt,
                        ),
                        PekerjaanDibawahEnamBulan(
                          kodePt: widget.kodePt,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
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
                  //Logger().d("TESTING BUTTON: " + kodePt);

                  // BlocProvider<StatistikTracerBloc>(
                  //   create: (BuildContext context) =>
                  //       di.locator<StatistikTracerBloc>()
                  //         ..add(GetStatistikTracerEvent(kodePt)),
                  // );
                  context
                      .read<StatistikTracerBloc>()
                      .add(GetStatistikTracerEvent(kodePt));

                  // BlocProvider.of<StatistikTracerBloc>(context)
                  //     .add(GetStatistikTracerEvent(kodePt));

                  // di.locator<StatistikTracerBloc>()
                  //   ..add(GetStatistikTracerEvent(kodePt));
                  FocusManager.instance.primaryFocus?.unfocus();
                } else {
                  SnackBar isiPt = SnackBar(
                    content: Text(
                      'Harap ubah isi kolom terlebih dahulu',
                      style: TextStyle(fontSize: 12.sp),
                    ),
                  );
                  //ScaffoldMessenger.of(context).showSnackBar(isiPt);
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

  // void _onClickHasilStatistik(String kodePt) {
  //   ptTextController.clear();
  //   //_sivilBloc..add(ClearEvent());
  //   //_statBloc.add(GetStatistikTracerEvent(kodePt));
  //   //setState(() {});
  //   // Navigator.push(
  //   //   context,
  //   //   MaterialPageRoute(
  //   //     builder: (context) => MultiBlocProvider(
  //   //       providers: [
  //   //         BlocProvider(
  //   //           create: (context) => TabBarCubit(),
  //   //         ),
  //   //         BlocProvider(
  //   //           create: (context) => di.locator<SivilBloc>(),
  //   //         ),
  //   //       ],
  //   //       child: HasilStatistik(
  //   //         kodePt: kodePt,
  //   //       ),
  //   //     ),
  //   //   ),
  //   // );
  // }

  bool allFieldFilled(String? kodePt) {
    bool ptAvailable = kodePt != null && kodePt != "";
    if (ptAvailable) {
      return true;
    } else {
      return false;
    }
  }
}
