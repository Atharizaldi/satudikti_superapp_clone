import 'package:app/presentation/component/constant.dart';
import 'package:app/presentation/pages/beranda/garuda/components/newListStyleCardGaruda.dart';
import 'package:app/presentation/pages/beranda/garuda/statistikgaruda.dart';
import 'package:app/presentation/pages/showWebsite.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AuthorProfileGaruda extends StatelessWidget {
  const AuthorProfileGaruda({Key? key}) : super(key: key);
  static final List<DiagramChartGaruda> populationData = [
    DiagramChartGaruda('2010', 40, Color(0xff0263ff)),
    DiagramChartGaruda('2011', 88, Color(0xffff7723)),
    DiagramChartGaruda('2012', 60, Color(0xff8e30ff)),
    DiagramChartGaruda('2013', 59, Color(0xffb90de5)),
    DiagramChartGaruda('2014', 6, Color(0xffbd27ce)),
    DiagramChartGaruda('2015', 0, Colors.green)
  ];

  @override
  Widget build(BuildContext context) {
    List<charts.Series<DiagramChartGaruda, String>> series = [
      charts.Series(
        data: populationData,
        id: "Diagram Garuda",
        domainFn: (DiagramChartGaruda pops, _) => pops.year,
        measureFn: (DiagramChartGaruda pops, _) => pops.population,
        colorFn: (DiagramChartGaruda pops, _) =>
            charts.ColorUtil.fromDartColor(pops.barColor),
        labelAccessorFn: (DiagramChartGaruda pops, _) =>
            '${pops.population.toString()}',
      )
    ];
    return Scaffold(
      backgroundColor: whiteBgPage,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Author Profile',
          style: TextStyle(fontWeight: FontWeight.w600, letterSpacing: 1),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: sliverBgGradient,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 16.w, right: 21.w, top: 30.w),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  color: white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 0.25,
                      blurRadius: 0.6,
                      offset: Offset(0, 0.5), // changes position of shadow
                    ),
                  ],
                ),
                height: 172.h,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                        child: Padding(
                      padding:
                          EdgeInsets.only(left: 20.w, right: 21.w, top: 20.w),
                      child: Text(
                        "Prof. Leonardi Satrio Bimantoro lalala, M.Pd., Ph.D",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: blue4,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold),
                      ),
                    )),
                    SizedBox(
                      height: 6.w,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: 20.w,
                        right: 21.w,
                      ),
                      child: Text(
                        "Universitas Airlangga",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: red,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    SizedBox(
                      height: 6.w,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 20.w, right: 21.w),
                      child: Text(
                        "Author-ID : 6714669",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: teksAbuCerah4,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    SizedBox(
                      height: 6.w,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 20.w, right: 21.w),
                      child: Text(
                        "Published : 90 Dokumen",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: teksAbuCerah4,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    SizedBox(
                      height: 6.w,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 20.w),
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: green3),
                                borderRadius: BorderRadius.circular(5.r)),
                            child: Padding(
                              padding: EdgeInsets.only(
                                  left: 4.w, right: 4.w, top: 4.w, bottom: 4.w),
                              child: Text(
                                "Membrane Technology",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 10.sp,
                                    fontWeight: FontWeight.w400,
                                    color: green3),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 5.w,
                        ),
                        Flexible(
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: green3),
                                borderRadius: BorderRadius.circular(5.r)),
                            child: Padding(
                              padding: EdgeInsets.only(
                                  left: 4.w, right: 4.w, top: 4.w, bottom: 4.w),
                              child: Text(
                                "Public Health",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 10.sp,
                                    fontWeight: FontWeight.w400,
                                    color: green3),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 5.w,
                        ),
                        Flexible(
                          child: Padding(
                            padding: EdgeInsets.only(right: 21.w),
                            child: Container(
                              decoration: BoxDecoration(
                                  border: Border.all(color: green3),
                                  borderRadius: BorderRadius.circular(5.r)),
                              child: Padding(
                                padding: EdgeInsets.only(
                                    left: 4.w,
                                    right: 4.w,
                                    top: 4.w,
                                    bottom: 4.w),
                                child: Text(
                                  "Public Health",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: 10.sp,
                                      fontWeight: FontWeight.w400,
                                      color: green3),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 16.w, right: 20.w, top: 24.h),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  color: white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 0.25,
                      blurRadius: 0.6,
                      offset: Offset(0, 0.5), // changes position of shadow
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 15.h, bottom: 10.h),
                      child: Text(
                        "Co-Authors",
                        style: TextStyle(
                            color: neutral30,
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 15.w, right: 15.w),
                      child: Container(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            firstCoAuthor("Membrane Technology"),
                            SizedBox(
                              width: 12.w,
                            ),
                            secondCoAuthor("Public Health Pub"),
                            SizedBox(
                              width: 12.w,
                            ),
                            secondCoAuthor("Public Health"),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 15.w, right: 15.w),
                      child: Container(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            firstCoAuthor("Public Health"),
                            SizedBox(
                              width: 12.w,
                            ),
                            secondCoAuthor("Public Health Pub"),
                            SizedBox(
                              width: 12.w,
                            ),
                            secondCoAuthor("Membrane Techn"),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 16.h),
              child: Container(
                height: 349.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  color: white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 0.25,
                      blurRadius: 0.6,
                      offset: Offset(0, 0.5), // changes position of shadow
                    ),
                  ],
                ),
                child: Padding(
                  padding: EdgeInsets.only(left: 16.w, right: 16.w),
                  child: Container(
                    height: 347.h,
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Publikasi per Tahun",
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: blue4,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Container(
                          height: 268.h,
                          child: charts.BarChart(
                            series,
                            animate: true,
                            barRendererDecorator:
                                new charts.BarLabelDecorator<String>(
                                    labelPosition:
                                        charts.BarLabelPosition.outside),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 34.h,
            ),
            Padding(
              padding: EdgeInsets.only(left: 17.5.w, right: 16.5.w),
              child: Text(
                "Kumpulan Artikel yang Diterbitkan",
                style: TextStyle(
                  color: blue2,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: 30.h,
            ),
            // _searchBar(context),
            SizedBox(
              height: 30.h,
            ),
            Padding(
              padding: EdgeInsets.only(left: 17.w),
              child: RichText(
                text: TextSpan(children: <TextSpan>[
                  TextSpan(
                      text: 'Terdapat ',
                      style: TextStyle(
                          color: neutral50,
                          fontWeight: FontWeight.w400,
                          fontSize: 14.sp)),
                  TextSpan(
                      text: '90 ',
                      style: TextStyle(
                          color: neutral100,
                          fontWeight: FontWeight.bold,
                          fontSize: 14.sp)),
                  TextSpan(
                      text: 'dokumen yang tersedia',
                      style: TextStyle(
                          color: neutral50,
                          fontWeight: FontWeight.w400,
                          fontSize: 14.sp))
                ]),
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            NewListStyleGarudaPaperSearch(
              heightSpace: 0,
              function: () {},
              title:
                  "Ini judul paper yang panjang sekali biasanya ditulis di garuda biasanya ditulis di garuda ",
              subTitle:
                  "Rachmawati, Indira Dwi; Rusimamto, Puput Wanarti; ., Endryansyah",
              judulJurnal:
                  'JURNAL TEKNIK ELEKTRO Vol 9 No 3 (2020): SEPTEMBER 2020',
              univ: 'Universitas Islam Negeri Syarif Hidayatullah Jakarta',
            ),
            SizedBox(
              height: 20.h,
            ),
            NewListStyleGarudaPaperSearch(
              heightSpace: 0,
              function: () {},
              title:
                  "Ini judul paper yang panjang sekali biasanya ditulis di garuda biasanya ditulis di garuda ",
              subTitle:
                  "Rachmawati, Indira Dwi; Rusimamto, Puput Wanarti; ., Endryansyah",
              judulJurnal:
                  'JURNAL TEKNIK ELEKTRO Vol 9 No 3 (2020): SEPTEMBER 2020',
              univ: 'Universitas Islam Negeri Syarif Hidayatullah Jakarta',
            ),
            SizedBox(
              height: 20.h,
            ),
            NewListStyleGarudaPaperSearch(
              heightSpace: 0,
              function: () {},
              title:
                  "Ini judul paper yang panjang sekali biasanya ditulis di garuda biasanya ditulis di garuda ",
              subTitle:
                  "Rachmawati, Indira Dwi; Rusimamto, Puput Wanarti; ., Endryansyah",
              judulJurnal:
                  'JURNAL TEKNIK ELEKTRO Vol 9 No 3 (2020): SEPTEMBER 2020',
              univ: 'Universitas Islam Negeri Syarif Hidayatullah Jakarta',
            ),
            SizedBox(
              height: 20.h,
            ),
            NewListStyleGarudaPaperSearch(
              heightSpace: 0,
              function: () {},
              title:
                  "Ini judul paper yang panjang sekali biasanya ditulis di garuda biasanya ditulis di garuda ",
              subTitle:
                  "Rachmawati, Indira Dwi; Rusimamto, Puput Wanarti; ., Endryansyah",
              judulJurnal:
                  'JURNAL TEKNIK ELEKTRO Vol 9 No 3 (2020): SEPTEMBER 2020',
              univ: 'Universitas Islam Negeri Syarif Hidayatullah Jakarta',
            ),
            SizedBox(
              height: 24.w,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: _cardButuhInfoDetail(context),
            ),
            SizedBox(
              height: 100.w,
            ),
          ],
        ),
      ),
    );
  }

  Widget _cardButuhInfoDetail(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ShowWebsite(
            title: 'Garuda',
            link: 'https://garuda.kemdikbud.go.id/',
          ),
        ),
      ),
      child: Container(
        height: 96.sp,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          gradient: appBarGradient,
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 17.0, left: 16, bottom: 14),
              child: Image(
                height: 64,
                width: 64,
                image: AssetImage("assets/km/icons/statistik_icon.png"),
              ),
            ),
            SizedBox(
              width: 12.sp,
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.only(
                  right: 20.0,
                ),
                child: Container(
                  child: Text(
                    "Lihat mengenai statistik Garuda",
                    style: TextStyle(
                        color: white,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w700),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget firstCoAuthor(String title) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: red),
          borderRadius: BorderRadius.circular(5.r)),
      child: Padding(
        padding: EdgeInsets.only(left: 4.w, right: 4.w, top: 4.w, bottom: 4.w),
        child: Text(
          title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
              fontSize: 10.sp, fontWeight: FontWeight.w400, color: red),
        ),
      ),
    );
  }

  Widget secondCoAuthor(String title) {
    return Flexible(
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: red),
            borderRadius: BorderRadius.circular(5.r)),
        child: Padding(
          padding:
              EdgeInsets.only(left: 4.w, right: 4.w, top: 4.w, bottom: 4.w),
          child: Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                fontSize: 10.sp, fontWeight: FontWeight.w400, color: red),
          ),
        ),
      ),
    );
  }

  // Widget _searchBar(BuildContext context) {
  //   return GestureDetector(
  //     onTap: () {
  //       Navigator.push(context,
  //           MaterialPageRoute(builder: (builder) => DetailGarudaSearchBar()));
  //     },
  //     child: Container(
  //       color: Colors.transparent,
  //       child: IgnorePointer(
  //         child: SearchBarGaruda(
  //           iconColor: blue3,
  //           openKeyboard: false,
  //           iconAction: false,
  //           hintText: 'Cari Artikel',
  //         ),
  //       ),
  //     ),
  //   );
  // }
}
