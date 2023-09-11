import 'package:app/presentation/component/constant.dart';
import 'package:app/presentation/component/login_card.dart';
import 'package:app/presentation/component/search/searchBar.dart';
import 'package:app/presentation/component/skeleton_loader/skeleton_loader_login.dart';
import 'package:app/presentation/pages/beranda/sinta/component/layanan.dart';
import 'package:app/presentation/pages/beranda/sinta/component/profil.dart';
import 'package:app/presentation/pages/beranda/sinta/search/bloc/sinta_search_bloc.dart';
import 'package:app/presentation/pages/beranda/sinta/search/sintaSearchPage.dart';
import 'package:app/presentation/pages/profil/bloc/profil_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:app/injection.dart' as di;

import '../../faq/bloc/faq_module/faqmodule_bloc.dart';
import '../../faq/faq_page_per_module.dart';

class ScrolledContent extends StatelessWidget {
  const ScrolledContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: whiteBgPage,
      child: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BlocBuilder<ProfilBloc, ProfilState>(
                builder: (context, state) {
                  if (state is ProfilLoadedState) {
                    return profil(
                      context,
                      state.userInformationDetail,
                      true,
                      state.userAvatar
                    );
                  } else if (state is ProfilNotLogInState) {
                    return LoginCard(isDosenOnlyModule: false);
                  } else {
                    return SkeletorLoaderLogin();
                  }
                },
              ),
              SizedBox(
                height: 25.h,
              ),
              _searchBar(context),
              SizedBox(
                height: 20.h,
              ),
              layanan(context),
              _bannerFAQ(context)
            ],
          ),
        ),
      ),
    );
  }

  GestureDetector _searchBar(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (builder) => BlocProvider(
                      create: (context) => di.locator<SintaSearchBloc>()
                        ..add(GetAuthorsAffiliationsJournalsEvent(keyword: "")),
                      child: SintaSearchPage(),
                    )));
      },
      child: Container(
        color: Colors.transparent,
        child: IgnorePointer(
          child: SearchBar(
            openKeyboard: false,
            hintText: 'Pencarian Sinta',
            searchType: TypeSearchBar.regular,
          ),
        ),
      ),
    );
  }

  Widget _bannerFAQ(BuildContext context){
    return GestureDetector(
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return BlocProvider(
                create: (context) => di.locator<FaqmoduleBloc>()
                  ..add(FetchfaqModuleEvent('sinta')),
                child: FAQModul(),
              );
            },
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.only(top: 30.h),
        width: 358.w,
        child: Card(
          color: blueLinear1,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  alignment: Alignment.center,
                  child: CircleAvatar(
                    backgroundImage: AssetImage(
                      'assets/faq/faq_icon.png'
                    ),
                  ),
                ),
                SizedBox(
                  width: 20.w
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Butuh Informasi lainnya?",
                      style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w700,
                        letterSpacing: -0.006.sp,
                        color: white
                      ),
                    ),
                    SizedBox(
                      height: 10.w,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Lihat FAQ",
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                            letterSpacing: -0.006.sp,
                            color: white
                          ),
                        ),
                        SizedBox(
                          width: 2,
                        ),
                        Icon(
                          Icons.navigate_next,
                          color: white,
                          size: 16,
                        )
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
