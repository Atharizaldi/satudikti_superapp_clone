import 'package:app/data/source/remote/model/berita/newsList.dart';
import 'package:app/presentation/component/constant.dart';
import 'package:app/presentation/pages/beranda/berita/component/bannerBerita.dart';
import 'package:app/presentation/pages/beranda/berita/component/beritaPopular.dart';
import 'package:app/presentation/pages/beranda/berita/component/beritaTerbaru.dart';
import 'package:app/presentation/pages/beranda/searchPage/searchPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BeritaPage extends StatelessWidget {
  final NewsList recentNewsList, popularNewsList;

  const BeritaPage(
      {Key? key, required this.recentNewsList, required this.popularNewsList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            'Berita',
            style: TextStyle(fontWeight: FontWeight.w600, letterSpacing: 1),
          ),
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: appBarGradient,
            ),
          ),
          backgroundColor: blueLinear1,
          centerTitle: true,
          actions: <Widget>[
            IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SearchPage(
                          isBerita: true,
                          hintText: 'Cari berita',
                          text: 'Berita',
                        ),
                      ));
                },
                icon: Image.asset(
                  'assets/icons/search_inactive.png',
                  scale: 2,
                ))
          ]),
      body: Container(
          width: double.infinity,
          height: double.infinity,
          child: ListView(
            physics: BouncingScrollPhysics(),
            children: [
              Padding(
                padding:
                    const EdgeInsets.only(top: 32.0, left: 16.0, right: 16.0),
                child: Text(
                  "Berita Terpopuler",
                  style: TextStyle(
                      fontSize: 20, color: blue3, fontWeight: FontWeight.w700),
                ),
              ),
              //  paling atas
              BannerBerita(
                recentNewsList: recentNewsList,
              ),
              SizedBox(
                height: 48.h,
              ),
              beritaTerbaru(context, recentNewsList),
              SizedBox(
                height: 48.h,
              ),
              beritaPopular(context, popularNewsList),
            ],
          )),
    );
  }
}
