import 'package:app/data/source/local/sharedpreferences.dart';
import 'package:app/injection.dart' as di;
import 'package:app/presentation/component/constant.dart';
import 'package:app/presentation/component/customSliverBar.dart';
import 'package:app/presentation/component/search/searchBar.dart';
import 'package:app/presentation/pages/beranda/gmagz/bloc/detailmajalah/majalah_detail_gmagz_bloc.dart';
import 'package:app/presentation/pages/beranda/gmagz/bloc/majalah/majalah_gmagz_bloc.dart';
import 'package:app/presentation/pages/beranda/gmagz/component/header_gmagz.dart';
import 'package:app/presentation/pages/beranda/gmagz/component/lanjut_baca_gmagz.dart';
import 'package:app/presentation/pages/beranda/gmagz/majalah_edisi_lain/majalah_edisi_section.dart';
import 'package:app/presentation/pages/beranda/gmagz/majalah_populer/majalah_populer_section.dart';
import 'package:app/presentation/pages/beranda/gmagz/search/search_GMagz_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GMagzPage extends StatefulWidget {
  const GMagzPage({Key? key}) : super(key: key);

  @override
  State<GMagzPage> createState() => _GMagzPageState();
}

class _GMagzPageState extends State<GMagzPage> {
  late MajalahDetailGMagzBloc _majalahDetailGMagzBloc;

  late String majalahId;

  // Future<String?> getMajalah() async {
  //   SharedPreferences pref = await SharedPreferences.getInstance();
  //   return majalah = pref.getString('majalah');
  // }
  late int allPage;
  late int nowPage;
  late String imageUrl;
  late String judul;

  @override
  void initState() {
    super.initState();
    setState(() {
      String majalah = Prefs.getMajalah() ?? 'null';
      majalahId = majalah;
      if (majalahId != 'null') {
        List<String> majalahint = Prefs.getMajalahInt() ?? ['null'];
        allPage = int.parse(majalahint[0]);
        nowPage = int.parse(majalahint[1]);
        judul = majalahint[2];
        imageUrl = majalahint[3];
        lanjut(majalahId, nowPage, allPage, judul, imageUrl);
        print("INI MAJALAH VALUEEEEEEEEE $majalahint");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    _majalahDetailGMagzBloc = BlocProvider.of<MajalahDetailGMagzBloc>(context);
    return Material(
      child: RefreshIndicator(
        onRefresh: () async {
          String majalah = Prefs.getMajalah() ?? 'null';
          majalahId = majalah;
          if (majalahId != 'null') {
            List<String> majalahint = Prefs.getMajalahInt() ?? ['null'];
            allPage = int.parse(majalahint[0]);
            nowPage = int.parse(majalahint[1]);
            judul = majalahint[2];
            imageUrl = majalahint[3];
          }

          setState(() {
            lanjut(majalahId, nowPage, allPage, judul,
                imageUrl); // Update lanjutSection
          });

          // BlocProvider.of<ListBeasiswaBloc>(context)
          //     .add(FetchListBeasiswaEvent());
        },
        child: Container(
          decoration: BoxDecoration(gradient: sliverBgGradient),
          child: Scaffold(
              backgroundColor: Colors.transparent,
              body: CustomSliverBar(
                appBarTitle: "G-Magz",
                expandedHeight: 250.h,
                header: FlexibleSpaceBar(
                  background: headerGmagz(context),
                ),
                child: _scrolledContent(),
              )),
        ),
      ),
    );
  }

  Widget _scrolledContent() {
    return Container(
      child: Column(
        children: [
          SizedBox(height: 20.h),
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (builder) => BlocProvider(
                            create: (context) => di.locator<MajalahGMagzBloc>()
                              ..add(GetMajalahGMagzEvent(
                                  judul: "", sort: "", displayby: "")),
                            child: SearchGMagz(),
                          )));
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              color: Colors.transparent,
              child: IgnorePointer(
                child: SearchBar(
                  openKeyboard: false,
                  hintText: 'Cari judul majalah...',
                  searchType: TypeSearchBar.regular,
                ),
              ),
            ),
          ),
          if (majalahId != 'null')
            Align(
              alignment: AlignmentDirectional.topStart,
              child: Padding(
                padding: EdgeInsets.only(
                    left: 16.w, right: 16.w, top: 24.h, bottom: 12.h),
                child: Text(
                  'Progres Membaca',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Plus Jakarta Sans',
                      color: Color.fromRGBO(37, 74, 113, 1)),
                ),
              ),
            ),
          if (majalahId != 'null')
            lanjut(majalahId, nowPage, allPage, judul, imageUrl),
          SizedBox(height: 40.h),
          BlocProvider(
            create: (context) => di.locator<MajalahGMagzBloc>()
              ..add(
                  GetMajalahGMagzEvent(judul: "", sort: "true", displayby: "")),
            child: MajalahPopulerSection(),
          ),
          SizedBox(height: 40.h),
          BlocProvider(
            create: (context) => di.locator<MajalahGMagzBloc>()
              ..add(GetMajalahGMagzEvent(
                  judul: "", sort: "false", displayby: "")),
            child: MajalahEdisiSection(),
          ),
        ],
      ),
    );
  }

  Widget lanjut(majalahId, nowPage, allPage, judul, imageUrl) {
    return BlocProvider(
      create: (context) => di.locator<MajalahDetailGMagzBloc>()
        ..add(GetMajalahDetailGMagzEvent(id: majalahId)),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: LanjutBacaGMagz(
          imageUrl: imageUrl,
          judul: judul,
          lanjutBaca: nowPage,
          allPage: allPage,
          nowPage: nowPage,
        ),
      ),
    );
  }
}

// Widget lanjut(majalahId, nowPage, allPage) {
//   return BlocProvider(
//     create: (context) => di.locator<MajalahDetailGMagzBloc>()
//       ..add(GetMajalahDetailGMagzEvent(id: majalahId)),
//     child: Padding(
//         padding: EdgeInsets.symmetric(horizontal: 16.w),
//         child: LanjutBacaGMagz(
//           lanjutBaca: nowPage,
//           allPage: allPage,
//           nowPage: nowPage,
//         )),
//   );
// }
