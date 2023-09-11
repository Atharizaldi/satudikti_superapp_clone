import 'package:app/presentation/component/customAppBar.dart';
import 'package:app/presentation/pages/beranda/bima/component/card_Download.dart';
import 'package:app/presentation/pages/beranda/bima/component/dropdown_bima.dart';
import 'package:app/presentation/pages/beranda/bima/component/searchbar_bima.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DaftarPengumumanBima extends StatefulWidget {
  const DaftarPengumumanBima({Key? key}) : super(key: key);

  @override
  State<DaftarPengumumanBima> createState() => _DaftarPengumumanBimaState();
}

class _DaftarPengumumanBimaState extends State<DaftarPengumumanBima> {
  TextEditingController textEditingController = TextEditingController();

  ScrollController scrollController = ScrollController();
  bool tappedPengumuman = false;
  String? searchKeywordPengumuman = "";
  String? temp = "";
  String? text = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF9FAFE),
      appBar: CustomAppBar(
        title: 'Daftar Pengumuman',
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Text(text.toString()),
              SearchBarBima(
                isSubmitted: (value){
                  setState(() {
                  text = value;
                  });
                },
                hintText: 'Cari pengumuman',
                searchType: TypeSearchBarBima.withDropdownFilter,
                tappedPengumuman: tappedPengumuman,
                searchKeywordPengumuman: searchKeywordPengumuman.toString(),
                items: ['Dikti', 'Diksi'],
              ),
              SizedBox(
                height: 20.w,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: DropDownBima(
                  items: ['Pengumuman terkini', 'Pengumuman terlama'],
                ),
              ),
              SizedBox(
                height: 30.h,
              ),
              DownloadWidgetCard(
                category: 'Diksi',
                noSurat: '0187/E5.3/HM.01.00/2023',
                judulDokumen:
                    'Pemberitahuan Hasil Akreditasi Jurnal Ilmiah Periode IV Tahun 2022 (Revisi)',
                date: '11/11/11',
              ),
              SizedBox(
                height: 12.h,
              ),
              DownloadWidgetCard(
                category: 'Dikti',
                noSurat: '0187/E5.3/HM.01.00/2023',
                judulDokumen:
                    'Panduan Penelitian dan Pengabdian Kepada Masyarakat Tahun 2023',
                date: '11/11/11',
              )
            ],
          ),
        ),
      ),
    );
  }
}
