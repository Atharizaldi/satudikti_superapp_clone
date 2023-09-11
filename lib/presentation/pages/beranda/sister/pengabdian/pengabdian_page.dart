import 'package:app/injection.dart' as di;
import 'package:app/presentation/component/SkeletonLoading.dart';
import 'package:app/presentation/component/constant.dart';
import 'package:app/presentation/component/customAppBar.dart';
import 'package:app/presentation/component/noInternet.dart';
import 'package:app/presentation/component/server_problem.dart';
import 'package:app/presentation/pages/beranda/sister/component/accordion_card.dart';
import 'package:app/presentation/pages/beranda/sister/component/empty_data.dart';
import 'package:app/presentation/pages/beranda/sister/component/tabbarviewsister.dart';
import 'package:app/presentation/pages/beranda/sister/pengabdian/bloc/pengabdian_sister_bloc.dart';
import 'package:app/presentation/pages/faq/bloc/faq_module/faqmodule_bloc.dart';
import 'package:app/presentation/pages/faq/faq_page_per_module.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PengabdianPage extends StatefulWidget {
  const PengabdianPage({Key? key}) : super(key: key);

  @override
  State<PengabdianPage> createState() => _PengabdianPageState();
}

class _PengabdianPageState extends State<PengabdianPage> {
  late PengabdianSisterBloc _pengabdianSisterBloc;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PengabdianSisterBloc, PengabdianSisterState>(
      builder: (context, state) {
        _pengabdianSisterBloc = BlocProvider.of<PengabdianSisterBloc>(context);
        if (state is PengabdianSisterNoInternetState) {
          return _pengabdianWidgetState(context, state, state.nidn);
        } else if (state is PengabdianSisterErrorState) {
          return _pengabdianWidgetState(context, state, state.nidn);
        } else if (state is PengabdianSisterLoadedState) {
          return _pengabdianWidgetState(context, state, state.nidn);
        } else {
          return _pengabdianWidgetState(context, state, '');
        }
      },
      listener: (context, state) {
        if (state is PengabdianSisterNoInternetState) {
          ScaffoldMessenger.of(context).showSnackBar(noInternet);
        }
      },
    );

    // return _pengabdianWidgetState(context);
  }

  Widget _pengabdianWidgetState(
      BuildContext context, PengabdianSisterState state, String nidn) {
    return Container(
      child: Scaffold(
        backgroundColor: Color(0xffF9FAFE),
        appBar: CustomAppBar(
          title: "Pengabdian",
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

        body: Container(child: _body(context, state)),

        // BlocConsumer<ListPenelitianBloc, ListPenelitianState>(
        //   listener: (context, state) {
        //     if (state is ListPenelitianNoInternetState) {
        //       ScaffoldMessenger.of(context).showSnackBar(noInternet);
        //     }
        //   },
        //   builder: (context, state) {
        //     return SizedBox(
        //       height: 516.w,
        //       child: TabBarView(
        //         physics: NeverScrollableScrollPhysics(),
        //         children: [
        //           _penelitian(state),
        //           _publikasi(state),
        //         ],
        //       ),
        //     );
        //   },
        // ),
      ),
    );
  }

  Widget _body(BuildContext context, PengabdianSisterState state) {
    if (state is PengabdianSisterinInitial) {
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
    } else if (state is PengabdianSisterLoadedState) {
      if (state.pengabdianData.isEmpty) {
        return EmptyDataPage();
      } else if (state.pengabdianData.length == 1) {
        return Padding(
          padding: EdgeInsets.only(top: 10.w),
          child: TabBarViewSister(data: [
            {
              'nama': 'Judul',
              'info': state.pengabdianData[0].judul != ''
                  ? state.pengabdianData[0].judul
                  : '-'
            },
            {
              'nama': 'Tahun Pelaksanaan',
              'info':
                  state.pengabdianData[0].tahunPelaksanaanKe.toString() != ''
                      ? state.pengabdianData[0].tahunPelaksanaanKe.toString()
                      : '-'
            },
            {
              'nama': 'Peran',
              'info': state.pengabdianData[0].peran != ''
                  ? state.pengabdianData[0].peran
                  : '-',
            },
            {
              'nama': 'Lokasi',
              'info': state.pengabdianData[0].lokasi != ''
                  ? state.pengabdianData[0].lokasi
                  : '-'
            }
          ]),
        );
      } else {
        return Container(
          margin: EdgeInsets.symmetric(vertical: 30.h),
          child: SingleChildScrollView(
            child: ListView.separated(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: state.pengabdianData.length,
              itemBuilder: (context, index) {
                return AccordionCard(
                    title: state.pengabdianData[index].judul,
                    content: [
                      {
                        'nama': "Tahun Pelaksanaan",
                        "info": state.pengabdianData[index].tahunPelaksanaanKe
                                    .toString() !=
                                ''
                            ? state.pengabdianData[index].tahunPelaksanaanKe
                                .toString()
                            : '-'
                      },
                      {
                        'nama': "Peran",
                        "info": state.pengabdianData[index].peran != ''
                            ? state.pengabdianData[index].peran
                            : '-',
                      },
                      {
                        'nama': 'Lokasi',
                        'info': state.pengabdianData[index].lokasi != ''
                            ? state.pengabdianData[index].lokasi
                            : '-'
                      }
                    ],
                    date: '');
              },
              separatorBuilder: (BuildContext context, int index) {
                return SizedBox(height: 12.h);
              },
            ),
          ),
        );
      }
    } else {
      if (state is PengabdianSisterNoInternetState) {
        return Center(
          child: NoInternet(
              onPressed: () {
                _pengabdianSisterBloc
                    .add(GetPengabdianSisterEvent(nidn: state.nidn));
              },
              buttonHide: false),
        );
      } else if (state is PengabdianSisterNotFoundState) {
        return EmptyDataPage();
      } else if (state is PengabdianSisterErrorState) {
        return Center(
          child: ServerProblem(
              onPressed: () {
                _pengabdianSisterBloc
                    .add(GetPengabdianSisterEvent(nidn: state.nidn));
              },
              buttonHide: false),
        );
      } else {
        return Center(
          child: ServerProblem(
              onPressed: () {
                _pengabdianSisterBloc.add(
                    GetPengabdianSisterEvent(nidn: _pengabdianSisterBloc.nidn));
              },
              buttonHide: false),
        );
      }
    }
  }
}
