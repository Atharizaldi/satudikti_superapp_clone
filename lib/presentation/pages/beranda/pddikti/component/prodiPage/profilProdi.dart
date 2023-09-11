import 'package:app/common/dateFormat.dart';
import 'package:app/presentation/component/constant.dart';
import 'package:app/presentation/pages/beranda/pddikti/component/card/cardDeskripsiTabView.dart';
import 'package:app/presentation/pages/beranda/pddikti/component/reusableWidgets/contact_pddikti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TabProfilProdi extends StatefulWidget {
  final String tglBerdiri, sk, tglSk, jalan, faks, telepon, email, website;
  final dynamic getRasioMhsDosen;
  const TabProfilProdi({
    Key? key,
    required this.tglBerdiri,
    required this.sk,
    required this.tglSk,
    required this.jalan,
    required this.email,
    required this.faks,
    required this.telepon,
    required this.website,
    required this.getRasioMhsDosen,
  }) : super(key: key);

  @override
  _TabProfilProdiState createState() => _TabProfilProdiState();
}

class _TabProfilProdiState extends State<TabProfilProdi> {
  var panjangRasio;

  @override
  void initState() {
    if (widget.getRasioMhsDosen == '') {
      panjangRasio = 0;
    } else {
      panjangRasio = widget.getRasioMhsDosen.data.rasio.length;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    FormatDate formatDate = new FormatDate();
    return Container(
      color: whiteBgPage,
      padding: EdgeInsets.only(top: 36.h),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CardDeskripsiTabView(
                heading1: 'Tanggal Berdiri',
                heading2: formatDate.formatDate2(this.widget.tglBerdiri),
              ),
              SizedBox(
                width: 16.w,
              ),
              CardDeskripsiTabView(
                heading1: 'Tanggal SK',
                heading2: formatDate.formatDate2(this.widget.tglSk),
              ),
            ],
          ),
          SizedBox(
            height: screenWidth(context) * (1 / 30),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CardDeskripsiTabView(
                heading1: 'SK\nPenyelenggaraan',
                heading2: this.widget.sk,
              ),
              SizedBox(
                width: 16.w,
              ),
              CardDeskripsiTabView(
                heading1: panjangRasio == 0
                    ? 'Rasio Dosen'
                    : 'Rasio Dosen\n${this.widget.getRasioMhsDosen.data.rasio[panjangRasio - 2].tahun}',
                heading2: panjangRasio == 0
                    ? '-'
                    : this
                        .widget
                        .getRasioMhsDosen
                        .data
                        .rasio[panjangRasio - 2]
                        .rasio,
              ),
            ],
          ),
          SizedBox(
            height: screenWidth(context) * (1 / 30),
          ),
          CardDeskripsiTabView(
            heading1: panjangRasio == 0
                ? 'Rasio Mahasiswa'
                : 'Rasio Mahasiswa\n${this.widget.getRasioMhsDosen.data.rasio[panjangRasio - 1].tahun}',
            heading2: panjangRasio == 0
                ? '-'
                : this
                    .widget
                    .getRasioMhsDosen
                    .data
                    .rasio[panjangRasio - 1]
                    .rasio,
          ),
          SizedBox(
            height: screenWidth(context) * (1 / 30),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: ContactPddikti(
              jalan: widget.jalan,
              telepon: widget.telepon,
              faksimile: widget.faks,
              email: widget.email,
              website: widget.website,
            ),
          ),
          SizedBox(
            height: screenWidth(context) * (1 / 30),
          )
        ],
      ),
    );
  }

  Container bigCard(BuildContext context) {
    return Container(
      height: screenHeight(context) * (1 / 2.3),
      width: screenWidth(context) * 0.9,
      decoration: BoxDecoration(
        color: abu5,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
            vertical: screenWidth(context) * 0.06,
            horizontal: screenWidth(context) * 0.06),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            detailBigCard(
                context, 'assets/pddikti/icon/Subtract.png', this.widget.jalan),
            detailBigCard(context, 'assets/pddikti/icon/el_phone-alt.png',
                this.widget.telepon),
            detailBigCard(
                context, 'assets/pddikti/icon/fa_fax.png', this.widget.faks),
            detailBigCard(context, 'assets/pddikti/icon/Group 971.png',
                this.widget.email),
            detailBigCard(context, 'assets/pddikti/icon/Group 11.png',
                this.widget.website),
          ],
        ),
      ),
    );
  }

  Row detailBigCard(BuildContext context, String icon, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Image.asset(icon),
        Container(
          width: 253.w,
          height: 34.h,
          alignment: Alignment.centerLeft,
          child: Text(
            value.length > 3 ? value : 'Tidak ada data',
            textAlign: TextAlign.start,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400),
          ),
        ),
      ],
    );
  }
}
