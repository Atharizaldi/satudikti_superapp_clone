import 'package:app/common/dateFormat.dart';
import 'package:app/data/source/remote/model/pddikti/perguruanTinggi/getDetailPT.dart';
import 'package:app/data/source/remote/model/pddikti/perguruanTinggi/getPelaporanPT.dart';
import 'package:app/presentation/component/constant.dart';
import 'package:app/presentation/component/mainPage/containerKontak.dart';
import 'package:app/presentation/pages/beranda/pddikti/component/reusableWidgets/contact_pddikti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TabProfilPT extends StatefulWidget {
  final GetDetailPT getDetailPT;
  final GetPelaporanPT? getPelaporanPT;
  final bool havePelaporan;
  const TabProfilPT(
      {Key? key,
      required this.getDetailPT,
      this.getPelaporanPT,
      required this.havePelaporan})
      : super(key: key);

  @override
  _TabProfilPTState createState() => _TabProfilPTState();
}

class _TabProfilPTState extends State<TabProfilPT> {
  FormatDate formatDate = new FormatDate();

  ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: whiteBgPage,
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            SizedBox(
              height: 36.h,
            ),
            Container(
              width: double.infinity,
              // constraints: BoxConstraints(minHeight: 70.h, maxHeight: 120.h),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  rowBioProfil(
                    context: context,
                    label: "Tanggal Berdiri",
                    info: widget.havePelaporan
                        ? formatDate.formatDate2(
                            widget.getPelaporanPT!.data.pelaporan.tglBerdiriPt)
                        : '-',
                  ),
                  rowBioProfil(
                    context: context,
                    label: "No. SK PT",
                    info: this
                                .widget
                                .getDetailPT
                                .data
                                .perguruanTinggi
                                .skPendirian ==
                            ""
                        ? ' - '
                        : this
                            .widget
                            .getDetailPT
                            .data
                            .perguruanTinggi
                            .skPendirian,
                  ),
                  rowBioProfil(
                    context: context,
                    label: "Tanggal SK PT",
                    info: formatDate.formatDate2(this
                                .widget
                                .getDetailPT
                                .data
                                .perguruanTinggi
                                .tglSkPendirian ==
                            ""
                        ? " - "
                        : this
                            .widget
                            .getDetailPT
                            .data
                            .perguruanTinggi
                            .tglSkPendirian),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            ContactPddikti(
              jalan: widget.getDetailPT.data.perguruanTinggi.alamat.jalan,
              telepon: widget.getDetailPT.data.perguruanTinggi.telepon,
              faksimile: widget.getDetailPT.data.perguruanTinggi.faksimile,
              email: widget.getDetailPT.data.perguruanTinggi.email,
              website: widget.getDetailPT.data.perguruanTinggi.website,
            ),
          ],
        ),
      ),
    );
  }

  Widget containerContact(String icon, String judul, String deskripsi,
      [VoidCallback? function]) {
    return deskripsi.isNotEmpty
        ? containerKontak(
            icon: icon,
            judul: judul,
            deskripsi: deskripsi,
            function: function,
            margin: EdgeInsets.zero,
          )
        : SizedBox();
  }

  Widget rowBioProfil(
      {required BuildContext context,
      required String label,
      required String info}) {
    return Flexible(
      child: Container(
        width: 109.w,
        decoration: BoxDecoration(
          color: white,
          borderRadius: BorderRadius.circular(10.r),
        ),
        padding: EdgeInsets.symmetric(horizontal: 17.w, vertical: 16.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 10.sp,
                color: neutral30,
              ),
            ),
            SizedBox(
              height: 8.h,
            ),
            Flexible(
              child: Container(
                // height: 30.h,
                alignment: Alignment.topCenter,
                child: Text(
                  info,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                    color: blue3,
                  ),
                ),
              ),
            ),
          ],
        ),
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
            detailBigCard(context, 'assets/pddikti/icon/Subtract.png',
                widget.getDetailPT.data.perguruanTinggi.alamat.jalan),
            detailBigCard(context, 'assets/pddikti/icon/el_phone-alt.png',
                widget.getDetailPT.data.perguruanTinggi.telepon),
            detailBigCard(context, 'assets/pddikti/icon/fa_fax.png',
                widget.getDetailPT.data.perguruanTinggi.faksimile),
            detailBigCard(context, 'assets/pddikti/icon/Group 971.png',
                widget.getDetailPT.data.perguruanTinggi.email),
            detailBigCard(context, 'assets/pddikti/icon/Group 11.png',
                widget.getDetailPT.data.perguruanTinggi.website),
          ],
        ),
      ),
    );
  }

  Row detailBigCard(BuildContext context, String icon, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Image.asset(
          icon,
        ),
        Container(
          width: 253.w,
          height: 34.h,
          alignment: Alignment.centerLeft,
          child: Text(
            value == '' ? 'Tidak ada data' : value,
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
