import 'package:app/presentation/component/constant.dart';
import 'package:app/presentation/component/customAppBar.dart';
import 'package:app/presentation/pages/beranda/pddikti/component/card/card_status_ajuan.dart';
import 'package:app/presentation/pages/beranda/sister/component/tabbarviewsister.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DetailRiwayatUsulanPDDIKTIPage extends StatelessWidget {
  final String dokumenValid;
  final String nama;
  final String jenis;
  final String ket;
  final String tglUpdate;
  final String status;
  const DetailRiwayatUsulanPDDIKTIPage({
    Key? key,
    required this.dokumenValid,
    required this.jenis,
    required this.ket,
    required this.nama,
    required this.tglUpdate,
    required this.status,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteBgPage,
      appBar: CustomAppBar(
        title: 'Detail Riwayat Usulan',
      ),
      body: SingleChildScrollView(
        child: Container(
          // color: Colors.amber,
          color: whiteBgPage,
          padding: EdgeInsets.symmetric(
            horizontal: 16.w,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20.h,
              ),
              Text(
                'Status Ajuan',
                style: TextStyle(
                  color: blue3,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(
                height: 16.h,
              ),
              CardStatusAjuanPDDIKTI(
                categoriess: status,
                date: tglUpdate,
                // data: [
                //   {
                //     'field': 'Nama',
                //     'info': nama,
                //   },
                //   {
                //     'field': 'Jenis Usulan',
                //     'info': jenis,
                //   },
                //   {
                //     'field': 'Status Dokumen',
                //     'info': "asd",
                //   },
                //   {
                //     'field': 'Keterangan',
                //     'info': ket,
                //   },
                //   {
                //     'field': 'Tanggal Update',
                //     'info': tglUpdate,
                //   },
                // ],
              ),
              TabBarViewSister(
                data: [
                  {
                    'nama': 'Nama',
                    'info': nama,
                  },
                  {
                    'nama': 'Jenis Usulan',
                    'info': jenis,
                  },
                  {'nama': 'Status Dokumen', 'info': _statusDokumen()},
                  {
                    'nama': 'Keterangan',
                    'info': ket,
                  },
                  {
                    'nama': 'Tanggal Update',
                    'info': tglUpdate,
                  },
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _statusDokumen() {
    BoxDecoration decoration;
    String namaStatus;
    TextStyle style;
    if (dokumenValid == 'Y') {
      namaStatus = 'Valid';
      style = TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
          color: Color.fromRGBO(2, 122, 72, 1),
          fontFamily: 'Inter');

      decoration = BoxDecoration(
          color: Color.fromRGBO(236, 253, 243, 1),
          borderRadius: BorderRadius.circular(16.r));
    } else if (dokumenValid == 'T') {
      style = TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
          color: Color.fromRGBO(180, 35, 24, 1),
          fontFamily: 'Inter');
      namaStatus = 'Tidak Valid';

      decoration = BoxDecoration(
          color: Color.fromRGBO(254, 243, 242, 1),
          borderRadius: BorderRadius.circular(16.r));
    } else if (dokumenValid == 'X') {
      style = TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
          color: Color.fromRGBO(52, 64, 84, 1),
          fontFamily: 'Inter');
      namaStatus = '-';

      decoration = BoxDecoration(
          color: Colors.transparent, borderRadius: BorderRadius.circular(16.r));
    } else if (dokumenValid == 'N') {
      style = TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
          color: Color.fromRGBO(52, 64, 84, 1),
          fontFamily: 'Inter');

      namaStatus = 'Belum diperiksa oleh LLDikti';

      decoration = BoxDecoration(
          color: Color.fromRGBO(242, 244, 247, 1),
          borderRadius: BorderRadius.circular(16.r));
    } else {
      style = TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
          color: Color.fromRGBO(52, 64, 84, 1),
          height: 3.sp,
          fontFamily: 'Inter');

      namaStatus = '-';
      decoration = BoxDecoration(
          color: Colors.transparent, borderRadius: BorderRadius.circular(16.r));
    }
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Container(
        width: dokumenValid == 'N' ? 140.w : null,
        padding: namaStatus != '-'
            ? dokumenValid != 'N'
                ? EdgeInsets.symmetric(vertical: 2.h, horizontal: 10.w)
                : EdgeInsets.symmetric(vertical: 6.h, horizontal: 20.w)
            : EdgeInsets.zero,
        decoration: decoration,
        child: Text(
          namaStatus,
          style: style,
          textAlign: TextAlign.center,
        ),
        alignment: Alignment.center,
      ),
    );
  }
}
