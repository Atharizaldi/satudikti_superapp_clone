import 'package:app/injection.dart' as di;
import 'package:app/presentation/component/cardWithImage.dart';
import 'package:app/presentation/component/constant.dart';
import 'package:app/presentation/component/inkEffect.dart';
import 'package:app/presentation/pages/beranda/beritaDanPengumumanDetail/component/bannerInformasi.dart';
import 'package:app/presentation/pages/beranda/kedaireka/component/newListStyleCardKedaireka.dart';
import 'package:app/presentation/pages/beranda/kedaireka/industri/industri.dart';
import 'package:app/presentation/pages/beranda/kedaireka/insandikti/insandikti.dart';
import 'package:app/presentation/pages/showWebsite.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../faq/bloc/faq_module/faqmodule_bloc.dart';
import '../../faq/faq_page_per_module.dart';

Widget listDraggableHome(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(
        height: 29,
      ),
      Padding(
        padding: const EdgeInsets.only(left: 16, right: 17),
        child: Text(
          "Kategori",
          style: TextStyle(
              fontSize: 20.sp, fontWeight: FontWeight.bold, color: blue3),
        ),
      ),
      SizedBox(
        height: 20,
      ),
      NewListStyleKedaireka(
          heightSpace: 0,
          function: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => InsanDikti()));
          },
          image: "assets/kedaireka/insandikti.png",
          title: "Insan PT",
          subTitle: "Dosen Perguruan Tinggi"),
      SizedBox(
        height: 20,
      ),
      NewListStyleKedaireka(
          heightSpace: 2,
          function: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => IndustriKedaireka()));
          },
          image: "assets/kedaireka/industri.png",
          title: "Industri",
          subTitle: "Perusahaan swasta, BUMN/D, LSM, Asosiasi dan sejenisnya"),
      SizedBox(
        height: 20.h,
      ),
      Padding(
        padding: EdgeInsets.only(left: 20.w, right: 13.w),
        child: Text(
          "Informasi Terkait Kedaireka",
          style: TextStyle(
              fontSize: 20.sp, fontWeight: FontWeight.bold, color: blue3),
        ),
      ),
      SizedBox(height: 20.h),
      Container(
        padding: EdgeInsets.only(left: 18.w, right: 18.w),
        width: double.infinity,
        child: InkEffect(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ShowWebsite(
                    title: "Kedaireka",
                    link: 'https://kedaireka.id/matchingfund',
                  ),
                ));
          },
          boxDecoration: BoxDecoration(
            color: white,
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10.r),
                bottomRight: Radius.circular(10.r)),
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                height: 135.h,
                decoration: BoxDecoration(
                  gradient: kedairekaInformasiBgGradient,
                  color: neutral100,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10.r),
                      topRight: Radius.circular(10.r)),
                ),
                child: Image.asset("assets/kedaireka/kedaireka2.png"),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 18,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Text(
                      "Informasi Kolaborasi Kedaireka",
                      style: TextStyle(
                          color: neutral80,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Lihat informasi kedaireka",
                          style: TextStyle(
                            color: Color(0xFF1A689E),
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w200,
                          ),
                        ),
                        SizedBox(width: 5.w),
                        Icon(
                          Icons.navigate_next,
                          color: Color(0xFF1A689E),
                          size: 17.sp,
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 24.h),
                ],
              ),
            ],
          ),
        ),
      ),
      _bannerFAQ(context),
      SizedBox(height: 20.h),
    ],
  );
}

Widget _bannerFAQ(BuildContext context){
    return GestureDetector(
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return BlocProvider(
                create: (context) => di.locator<FaqmoduleBloc>()
                  ..add(FetchfaqModuleEvent('kedaireka')),
                child: FAQModul(),
              );
            },
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 25.h, horizontal: 15.w),
        width: 358.w,
        child: Card(
          color: blueLinear1,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  alignment: Alignment.center,
                  child: CircleAvatar(
                    backgroundImage: AssetImage(
                      'assets/faq/faq_icon.png'
                    ),
                  ),
                ),
                SizedBox(
                  width: 20.w
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Butuh Informasi lainnya?",
                      style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w700,
                        letterSpacing: -0.006.sp,
                        color: white
                      ),
                    ),
                    SizedBox(
                      height: 10.w,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Lihat FAQ",
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                            letterSpacing: -0.006.sp,
                            color: white
                          ),
                        ),
                        SizedBox(
                          width: 2,
                        ),
                        Icon(
                          Icons.navigate_next,
                          color: white,
                          size: 16,
                        )
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

