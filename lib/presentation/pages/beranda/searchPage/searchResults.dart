import 'package:app/data/source/local/model/menuItems.dart';
import 'package:app/data/source/remote/model/berita/newsList.dart';
import 'package:app/data/source/remote/model/faq/faqList.dart';
import 'package:app/data/source/remote/model/modul.dart';
import 'package:app/data/source/remote/model/pengumuman/pengumumanList.dart';
import 'package:app/injection.dart' as di;
import 'package:app/presentation/component/accordionQuestion.dart';
import 'package:app/presentation/component/bannerSubJudul.dart';
import 'package:app/presentation/component/constant.dart';
import 'package:app/presentation/component/menuBeranda.dart';
import 'package:app/presentation/component/menuItemsList.dart';
import 'package:app/presentation/component/sub_title_with_arrow_lainnya.dart';
import 'package:app/presentation/pages/beranda/beranda/component/on_click_menu.dart';
import 'package:app/presentation/pages/beranda/berita/component/hubungi_kami.dart';
import 'package:app/presentation/pages/beranda/beritaDanPengumumanDetail/beritaDanPengumumanSubPage.dart';
import 'package:app/presentation/pages/beranda/searchPage/bloc/searchpagemoreresults_bloc.dart';
import 'package:app/presentation/pages/beranda/searchPage/component/newListStyleCardSearch.dart';
import 'package:app/presentation/pages/beranda/searchPage/component/searchMoreBeritaBody.dart';
import 'package:app/presentation/pages/beranda/searchPage/component/searchMorePengumumanBody.dart';
import 'package:app/presentation/pages/beranda/searchPage/searchResultsMorePage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Container resultFAQ(BuildContext context, FAQList listFAQ) {
  return Container(
    padding: EdgeInsets.symmetric(
        horizontal: screenWidth(context) * (1 / 30),
        vertical: screenHeight(context) * (1 / 35)),
    child: Column(
      children: [
        BannerSubJudul(
          subJudul: 'Hasil Pencarian',
          warna: blue3,
          edgeInsets: EdgeInsets.zero,
        ),
        Container(
          padding: EdgeInsets.only(top: screenHeight(context) * (1 / 40)),
          child: ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: listFAQ.data.faq.length,
            itemBuilder: (context, index) {
              return Accordion(
                title: listFAQ.data.faq[index].pertanyaan,
                content: listFAQ.data.faq[index].jawaban,
              );
            },
          ),
        ),
        // hubungi kami
        SizedBox(height: 32.h),
        hubungiKami(
          context,
          edgeInsets: EdgeInsets.zero,
        )
      ],
    ),
  );
}

Widget resultBerita(
  BuildContext context,
  TextEditingController textEditingController,
  NewsList newsList,
  bool isFromBeritaPage,
) {
  return BlocProvider(
    create: (context) => di.locator<SearchpagemoreresultsBloc>(),
    child: (isFromBeritaPage)
        ? SearchMoreBeritaBody(
            searchKeyword: textEditingController.text,
          )
        : resultBeritaWithArrow(context, textEditingController, newsList),
  );
}

Widget resultBeritaWithArrow(BuildContext context,
    TextEditingController textEditingController, NewsList newsList) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 16.w),
    child: Column(
      children: [
        SubTitleWithArrowLainnya(
          subJudul: 'Berita',
          function: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BlocProvider(
                    create: (context) =>
                        di.locator<SearchpagemoreresultsBloc>(),
                    child: SearchResultMorePage(
                      type: 'berita',
                      textEditingController: textEditingController,
                    ),
                  ),
                ));
          },
        ),
        SizedBox(
          height: 20.h,
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: ClampingScrollPhysics(),
          itemCount: newsList.data.length == 1 ? newsList.data.length : 2,
          itemBuilder: (context, i) {
            return NewListStyleCardSearch(
              function: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BeritaDanPengumumanSubPage(
                          category: '', id: newsList.data[i].newsId),
                    ));
              },
              kategori: '',
              image: newsList.data[i].thumbnailImage == 'null'
                  ? 'assets/default-con/berita.png'
                  : newsList.data[i].thumbnailImage,
              judul: newsList.data[i].title,
              tanggal: newsList.data[i].publisherDate,
            );
          },
        )
      ],
    ),
  );
}

Widget resultPengumuman(
  BuildContext context,
  TextEditingController textEditingController,
  PengumumanList pengumumanList,
  bool isFromPengumumanPage,
) {
  return BlocProvider(
    create: (context) => di.locator<SearchpagemoreresultsBloc>(),
    child: (isFromPengumumanPage)
        ? SearchMorePengumumanBody(
            searchKeyword: textEditingController.text,
          )
        : resultPengumumanWithArrow(
            context, textEditingController, pengumumanList),
  );
}

