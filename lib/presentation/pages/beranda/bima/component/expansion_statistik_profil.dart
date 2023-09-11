import 'package:app/presentation/pages/beranda/bima/component/card_statistik.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../component/constant.dart';
import 'card_without_detail.dart';

class ExpansionCardStatistic extends StatefulWidget {
  @override
  _ExpansionCardStatistic createState() => _ExpansionCardStatistic();
}

class _ExpansionCardStatistic extends State<ExpansionCardStatistic> {
  bool _expanded = false;
  List<int> _selectedIndexes = [];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: ExpansionPanelList(
          elevation: 0,
          expansionCallback: (panelIndex, isExpanded) {
            setState(() {
              _expanded = !isExpanded;
              if (_expanded) {
                _selectedIndexes.add(panelIndex);
              } else {
                _selectedIndexes.remove(panelIndex);
              }
            });
          },
          children: [
            ExpansionPanel(
              backgroundColor: Colors.transparent,
              headerBuilder: (context, isExpanded) {
                return Container(
                  child: ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(
                      'Statistik Profil',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                        color: blue3,
                      ),
                    ),
                    subtitle: Text(
                      'Rincian Profil Saya',
                      style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          color: neutral40),
                    ),
                  ),
                );
              },
              body: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        CardStatistikDosen(
                            imageUrl: "assets/bima/manage_search.png",
                            jumlahData: 1,
                            kategoriStatistik: 'Penelitian'),
                        SizedBox(
                          width: 14.w,
                        ),
                        CardStatistikDosen(
                            imageUrl: "assets/bima/volunteer_activism.png",
                            jumlahData: 1,
                            kategoriStatistik: 'Pengabdian'),
                      ],
                    ),
                    SizedBox(
                      height: 12.h,
                    ),
                    Row(
                      children: [
                        CardStatistikDosen(
                            imageUrl: "assets/bima/track_changes.png",
                            jumlahData: 96,
                            kategoriStatistik: 'Sinta Skor'),
                        SizedBox(
                          width: 14.w,
                        ),
                        CardStatistikDosenWithoutDetail(
                            imageUrl: "assets/bima/description.png",
                            jumlahData: 1,
                            kategoriStatistik: 'Artikel jurnal'),
                      ],
                    ),
                    SizedBox(
                      height: 12.h,
                    ),
                    Row(
                      children: [
                        CardStatistikDosenWithoutDetail(
                            imageUrl: "assets/bima/psychology.png",
                            jumlahData: 1,
                            kategoriStatistik: 'HKI'),
                        SizedBox(
                          width: 14.w,
                        ),
                        CardStatistikDosenWithoutDetail(
                            imageUrl: "assets/bima/menu_book.png",
                            jumlahData: 0,
                            kategoriStatistik: 'Buku'),
                      ],
                    ),
                    SizedBox(
                      height: 12.h,
                    ),

                    Row(
                      children: [
                        CardStatistikDosenWithoutDetail(
                            imageUrl: "assets/bima/photo_filter.png",
                            jumlahData: 1,
                            kategoriStatistik: 'Karya Monumental'),
                        SizedBox(
                          width: 14.w,
                        ),
                        CardStatistikDosenWithoutDetail(
                            imageUrl: "assets/bima/school.png",
                            jumlahData: 0,
                            kategoriStatistik: 'Naskah Akademik '),
                      ],
                    ),
                    SizedBox(
                      height: 12.h,
                    ),
                  ],
                ),
              ),
              isExpanded: _selectedIndexes.contains(0),
            ),
          ],
        ),
      ),
    );
  }
}