Widget listDraggableIndustri(BuildContext context, idx, result) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisSize: MainAxisSize.min,
    children: [
      SizedBox(
        height: 29,
      ),
      Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0),
        child: Text(
          "Kenapa harus menjadi mitra Industri?",
          style: TextStyle(
              fontSize: 20.sp, fontWeight: FontWeight.bold, color: blue3),
        ),
      ),
      SizedBox(
        height: 20.h,
      ),
      CardWithImage(
        colorCard: Color(0xffDFF7FF),
        colorTextTitle: Color(0xff00ACC3),
        colorTextSubTitle: neutral40,
        textTitle: "Buka Peluang Cipta",
        textSubTitle:
            "Isi formulir peluang cipta secara detail demi menarik minat Insan Perguruan Tinggi untuk ajukan kreasi rekanya.",
        image: 'assets/kedaireka/buka_peluang_cipta.png',
        positionTopImage: -15.h,
        positionBottomImage: 0.h,
        positionRightImage: 20.w,
      ),
      SizedBox(
        height: 8.h,
      ),
      CardWithImage(
        colorCard: Color(0xffFFDFDF),
        colorTextTitle: Color(0xffFF5D29),
        colorTextSubTitle: neutral40,
        textTitle: "Terima Ajuan Kreasi Reka",
        textSubTitle:
            "Jelajahi beragam ide kreatif dan inovatif dari Insan Perguruan Tinggi yang siap Anda seleksi.",
        image: 'assets/kedaireka/terima_ajuan_kreasi_reka.png',
        positionRightColumn: 15.w,
        positionLeftColumn: 205.w,
        positionBottomImage: 0.h,
        imageWidth: 232.w,
        imageHeight: 124.h,
      ),
      SizedBox(
        height: 8.h,
      ),
      CardWithImage(
        colorCard: Color(0xffFFF9DF),
        colorTextTitle: Color(0xffFED81D),
        colorTextSubTitle: neutral40,
        textTitle: "Berkolaborasi dengan Insan Perguruan Tinggi",
        textSubTitle:
            "Sinergikan kebutuhan peluang cipta Anda dengan hasil seleksi kreasi reka ke kerja sama strategis.",
        image: 'assets/kedaireka/kolaborasi_dengan_insan_pt.png',
        positionLeftImage: 189.w,
        positionBottomImage: 0.h,
        positionTopImage: 14.h,
        imageHeight: 208.h,
        imageWidth: 208.w,
      ),
      SizedBox(
        height: 42.h,
      ),
      Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0),
        child: Text(
          "Berbagai Peluang Telah ditawarkan",
          style: TextStyle(
              fontSize: 20.sp, fontWeight: FontWeight.bold, color: blue3),
        ),
      ),
      // SizedBox(height: 20.h),
      Flexible(
          child: ListView.builder(
        itemCount: result.length > 2
            ? 3
            : result.length > 1
                ? 2
                : result.length > 0
                    ? 1
                    : 0,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          final res = result![index];
          return Padding(
            padding:
                const EdgeInsets.only(left: 16, right: 16, top: 0, bottom: 20),
            child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: white,
                  borderRadius: BorderRadius.circular(10.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 0.2,
                      blurRadius: 0.6,
                      offset: Offset(0, 0.5), // changes position of shadow
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5.r),
                              border: Border.all(color: red)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              res.categories.toString() == ""
                                  ? " - "
                                  : res.categories.toString(),
                              style: TextStyle(
                                  color: red,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 10.sp),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Container(
                          child: Text(
                            res.title.toString() == ""
                                ? " - "
                                : res.title.toString(),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: blue4,
                                fontWeight: FontWeight.w500,
                                fontSize: 14.sp),
                          ),
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 2.0),
                          child: Text(
                            res.userProfile!.nama.toString() == ""
                                ? " - "
                                : res.userProfile!.nama.toString(),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: neutral60,
                                fontWeight: FontWeight.bold,
                                fontSize: 12.sp),
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 2.0),
                          child: Text(
                            res.userProfile!.namaPT.toString() == ""
                                ? " - "
                                : res.userProfile!.namaPT.toString(),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: neutral30,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400),
                          ),
                        )
                      ],
                    ),
                  ),
                )),
          );
        },
      )),
      SizedBox(
        height: 8.h,
      ),
      Padding(
        padding: const EdgeInsets.only(left: 16, right: 16),
        child: bannerInformasi(context, idx),
      ),
      SizedBox(
        height: 36.sp,
      ),
      // BtnDaftarSekarang(function: () {
      //   Navigator.push(
      //       context,
      //       MaterialPageRoute(
      //         builder: (context) => ShowWebsite(
      //           title: "Kedaireka",
      //           link: 'https://kedaireka.id/registration?tab=industry',
      //         ),
      //       ));
      // }),
    ],
  );
}

