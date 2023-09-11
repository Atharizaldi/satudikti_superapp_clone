import 'package:app/presentation/component/accordionQuestion.dart';
import 'package:app/presentation/component/bannerSubJudul.dart';
import 'package:app/presentation/component/constant.dart';
import 'package:app/presentation/component/customAppBar.dart';
import 'package:app/presentation/component/noInternet.dart';
import 'package:app/presentation/component/server_problem.dart';
import 'package:app/presentation/pages/beranda/berita/component/hubungi_kami.dart';
import 'package:app/presentation/pages/faq/bloc/faq_module/faqmodule_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FAQModul extends StatelessWidget {
  const FAQModul({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteBgPage,
      appBar: CustomAppBar(title: 'FAQ'),
      body: BlocBuilder<FaqmoduleBloc, FaqmoduleState>(
        builder: (context, state) {
          if (state is FaqModuleInitial) {
            return Center(child: CircularProgressIndicator());
          } else if (state is FaqModuleLoadedState) {
            return Container(
              width: double.infinity,
              height: double.infinity,
              child: ListView(
                children: [
                  SizedBox(
                    height: 30.h,
                  ),
                  BannerSubJudul(
                    subJudul: _subJudul(state.moduleCode),
                    warna: blue3,
                    edgeInsets: EdgeInsets.only(left: 16.w),
                  ),
                  SizedBox(height: 20.h),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: 16.h),
                    child: ListView.separated(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: state.listFAQLayanan.data.faq.length,
                      itemBuilder: (context, index) {
                        return Accordion(
                          title:
                              state.listFAQLayanan.data.faq[index].pertanyaan,
                          content: state.listFAQLayanan.data.faq[index].jawaban,
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return SizedBox(height: 8.h);
                      },
                    ),
                  ),
                  // hubungi kami
                  SizedBox(height: 20.h),
                  hubungiKami(
                    context,
                    edgeInsets: EdgeInsets.symmetric(horizontal: 16.w),
                  ),
                  SizedBox(height: 20.h),
                ],
              ),
            );
          } else if (state is FaqModuleNoInternetState) {
            return NoInternet(
              onPressed: () {
                BlocProvider.of<FaqmoduleBloc>(context)
                  ..add(FetchfaqModuleEvent(state.moduleCode));
              },
              buttonHide: false,
            );
          } else if (state is FaqModuleErrorState) {
            return ServerProblem(
              onPressed: () {
                BlocProvider.of<FaqmoduleBloc>(context)
                  ..add(FetchfaqModuleEvent(state.moduleCode));
              },
              buttonHide: false,
            );
          } else {
            return SizedBox();
          }
        },
      ),
    );
  }

  String _subJudul(String moduleCode) {
    switch (moduleCode) {
      case 'mbkm':
        return 'Kampus Merdeka';

      case 'ijazah-ln':
        return 'Ijazah LN';

      case 'sivil':
        return 'Sivil';

      case 'pak-dosen':
        return 'Selancar Pak';

      case 'silemkerma':
        return 'Siaga';

      case 'kedaireka':
        return 'Kedaireka';

      case 'pddikti':
        return 'PDDikti';

      case 'simlitabmas':
        return 'Simlitabmas';

      case 'garuda':
        return 'Garuda';

      case 'sinta':
        return 'Sinta';

      case 'beasiswa':
        return 'Beasiswa';

      case 'kompetensi-dosen':
        return 'Kompetensi Dosen';

      case 'tracer':
        return 'Tracer Study';

      case 'sister':
        return 'SISTER';

      default:
        return 'Umum';
    }
  }
}
