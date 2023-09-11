import 'package:app/data/source/local/model/menuItems.dart';
import 'package:app/data/source/remote/model/faq/faqList.dart';
import 'package:app/injection.dart' as di;
import 'package:app/presentation/component/accordionQuestion.dart';
import 'package:app/presentation/component/bannerSubJudul.dart';
import 'package:app/presentation/component/constant.dart';
import 'package:app/presentation/component/inkEffect.dart';
import 'package:app/presentation/component/menuItemsList.dart';
import 'package:app/presentation/component/search/searchBar.dart';
import 'package:app/presentation/pages/beranda/berita/component/hubungi_kami.dart';
import 'package:app/presentation/pages/beranda/searchPage/searchPage.dart';
import 'package:app/presentation/pages/faq/bloc/faq_module/faqmodule_bloc.dart';
import 'package:app/presentation/pages/faq/faq_page_per_module.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class FAQPage extends StatefulWidget {
  final FAQList listFAQ;

  const FAQPage({Key? key, required this.listFAQ}) : super(key: key);

  @override
  _FAQPageState createState() => _FAQPageState();
}

class _FAQPageState extends State<FAQPage> {
  final TextEditingController textEditingController = TextEditingController();
  PageController pageController =
      PageController(initialPage: 0, viewportFraction: 1);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: whiteBgPage,
      width: double.infinity,
      child: ListView(
        padding: EdgeInsets.zero,
        physics: ClampingScrollPhysics(),
        children: [
          _topSection(),
          SizedBox(
            height: 32.h,
          ),
          Column(
            children: [
              BannerSubJudul(
                subJudul: 'Pertanyaan Umum FAQ',
                warna: blue3,
                edgeInsets: EdgeInsets.symmetric(horizontal: 16.w),
              ),
              SizedBox(height: 20.h),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(
                  horizontal: 16.w,
                ),
                margin: EdgeInsets.symmetric(vertical: 4.2.h),
                child: SingleChildScrollView(
                  child: ListView.separated(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: widget.listFAQ.data.faq.length,
                    itemBuilder: (context, index) {
                      return Accordion(
                        title: widget.listFAQ.data.faq[index].pertanyaan,
                        content: widget.listFAQ.data.faq[index].jawaban,
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return SizedBox(
                        height: 8.h,
                      );
                    },
                  ),
                ),
              ),
              SizedBox(height: 48.h),
              // layanan
              BannerSubJudul(
                subJudul: 'Pilihan Layanan FAQ',
                warna: blue3,
                edgeInsets: EdgeInsets.symmetric(horizontal: 16.w),
              ),
              SizedBox(height: 40.h),
              _daftarMenu(),
              SizedBox(height: 64.h),
              // hubungi kami
              hubungiKami(
                context,
                edgeInsets: EdgeInsets.symmetric(horizontal: 16.w),
              ),
              SizedBox(height: 64.h),
            ],
          )
        ],
      ),
    );
  }

  Widget _topSection() {
    return Container(
      color: whiteBgPage,
      //249 from blue bg + 26 = 275 from half size search bar
      height: 275.h,
      child: Stack(
        children: [
          //bg blue
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              width: double.infinity,
              height: 249.h,
              decoration: BoxDecoration(gradient: appBarGradient),
            ),
          ),
          Positioned(
            bottom: 43.h,
            right: -15.w,
            child: faqVector(),
          ),
          Positioned(
            bottom: 110.h,
            left: 16.w,
            child: faqTitle(),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: searchBar(context),
          ),
        ],
      ),
    );
  }

  Widget faqVector() {
    return Image.asset(
      'assets/faq/faq_header.png',
      width: 210.w,
      height: 140.w,
    );
  }

  Widget faqTitle() {
    return Container(
      width: 186.w,
      child: Text(
        'Cari kebutuhan\ninformasimu pada\nfitur FAQ',
        style: TextStyle(
          fontSize: 18.sp,
          fontWeight: FontWeight.bold,
          color: white,
        ),
      ),
    );
  }

  GestureDetector searchBar(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SearchPage(
                isFAQ: true,
                hintText: 'Cari FAQ',
                text: 'Pertanyaan',
              ),
            ));
      },
      child: Container(
        color: Colors.transparent,
        child: IgnorePointer(
          child: SearchBar(
            margin: EdgeInsets.symmetric(vertical: 4.h, horizontal: 16.w),
            openKeyboard: false,
            hintText: 'Cari pertanyaan',
            searchType: TypeSearchBar.regular,
          ),
        ),
      ),
    );
  }

  Widget _daftarMenu() {
    return AlignedGridView.count(
      crossAxisCount: 4,
      mainAxisSpacing: 20,
      crossAxisSpacing: 0.8,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      padding: EdgeInsets.symmetric(
        horizontal: 16.w,
      ),
      itemCount: menuItemsListFaq.length,
      itemBuilder: (context, index) {
        final MenuItems menuItems = menuItemsListFaq[index];
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: MediaQuery.of(context).size.width > 600 ? 70.r : 52.r,
              width: MediaQuery.of(context).size.width > 600 ? 70.r : 52.r,
              decoration: BoxDecoration(boxShadow: shadow3),
              child: InkEffect(
                boxDecoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4.r), color: white),
                onTap: () => onClickMenu(context, index),
                child: Image.asset(
                  menuItems.menuImage,
                  scale: MediaQuery.of(context).size.width > 600
                      ? 1.7
                      : menuItems.imageScale,
                ),
              ),
            ),
            SizedBox(height: 10.w),
            Text(
              menuItems.menuName,
              style: TextStyle(
                color: neutral40,
                fontSize: 11.sp,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        );
      },
    );
  }

  void onClickMenu(BuildContext context, int menuIndex) {
    if (menuIndex == 0) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return BlocProvider(
              create: (context) =>
                  di.locator<FaqmoduleBloc>()..add(FetchfaqModuleEvent('mbkm')),
              child: FAQModul(),
            );
          },
        ),
      );
    } else if (menuIndex == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return BlocProvider(
              create: (context) => di.locator<FaqmoduleBloc>()
                ..add(FetchfaqModuleEvent('ijazah-ln')),
              child: FAQModul(),
            );
          },
        ),
      );
    } else if (menuIndex == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return BlocProvider(
              create: (context) => di.locator<FaqmoduleBloc>()
                ..add(FetchfaqModuleEvent('pak-dosen')),
              child: FAQModul(),
            );
          },
        ),
      );
    } else if (menuIndex == 3) {
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
    } else if (menuIndex == 4) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return BlocProvider(
              create: (context) => di.locator<FaqmoduleBloc>()
                ..add(FetchfaqModuleEvent('silemkerma')),
              child: FAQModul(),
            );
          },
        ),
      );
    } else if (menuIndex == 5) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return BlocProvider(
              create: (context) => di.locator<FaqmoduleBloc>()
                ..add(FetchfaqModuleEvent('kedaireka')),
              child: FAQModul(),
            );
          },
        ),
      );
    } else if (menuIndex == 6) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return BlocProvider(
              create: (context) => di.locator<FaqmoduleBloc>()
                ..add(FetchfaqModuleEvent('pddikti')),
              child: FAQModul(),
            );
          },
        ),
      );
    } else if (menuIndex == 7) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return BlocProvider(
              create: (context) => di.locator<FaqmoduleBloc>()
                ..add(FetchfaqModuleEvent('tracer')),
              child: FAQModul(),
            );
          },
        ),
      );
    } else if (menuIndex == 8) {
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
    }
  }
}