Widget listDraggableInsanPT(BuildContext context, idx, result) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisSize: MainAxisSize.min,
    children: [
      SizedBox(
        height: 29,
      ),
      Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0),
        child: Text(
          "Kenapa harus jadi Insan PT?",
          style: TextStyle(
              fontSize: 20.sp, fontWeight: FontWeight.bold, color: blue3),
        ),
      ),
      SizedBox(
        height: 20.h,
      ),
      CardWithImage(
        colorCard: Color(0xffDFF7FF),
        colorTextTitle: Color(0xff00ACC3),
        colorTextSubTitle: neutral40,
        textTitle: "Publikasikan Kreasi Reka",
        textSubTitle:
            "Isi formulir kreasi reka secara\ndetail demi menarik minat pihak\nIndustri untuk menawarkan\nkolaborasi.",
        image: 'assets/kedaireka/publikasi_karya.png',
        positionTopImage: 13.w,
        positionLeftImage: 220.w,
        positionBottomImage: 0.h,
        imageWidth: 139.w,
        imageHeight: 139.w,
      ),
      SizedBox(
        height: 8.h,
      ),
      CardWithImage(
        colorCard: Color(0xffFFDFDF),
        colorTextTitle: Color(0xffFF5D29),
        colorTextSubTitle: neutral40,
        textTitle: "Terima Tawaran Kolaborasi",
        textSubTitle:
            "Seleksi beragam potensi kerja sama dari pihak Industri yang tertarik dengan kreasi reka Anda.",
        image: 'assets/kedaireka/tawaran_kolaborasi.png',
        positionBottomColumn: 24.h,
        positionLeftColumn: 204.w,
        positionRightColumn: 16.w,
        positionTopImage: 23.w,
        positionLeftImage: 11.w,
        positionRightImage: 199.w,
        positionBottomImage: 0.h,
        imageHeight: 137.h,
        imageWidth: 180.w,
      ),
      SizedBox(
        height: 8.h,
      ),
      CardWithImage(
        colorCard: Color(0xffFFF9DF),
        colorTextTitle: Color(0xffC3B000),
        colorTextSubTitle: neutral40,
        textTitle: "Berkolaborasi dengan Industri",
        textSubTitle:
            "Sinergikan aspirasi kreasi reka\nAnda dengan tawaran terbaik\ndari pihak Industri dan raih\nMatching Fund.",
        image: 'assets/kedaireka/kolaborasi_dengan_industri.png',
        positionBottomImage: 0.h,
        positionLeftImage: 166.w,
        imageHeight: 120.h,
        imageWidth: 235.w,
      ),
      SizedBox(
        height: 42.h,
      ),
      Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0),
        child: Text(
          "Berbagai Solusi Telah ditawarkan",
          style: TextStyle(
              fontSize: 20.sp, fontWeight: FontWeight.bold, color: blue3),
        ),
      ),
      Flexible(
          child: ListView.builder(
        itemCount: result.length > 2
            ? 3
            : result.length > 1
                ? 2
                : result.length > 0
                    ? 1
                    : 0,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          final res = result![index];
          return Padding(
            padding:
                const EdgeInsets.only(left: 16, right: 16, top: 0, bottom: 20),
            child: Container(
                // height: 196,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: white,
                  borderRadius: BorderRadius.circular(10.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 0.2,
                      blurRadius: 0.6,
                      offset: Offset(0, 0.5), // changes position of shadow
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          // height: 29,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5.r),
                              border: Border.all(color: red)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              res.categories.toString() == ""
                                  ? " - "
                                  : res.categories.toString(),
                              style: TextStyle(
                                  color: red,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 10.sp),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Container(
                          height: 63,
                          child: Text(
                            res.title.toString() == ""
                                ? " - "
                                : res.title.toString(),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: blue4,
                                fontWeight: FontWeight.w500,
                                fontSize: 14),
                          ),
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 2.0),
                          child: Text(
                            res.userProfile!.nama.toString() == ""
                                ? " - "
                                : res.userProfile!.nama.toString(),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: neutral60,
                                fontWeight: FontWeight.bold,
                                fontSize: 12.sp),
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 2.0),
                          child: Text(
                            res.userProfile!.namaUniv.toString() == ""
                                ? " - "
                                : res.userProfile!.namaUniv.toString(),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: neutral30,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400),
                          ),
                        )
                      ],
                    ),
                  ),
                )),
          );
        },
      )),
      Padding(
        padding: EdgeInsets.only(left: 20.w, right: 13.w, bottom: 18.h),
        child: Text(
          "Informasi Terkait Kedaireka",
          style: TextStyle(
              fontSize: 20.sp, fontWeight: FontWeight.bold, color: blue3),
        ),
      ),
      bannerInformasiTerkait(context),
      Padding(
        padding: EdgeInsets.only(left: 16, right: 16, top: 24.h),
        child: bannerInformasi(context, idx),
      ),
      SizedBox(
        height: 50.h,
      ),
      // BtnDaftarSekarang(function: () {
      //   Navigator.push(
      //       context,
      //       MaterialPageRoute(
      //         builder: (context) => ShowWebsite(
      //           title: "Kedaireka",
      //           link:
      //               'https://kedaireka.id/registration?tab=insanperguruantinggi',
      //         ),
      //       ));
      // })
    ],
  );
}

class BtnDaftarSekarang extends StatelessWidget {
  final VoidCallback? function;

  const BtnDaftarSekarang({
    Key? key,
    required this.function,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: double.infinity,
      decoration: BoxDecoration(
        color: white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 5,
            blurRadius: 3,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16),
            child: Container(
              height: 48.sp,
              width: double.infinity,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: red,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.r))),
                  onPressed: function,
                  child: Text(
                    "Daftar Sekarang",
                    style: TextStyle(
                        color: white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14.sp),
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
