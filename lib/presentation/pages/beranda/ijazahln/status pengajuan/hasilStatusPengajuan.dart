import 'package:app/data/source/remote/model/IjazahLN/status/statusByEmail.dart';
import 'package:app/presentation/component/constant.dart';
import 'package:app/presentation/component/customAppBar.dart';
import 'package:app/presentation/pages/beranda/ijazahln/component/statusPengjuanPage/detailHasilStatusPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HasilStatusPengajuan extends StatefulWidget {
  final bool pengajuanBerhasil;
  final StatusByEmail? listByEmail;
  HasilStatusPengajuan(
      {Key? key, required this.pengajuanBerhasil, this.listByEmail})
      : super(key: key);

  @override
  _HasilStatusPengajuanState createState() => _HasilStatusPengajuanState();
}

class _HasilStatusPengajuanState extends State<HasilStatusPengajuan>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  // late AnimationController _testController;
  // late AnimationController _test2Controller;

  late Animation<double> _opacity;
  late Animation<double> _opacityDetail;

  late Animation<Offset> _positioned;
  late Animation<Offset> _positionedDetail;
  late Animation<Offset> _positionedLogoTidakDItemukan;

  late Animation<Offset> _positionedTidakDItemukan;

  bool flag = false;
  bool flag2 = false;

  @override
  void initState() {
    super.initState();

    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 1));

    _opacity = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(parent: _animationController, curve: Interval(0, 0.3)));
    _opacityDetail = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(parent: _animationController, curve: Interval(0.9, 1)));
    _positioned = Tween<Offset>(begin: Offset(0, 1.5), end: Offset(0, 1 / 3))
        .animate(CurvedAnimation(
            parent: _animationController,
            curve: Interval(0.4, 1, curve: Curves.decelerate)));
    _positionedDetail = Tween<Offset>(begin: Offset(0, 0), end: Offset(0, -0.9))
        .animate(CurvedAnimation(
            parent: _animationController,
            curve: Interval(0.3, 1, curve: Curves.decelerate)));

    _positionedLogoTidakDItemukan =
        Tween<Offset>(begin: Offset(0, 1.5), end: Offset(0, 0.8)).animate(
            CurvedAnimation(
                parent: _animationController,
                curve: Interval(0.3, 1, curve: Curves.decelerate)));

    _positionedTidakDItemukan =
        Tween<Offset>(begin: Offset(0, 0), end: Offset(0, 1.6)).animate(
            CurvedAnimation(
                parent: _animationController,
                curve: Interval(0.3, 1, curve: Curves.decelerate)));
    _animationController.forward();
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteBgPage,
      appBar: CustomAppBar(
        title: 'Status Pengajuan Penyetaraan',
        textStyle: TextStyle(
            fontSize: 16.sp,
            color: white,
            fontWeight: FontWeight.w600,
            letterSpacing: 1),
      ),
      body: Container(
        child: ListView(
          children: [
            widget.pengajuanBerhasil == true
                ? hasilDitemukan(context)
                : tidakDitemukan(context)
          ],
        ),
      ),
    );
  }

  Column tidakDitemukan(BuildContext context) {
    return Column(
      children: [
        FadeTransition(
          opacity: _opacity,
          child: SlideTransition(
            position: _positionedLogoTidakDItemukan,
            child: Container(
              width: 224.w,
              child: Image.asset(
                'assets/ijazahln/not_success.png',
                // scale: 2,
              ),
            ),
          ),
        ),
        FadeTransition(
          opacity: _opacityDetail,
          child: SlideTransition(
            position: _positionedTidakDItemukan,
            child: Container(
                child: Column(
              children: [
                Text(
                  'Silahkan tuliskan data anda dengan benar pada halaman sebelumnya',
                  style:
                      TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 60.w,
                ),
              ],
            )),
          ),
        ),
        SizedBox(
          height: 100.w,
        ),
        GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Container(
            margin: EdgeInsets.only(top: 16.88.w),
            height: 39.w,
            width: 117.w,
            decoration: BoxDecoration(
                color: blueLinear1, borderRadius: BorderRadius.circular(15)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Kembali',
                  style: TextStyle(
                      color: white,
                      fontSize: 12.sp,
                      letterSpacing: 1,
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Column hasilDitemukan(BuildContext context) {
    return Column(
      children: [
        _dataDitemukanAnimationCard(),
        SizedBox(
          height: 58.w,
        ),
        FadeTransition(
          opacity: _opacityDetail,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  // height: 60.w,
                  // color: Colors.amber,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Hasil Pencarian',
                    style: TextStyle(
                        fontSize: 20.w,
                        fontWeight: FontWeight.w700,
                        color: blue3),
                  ),
                ),
                SizedBox(
                  height: 20.w,
                ),
                ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: widget.listByEmail!.data.daftarUsulan.length,
                  itemBuilder: (context, index) {
                    return cardHasilPencarian(context, index);
                  },
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  FadeTransition _dataDitemukanAnimationCard() {
    return FadeTransition(
      opacity: _opacity,
      child: SlideTransition(
        position: _positioned,
        child: Container(
          width: 358.w,
          height: 74.w,
          padding: EdgeInsets.all(20.w),
          decoration: BoxDecoration(
              color: green3, borderRadius: BorderRadius.circular(10)),
          child: Row(
            children: [
              Icon(
                Icons.check_circle_rounded,
                size: 34.w,
                color: white,
              ),
              SizedBox(
                width: 12.w,
              ),
              SelectableText(
                "Data Ditemukan",
                style: TextStyle(
                    color: white, fontSize: 14.sp, fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
      ),
    );
  }

  GestureDetector cardHasilPencarian(BuildContext context, int idx) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailHasilStatusPage(
                noRegis: widget.listByEmail!.data.daftarUsulan[idx].noRegistrasi
                    .toString(),
              ),
            ));
      },
      child: Container(
        // height: 152.w,
        // width: 358.w,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: white,
            boxShadow: [

              BoxShadow(
                color: Color.fromRGBO(151, 151, 151, 0.08),
                offset: Offset(0, 14),
                blurRadius: 15,
              )
            ]),
        padding: EdgeInsets.all(20.w),
        margin: EdgeInsets.only(bottom: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.all(8.w),
                  decoration: BoxDecoration(
                    border: Border.all(color: blue2),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text(
                    'No. Regis ' +
                        widget.listByEmail!.data.daftarUsulan[idx].noRegistrasi
                            .toString(),
                    style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: blue2),
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios_outlined,
                  size: screenWidth(context) * (1 / 23),
                )
              ],
            ),
            SizedBox(
              height: 12.w,
            ),
            Text(
              widget.listByEmail!.data.daftarUsulan[idx].namaPt,
              style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w700,
                  color: blue4,
                  overflow: TextOverflow.ellipsis),
            ),
            SizedBox(
              height: 8.w,
            ),
            Text(
              widget.listByEmail!.data.daftarUsulan[idx].singkatJenjangStudi,
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(
              height: 8.w,
            ),
            Text(widget.listByEmail!.data.daftarUsulan[idx].namaProdi,
                style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    color: unselectedTextColor,
                    overflow: TextOverflow.ellipsis))
          ],
        ),
      ),
    );
  }
}
