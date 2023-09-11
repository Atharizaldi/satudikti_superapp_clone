import 'package:app/presentation/component/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HasilVerifikasiPage extends StatefulWidget {
  final int hasilVerifikasi;
  final dynamic listVerif;
  const HasilVerifikasiPage(
      {Key? key, required this.hasilVerifikasi, this.listVerif})
      : super(key: key);

  @override
  _HasilVerifikasiPageState createState() => _HasilVerifikasiPageState();
}

class _HasilVerifikasiPageState extends State<HasilVerifikasiPage>
    with TickerProviderStateMixin {
  late AnimationController _animationController;

  late Animation<double> _opacity;
  // late Animation<double> _opacityCheck;
  late Animation<double> _opacityDetail;
  late Animation<Offset> _positioned;
  late Animation<Offset> _positionedDetail;
  late Animation<Offset> _positionedTidakDItemukan;
  late Animation<Offset> _positionedLogoTidakDItemukan;

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
    return Container(
      width: double.infinity,
      // height: double.infinity,
      child: widget.hasilVerifikasi == 1
          ? Column(
              children: [
                FadeTransition(
                  opacity: _opacity,
                  child: SlideTransition(
                    position: _positioned,
                    child: Image.asset(
                      'assets/ijazahln/success.png',
                      // scale: 4,
                    ),
                  ),
                ),
                SizedBox(
                  height: 60.h,
                ),
                FadeTransition(
                  opacity: _opacityDetail,
                  child: detailCard(),
                )
              ],
            )
          : Column(
              children: [
                FadeTransition(
                  opacity: _opacity,
                  // color: Colors.amber,
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
                        padding: EdgeInsets.symmetric(horizontal: 39.w),
                        child: Column(
                          children: [
                            Text(
                              'Silahkan tuliskan data anda dengan benar pada halaman sebelumnya',
                              style: TextStyle(
                                  fontSize: 14.sp, fontWeight: FontWeight.w400),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        )),
                  ),
                )
              ],
            ),
    );
  }

  Container detailCard() {
    return Container(
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(10), color: abu5),
      padding: EdgeInsets.symmetric(horizontal: 24.h, vertical: 32.h),
      margin: EdgeInsets.symmetric(horizontal: 12.h),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  width: 130.w,
                  // height: 17.h,
                  child: Text(
                    'Nama',
                    style:
                        TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
                  )),
              SizedBox(
                height: 15.h,
              ),
              Container(
                  width: 130.w,
                  // height: 17.h,
                  child: Text(
                    widget.listVerif.data.statusSk.namaPengusul,
                    style: TextStyle(fontSize: 14.sp),
                    maxLines: 2,
                  )),
            ],
          ),
          SizedBox(
            height: 16.sp,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  width: 130.w,
                  // height: 17.h,
                  child: Text(
                    'Perguruan Tinggi',
                    style:
                        TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
                  )),
              SizedBox(
                height: 15.h,
              ),
              Container(
                  width: 155.w,
                  // height: 34.h,
                  child: Text(
                    widget.listVerif.data.statusSk.namaPt,
                    style: TextStyle(fontSize: 14.sp),
                    maxLines: 2,
                  )),
            ],
          ),
          SizedBox(
            height: 16.sp,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  width: 130.w,
                  // height: 17.h,
                  child: Text(
                    'Program Studi',
                    style:
                        TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
                  )),
              SizedBox(
                height: 15.h,
              ),
              Container(
                  width: 130.w,
                  // height: 17.h,
                  child: Text(
                    widget.listVerif.data.statusSk.namaProdi,
                    style: TextStyle(fontSize: 14.sp),
                  )),
            ],
          ),
          SizedBox(
            height: 16.sp,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  width: 130.w,
                  // height: 17.h,
                  child: Text(
                    'Gelar',
                    style:
                        TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
                  )),
              SizedBox(
                height: 15.h,
              ),
              Container(
                  width: 130.w,
                  // height: 17.h,
                  child: Text(
                    widget.listVerif.data.statusSk.namaGelar,
                    style: TextStyle(fontSize: 14.sp),
                  )),
            ],
          ),
          SizedBox(
            height: 16.sp,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  width: 130.w,
                  // height: 17.h,
                  child: Text(
                    'Hasil Kesetaraan',
                    style:
                        TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
                  )),
              SizedBox(
                height: 15.h,
              ),
              Container(
                  width: 130.w,
                  // height: 17.h,
                  child: Text(
                    widget.listVerif.data.statusSk.hasilKesetaraan,
                    style: TextStyle(fontSize: 14.sp),
                  )),
            ],
          ),
          SizedBox(
            height: 16.sp,
          ),
          Row(
            children: [
              Container(
                  width: 130.w,
                  // height: 17.h,
                  child: Text(
                    'Nomor SK',
                    style:
                        TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
                  )),
              SizedBox(
                height: 15.h,
              ),
              Container(
                  width: 130.w,
                  // height: 17.h,
                  child: Text(
                    widget.listVerif.data.statusSk.noSk,
                    style: TextStyle(
                        fontSize: 14.sp,
                        color: yellow2,
                        fontWeight: FontWeight.w700),
                  )),
            ],
          ),
        ],
      ),
    );
  }
}