Widget resultPengumumanWithArrow(
    BuildContext context,
    TextEditingController textEditingController,
    PengumumanList pengumumanList) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 16.w),
    child: Column(
      children: [
        SubTitleWithArrowLainnya(
          subJudul: 'Pengumuman',
          function: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BlocProvider(
                    create: (context) =>
                        di.locator<SearchpagemoreresultsBloc>(),
                    child: SearchResultMorePage(
                      type: 'pengumuman',
                      textEditingController: textEditingController,
                    ),
                  ),
                ));
          },
        ),
        SizedBox(
          height: 20.h,
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: ClampingScrollPhysics(),
          itemCount:
              pengumumanList.data.length == 1 ? pengumumanList.data.length : 2,
          itemBuilder: (context, i) {
            return NewListStyleCardSearch(
                function: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BeritaDanPengumumanSubPage(
                          category: pengumumanList.data[i].categories.length > 1
                              ? pengumumanList
                                  .data[i].categories.last.categoryName
                              : pengumumanList
                                  .data[i].categories[0].categoryName,
                          id: pengumumanList.data[i].id,
                        ),
                      ));
                },
                kategori: pengumumanList.data[i].categories[0].categoryName ==
                        'Uncategorized'
                    ? 'Umum'
                    : pengumumanList.data[i].categories[0].categoryName,
                image: pengumumanList.data[i].thumbnailImage == ''
                    ? 'assets/default-con/pengumuman.png'
                    : pengumumanList.data[i].thumbnailImage,
                judul: pengumumanList.data[i].title,
                tanggal: pengumumanList.data[i].publisherDate);
          },
        )
      ],
    ),
  );
}

Container resultLayanan(BuildContext context, AutoGenerate listModul) {
  return Container(
    width: double.infinity,
    decoration: BoxDecoration(color: whiteBgPage),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            height: screenHeight(context) * (1 / 20),
            margin: EdgeInsets.symmetric(
              horizontal: 13.sp,
              vertical: screenHeight(context) * (1 / 100),
            ),
            child: Text(
              'Layanan Dikti',
              style: TextStyle(
                  color: blue3, fontSize: 20.sp, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 4.w,
          ),
          Container(
            width: screenWidth(context) * (1 / 1.5),
            height: screenHeight(context) * (1 / 7),
            margin: EdgeInsets.symmetric(
                horizontal: screenWidth(context) * (1 / 30)),
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: listModul.data.modul.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  MenuItems? menuItem;
                  for (MenuItems item in listAllMenus) {
                    if (item.menuNameFromAPI ==
                        listModul.data.modul[index].moduleName) {
                      menuItem = item;
                      break;
                    }
                  }
                  if (menuItem != null) {
                    print("LAYANAN DIKTI ${menuItem.menuImage}");
                    print("menuItem menuname ${menuItem.menuName}");

                    return MenuBeranda(
                      namaMenu: menuItem.menuName,
                      logoMenu: menuItem.menuImage,
                      scale: menuItem.imageScale,
                      function: () {
                        return onClickMenu(context, menuItem!, null);
                      },
                    );
                  } else {
                    return SizedBox();
                  }
                }),
          ),
          Container(
            margin: EdgeInsets.only(top: screenHeight(context) * (1 / 30)),
            width: double.infinity,
            height: screenHeight(context) * (1 / 100),
          ),
        ],
      ),
    ),
  );
}

// dynamic clickLayanan(BuildContext context, String? keyMap) {
//   switch (keyMap) {
//     case 'Kampus Merdeka':
//       return () {
//         Navigator.push(context, MaterialPageRoute(
//           builder: (context) {
//             return KampusMerdekaPage();
//           },
//         ));
//       };
//     case 'PDDikti':
//       return () {
//         Navigator.push(context, MaterialPageRoute(
//           builder: (context) {
//             return PDDiktiMainPage();
//           },
//         ));
//       };
//     case 'Kedaireka':
//       return () {
//         Navigator.push(context, MaterialPageRoute(
//           builder: (context) {
//             return ShowWebsite(
//               title: "Kedaireka",
//               link: 'https://kedaireka.id/',
//             );
//           },
//         ));
//       };
//     case 'Penyetaraan Ijazah LN':
//       return () {
//         Navigator.push(context, MaterialPageRoute(
//           builder: (context) {
//             return IjazahLNMainPage();
//           },
//         ));
//       };
//     case 'SIVIL':
//       return () {
//         Navigator.push(context, MaterialPageRoute(
//           builder: (context) {
//             return SivilMainPage();
//           },
//         ));
//       };
//     case 'Selancar PAK':
//       return () {
//         Navigator.push(context, MaterialPageRoute(
//           builder: (context) {
//             return ShowWebsite(
//               title: "Selancar PAK",
//               link: 'https://pak.kemdikbud.go.id/portalv2/',
//             );
//           },
//         ));
//       };
//     case 'Silemkerma':
//       return () {
//         Navigator.push(context, MaterialPageRoute(
//           builder: (context) {
//             return ShowWebsite(
//               title: "Silemkerma",
//               link: 'http://silemkerma.kemdikbud.go.id/',
//             );
//           },
//         ));
//       };
//     default:
//       return () {
//         Navigator.push(context, MaterialPageRoute(
//           builder: (context) {
//             return KampusMerdekaPage();
//           },
//         ));
//       };
//   }
// }
