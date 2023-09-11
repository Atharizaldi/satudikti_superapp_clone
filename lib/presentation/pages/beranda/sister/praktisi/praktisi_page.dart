import 'package:app/common/dateFormat.dart';
import 'package:app/injection.dart' as di;
import 'package:app/presentation/component/SkeletonLoading.dart';
import 'package:app/presentation/component/constant.dart';
// import 'package:app/presentation/pages/beranda/sister/component/data_found_card.dart';
import 'package:app/presentation/component/customAppBar.dart';
import 'package:app/presentation/component/noInternet.dart';
import 'package:app/presentation/component/server_problem.dart';
import 'package:app/presentation/pages/beranda/sister/component/accordion_card.dart';
import 'package:app/presentation/pages/beranda/sister/component/empty_data.dart';
import 'package:app/presentation/pages/beranda/sister/component/tabbarviewsister.dart';
import 'package:app/presentation/pages/beranda/sister/praktisi/bloc/praktisi_bloc.dart';
import 'package:app/presentation/pages/faq/bloc/faq_module/faqmodule_bloc.dart';
import 'package:app/presentation/pages/faq/faq_page_per_module.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PraktisiPage extends StatefulWidget {
  const PraktisiPage({Key? key}) : super(key: key);

  @override
  State<PraktisiPage> createState() => _PraktisiPageState();
}

class _PraktisiPageState extends State<PraktisiPage> {
  late PraktisiSisterBloc _praktisiSisterBloc;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PraktisiSisterBloc, PraktisiSisterState>(
        listener: (context, state) {
      if (state is PraktisiSisterNoInternetState) {
        _praktisiSisterBloc = BlocProvider.of<PraktisiSisterBloc>(context);
        ScaffoldMessenger.of(context).showSnackBar(noInternet);
      }
    }, builder: (context, state) {
      if (state is PraktisiSisterNoInternetState) {
        return _praktisiWidgetState(context, state, state.nidn);
      } else if (state is PraktisiSisterErrorState) {
        return _praktisiWidgetState(context, state, state.nidn);
      } else if (state is PraktisiSisterLoadedState) {
        return _praktisiWidgetState(context, state, state.nidn);
      } else {
        return _praktisiWidgetState(context, state, '');
      }
    });

    // return _praktisiWidgetState(context);
  }

  Widget _praktisiWidgetState(
      BuildContext context, PraktisiSisterState state, String nidn) {
    return Container(
      child: Scaffold(
        backgroundColor: Color(0xffF9FAFE),
        appBar: CustomAppBar(
          title: "Praktisi",
          actions: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return BlocProvider(
                        create: (context) => di.locator<FaqmoduleBloc>()
                          ..add(FetchfaqModuleEvent('sister')),
                        child: FAQModul(),
                      );
                    },
                  ),
                );
              },
              child: Padding(
                padding: EdgeInsets.only(right: 16.w),
                child: ImageIcon(
                  AssetImage("assets/icons/to_faq_icon.png"),
                ),
              ),
            ),
          ],
        ),
        body: _bodyPraktisi(context, state),
      ),
    );
  }

  Widget _bodyPraktisi(BuildContext context, PraktisiSisterState state) {
    if (state is PraktisiSisterInitial) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SkeletonLoading(
              width: double.infinity,
              height: 50,
              cornerRadius: 10.r,
            ),
            SizedBox(
              height: 10.w,
            ),
            SkeletonLoading(
              width: double.infinity,
              height: 150,
              cornerRadius: 10.r,
            ),
            SizedBox(
              height: 10.w,
            ),
            SkeletonLoading(
              width: double.infinity,
              height: 80,
              cornerRadius: 10.r,
            ),
            SkeletonLoading(
              width: double.infinity,
              height: 50,
              cornerRadius: 10.r,
            ),
            SizedBox(
              height: 10.w,
            ),
            SkeletonLoading(
              width: double.infinity,
              height: 150,
              cornerRadius: 10.r,
            ),
            SizedBox(
              height: 10.w,
            ),
            SkeletonLoading(
              width: double.infinity,
              height: 80,
              cornerRadius: 10.r,
            ),
          ],
        ),
      );
    } else if (state is PraktisiSisterLoadedState) {
      if (state.nidn.isEmpty) {
        return EmptyDataPage();
      } else if (state.praktisiSister.length == 1) {
        return Padding(
          padding: EdgeInsets.only(top: 10.w),
          child: TabBarViewSister(
            data: [
              {
                'nama': 'Pekerjaan',
                'info': state.praktisiSister[0].pekerjaan == ''
                    ? ''
                    : state.praktisiSister[0].pekerjaan
              },
              {
                'nama': 'Instansi',
                'info': state.praktisiSister[0].instansi == ''
                    ? ''
                    : state.praktisiSister[0].instansi
              },
              {
                'nama': 'Jabatan',
                'info': state.praktisiSister[0].jabatan == ''
                    ? ''
                    : state.praktisiSister[0].jabatan
              },
              {
                'nama': 'Waktu Bekerja',
                'info': FormatDate().formatDate2(
                            state.praktisiSister[0].tglMulaiBekerja) ==
                        ''
                    ? ''
                    : FormatDate()
                        .formatDate2(state.praktisiSister[0].tglMulaiBekerja)
              },
              {'nama': 'LN/DN', 'info': '-'},
            ],
          ),
        );
      } else {
        return Container(
          margin: EdgeInsets.symmetric(vertical: 30.h),
          child: SingleChildScrollView(
            child: ListView.separated(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: state.praktisiSister.length,
              itemBuilder: (context, i) {
                return AccordionCard(
                  title: state.praktisiSister[i].pekerjaan,
                  content: [
                    {
                      'nama': 'Instansi',
                      'info': state.praktisiSister[i].instansi == ''
                          ? ''
                          : state.praktisiSister[i].instansi
                    },
                    {
                      'nama': 'Jabatan',
                      'info': state.praktisiSister[i].jabatan == ''
                          ? ''
                          : state.praktisiSister[i].jabatan
                    },
                    {
                      'nama': 'Waktu Bekerja',
                      'info': FormatDate().formatDate2(
                                  state.praktisiSister[i].tglMulaiBekerja) ==
                              ''
                          ? ''
                          : FormatDate().formatDate2(
                              state.praktisiSister[i].tglMulaiBekerja)
                    },
                    {'nama': 'LN/DN', 'info': '-'},
                  ],
                  date: state.praktisiSister[i].tglMulaiBekerja,
                );
              },
              separatorBuilder: (BuildContext context, int i) {
                return SizedBox(height: 12.h);
              },
            ),
          ),
        );
      }
    } else {
      if (state is PraktisiSisterNoInternetState) {
        return Center(
          child: NoInternet(
              onPressed: () {
                _praktisiSisterBloc
                    .add(GetPraktisiSisterEvent(nidn: state.nidn));
              },
              buttonHide: false),
        );
      } else if (state is PraktisiSisterNotFoundState) {
        return EmptyDataPage();
      } else if (state is PraktisiSisterErrorState) {
        return Center(
          child:
              ServerProblem(
                  onPressed: () {
                    _praktisiSisterBloc
                        .add(GetPraktisiSisterEvent(nidn: state.nidn));
                  },
                  buttonHide: false),
        );
      } else {
        return Center(
          child: ServerProblem(
              onPressed: () {
                _praktisiSisterBloc.add(
                    GetPraktisiSisterEvent(nidn: _praktisiSisterBloc.nidn));
              },
              buttonHide: false),
        );
      }
    }
  }
}
