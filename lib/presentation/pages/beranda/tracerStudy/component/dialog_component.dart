// ignore_for_file: non_constant_identifier_names

import 'package:app/presentation/component/constant.dart';
import 'package:app/injection.dart' as di;
import 'package:app/presentation/pages/beranda/sivil/bloc/sivil_bloc.dart';
import 'package:app/presentation/pages/beranda/tracerStudy/bloc/bottom_sheet_form/bottom_sheet_form_bloc.dart';
import 'package:app/presentation/pages/beranda/tracerStudy/bloc/pencarian_bloc/pencarian_kabupaten_bloc/pencarian_kabupaten_bloc.dart';
import 'package:app/presentation/pages/beranda/tracerStudy/bloc/pencarian_bloc/pencarian_prodi_bloc/pencarian_prodi_bloc.dart';
import 'package:app/presentation/pages/beranda/tracerStudy/bloc/pencarian_bloc/pencarian_pt_bloc/pencarian_pt_bloc.dart';
import 'package:app/presentation/pages/beranda/tracerStudy/bloc/pencarian_spesifik_bloc/pencarian_spesifik_bloc.dart';
import 'package:app/presentation/pages/beranda/tracerStudy/bloc/post_store_bloc/post_store_bloc.dart';
import 'package:app/presentation/pages/beranda/tracerStudy/component/buttom_sheet_form/bottom_sheet_provinsi/bloc/bts_provinsi_bloc.dart';
import 'package:app/presentation/pages/beranda/tracerStudy/hasilpengisiankuesioner_page.dart';
import 'package:app/presentation/pages/beranda/tracerStudy/tracer_study_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_custom_dialog/flutter_custom_dialog.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../bloc/kuesioner/kuesioner_bloc.dart';
import '../bloc/kuesioner/kuesioner_event.dart';
import '../kuesioner/pages/kuesionerIdentitas.dart';
import '../kuesioner/pages/kuesionerPage/kuesioner_wajib_page.dart';

YYDialog YYDialogSuccess(
  BuildContext context,
  List<TextEditingController> controller,
  String alumniId,
  String nim,
  String tahunLulus,
  String nama,
  String kodePt,
  String kodeProdi,
  String nik,
) {
  return YYDialog().build(context)
    ..width = 340.w
    ..height = 231.h
    ..backgroundColor = whiteBgPage
    ..borderRadius = 10.0
    ..showCallBack = () {
      print("showCallBack invoke");
    }
    ..barrierDismissible = false
    ..widget(Padding(
      padding: EdgeInsets.only(top: 20.h),
      child: Image.asset(
        'assets/tracerStudy/icon_success.png',
        width: 62.w,
        height: 62.h,
      ),
    ))
    ..widget(Padding(
      padding: EdgeInsets.only(top: 16.h),
      child: Text(
        "Validasi Data Berhasil!",
        style: TextStyle(
            fontSize: 16.sp, color: neutral90, fontWeight: FontWeight.w600),
      ),
    ))
    ..widget(Padding(
      padding: EdgeInsets.only(top: 8.h),
      child: Text(
        "Data telah ditemukan",
        style: TextStyle(
            fontSize: 14.sp, color: neutral60, fontWeight: FontWeight.w500),
      ),
    ))
    ..widget(Padding(
      padding: EdgeInsets.only(top: 16.h),
      child: GestureDetector(
        onTap: () {
          Navigator.pop(context);
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => KuesionerIdentitas(
                        result: controller,
                        kodeProdi: kodeProdi,
                        kodePt: kodePt,
                        nama: nama,
                        nik: nik,
                        nim: nim,
                        tahunLulus: tahunLulus,
                        alumniId: alumniId,
                      )));
        },
        child: Container(
          // width: 129.w,
          height: 48.h,
          margin: EdgeInsets.fromLTRB(16, 0, 16, 0),
          decoration: BoxDecoration(
              color: biruMuda2, borderRadius: BorderRadius.circular(8.r)),
          child: Center(
            child: Text(
              "Selanjutnya",
              style: TextStyle(
                  fontSize: 16.sp, color: white, fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ),
    ))
    ..animatedFunc = (child, animation) {
      return ScaleTransition(
        child: child,
        scale: Tween(begin: 0.0, end: 1.0).animate(animation),
      );
    }
    ..show();
}

YYDialog YYDialogLoading(
  BuildContext context,
) {
  return YYDialog().build(context)
    ..width = 120.w
    ..height = 120.h
    ..backgroundColor = whiteBgPage
    ..borderRadius = 10.0
    ..showCallBack = () {
      print("showCallBack invoke");
    }
    ..widget(Padding(
      padding: EdgeInsets.only(top: 40.h),
      child: CircularProgressIndicator(
        color: blue4,
      ),
    ))
    // ..widget(Padding(
    //   padding: EdgeInsets.only(top: 16.h),
    //   child: Text(
    //     "Terima Kasih",
    //     style: TextStyle(
    //         fontSize: 18.sp, color: neutral90, fontWeight: FontWeight.w700),
    //   ),
    // ))
    // ..widget(Padding(
    //   padding: EdgeInsets.only(top: 8.h),
    //   child: Text(
    //     "Loading",
    //     style: TextStyle(
    //         fontSize: 14.sp, color: neutral60, fontWeight: FontWeight.w500),
    //   ),
    // ))
    ..animatedFunc = (child, animation) {
      return ScaleTransition(
        child: child,
        scale: Tween(begin: 0.0, end: 1.0).animate(animation),
      );
    }
    ..show();
}

YYDialog YYDialogFinishKuesioner(
  BuildContext context,
  final String alumniId,
) {
  return YYDialog().build(context)
    ..width = 340.w
    ..height = 290.h
    ..backgroundColor = whiteBgPage
    ..borderRadius = 10.0
    ..showCallBack = () {
      print("showCallBack invoke");
    }
    ..barrierDismissible = false
    ..widget(Padding(
      padding: EdgeInsets.only(top: 12.h),
      child: Image.asset(
        'assets/tracerStudy/icon_success.png',
        width: 62.w,
        height: 62.h,
      ),
    ))
    ..widget(Padding(
      padding: EdgeInsets.only(top: 16.h),
      child: Text(
        "Terima Kasih Telah Mengisi Kuesioner",
        style: TextStyle(
            fontSize: 18.sp, color: neutral90, fontWeight: FontWeight.w700),
      ),
    ))
    ..widget(Padding(
      padding: EdgeInsets.only(top: 8.h, left: 16.h, right: 16.h),
      child: Text(
        "Jawaban Anda telah direkam. Anda dapat melihat hasil pengisian kuesioner Anda.",
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: 14.sp, color: neutral60, fontWeight: FontWeight.w500),
      ),
    ))
    ..widget(Padding(
      padding: EdgeInsets.all(16.h),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => BlocProvider(
                        create: (context) => di.locator<KuesionerTracerBloc>()
                          ..add(GetAnswer(id: alumniId)),
                        child: HasilPengisianKuesionerPage(),
                      )));

          // Navigator.pop(context);
          // Navigator.push(
          //     context,
          //     MaterialPageRoute(
          //         builder: (context) => BlocProvider(
          //               create: (context) => di.locator<KuesionerTracerBloc>(),
          //               child: HasilPengisianKuesionerPage(state: state),
          //             )));
        },
        child: Container(
          width: 311.w,
          height: 48.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.r),
            color: blue4,
          ),
          child: Center(
            child: Text(
              'Lihat hasil kuesioner',
              style: TextStyle(
                color: white,
                fontWeight: FontWeight.w600,
                fontSize: 16.sp,
              ),
            ),
          ),
        ),
      ),
    ))
    ..widget(Padding(
      padding: EdgeInsets.only(top: 6.h),
      child: GestureDetector(
        onTap: () {
          Navigator.pop(context);
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => TracerStudyPage()),
            (Route<dynamic> route) => false,
          );
        },
        child: Container(
          child: Center(
            child: Text(
              "Kembali",
              style: TextStyle(
                  fontSize: 16.sp, color: blue4, fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ),
    ))
    ..animatedFunc = (child, animation) {
      return ScaleTransition(
        child: child,
        scale: Tween(begin: 0.0, end: 1.0).animate(animation),
      );
    }
    ..show();
}

YYDialog YYDialogFinish(BuildContext context, String alumniId) {
  return YYDialog().build(context)
    ..width = 340.w
    ..height = 300.h
    ..backgroundColor = whiteBgPage
    ..borderRadius = 10.0
    ..showCallBack = () {
      print("showCallBack invoke");
    }
    ..barrierDismissible = false
    ..widget(Padding(
      padding: EdgeInsets.only(top: 20.h),
      child: Image.asset(
        'assets/tracerStudy/icon_success.png',
        width: 62.w,
        height: 62.h,
      ),
    ))
    ..widget(Padding(
      padding: EdgeInsets.only(top: 16.h),
      child: Text(
        "Anda Sudah Mengisi Kuesioner",
        style: TextStyle(
            fontSize: 16.sp, color: neutral90, fontWeight: FontWeight.w600),
      ),
    ))
    ..widget(Padding(
      padding: EdgeInsets.only(top: 8.h),
      child: Text(
        "Anda dapat melihat hasil pengisian kuesioner",
        style: TextStyle(
            fontSize: 14.sp, color: neutral60, fontWeight: FontWeight.w500),
      ),
    ))
    ..widget(Padding(
      padding: EdgeInsets.all(16.h),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => BlocProvider(
                        create: (context) => di.locator<KuesionerTracerBloc>()
                          ..add(GetAnswer(id: alumniId)),
                        child: HasilPengisianKuesionerPage(),
                      )));
          // Navigator.pop(context);
          // Navigator.push(
          //     context,
          //     MaterialPageRoute(
          //         builder: (context) => BlocProvider(
          //               create: (context) => di.locator<KuesionerTracerBloc>(),
          //               child: HasilPengisianKuesionerPage(state: state),
          //             )));
          // Navigator.push(
          //     context,
          //     MaterialPageRoute(
          //         builder: (context) => HasilPengisianKuesionerPage(
          //               state: state,
          //             )));
        },
        child: Container(
          width: 311.w,
          height: 48.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.r),
            color: blue4,
          ),
          child: Center(
            child: Text(
              'Lihat hasil kuesioner',
              style: TextStyle(
                color: white,
                fontWeight: FontWeight.w600,
                fontSize: 16.sp,
              ),
            ),
          ),
        ),
      ),
    ))
    ..widget(Padding(
      padding: EdgeInsets.only(top: 6.h),
      child: GestureDetector(
        onTap: () {
          Navigator.pop(context);
          // Navigator.pushAndRemoveUntil(
          //   context,
          //   MaterialPageRoute(builder: (context) => TracerStudyPage()),
          //   (Route<dynamic> route) => false,
          // );
        },
        child: Container(
          child: Center(
            child: Text(
              "Kembali",
              style: TextStyle(
                  fontSize: 16.sp, color: blue4, fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ),
    ))
    ..animatedFunc = (child, animation) {
      return ScaleTransition(
        child: child,
        scale: Tween(begin: 0.0, end: 1.0).animate(animation),
      );
    }
    ..show();
}

YYDialog YYDialogLanjutKuesioner(
  BuildContext context,
  String alumniId,
  int page,
  String kodeProdi,
  String kodePt,
  String nik,
  String nim,
) {
  return YYDialog().build(context)
    ..width = 358.w
    ..height = 340.h
    ..backgroundColor = whiteBgPage
    ..borderRadius = 10.0
    ..showCallBack = () {
      print("showCallBack invoke");
    }
    ..barrierDismissible = false
    ..widget(Padding(
      padding: EdgeInsets.only(top: 24.h),
      child: Image.asset(
        'assets/tracerStudy/icon_kuesioner.png',
        width: 62.w,
        height: 62.h,
      ),
    ))
    ..widget(Padding(
      padding: EdgeInsets.only(top: 16.h),
      child: Text(
        "Lanjut, Kuesioner Wajib",
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: 18.sp, color: neutral90, fontWeight: FontWeight.w700),
      ),
    ))
    ..widget(Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
      child: Text(
        "Selanjutnya anda akan mengisi kuesioner yang terdiri atas 21 pertanyaan. Apakah anda ingin lanjut?",
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: 14.sp,
            color: neutral60,
            fontWeight: FontWeight.w500,
            height: 1.65.sp),
      ),
    ))
    ..widget(Padding(
        padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return MultiBlocProvider(
                        providers: [
                          BlocProvider(
                              create: (context) =>
                                  di.locator<PostStoreAnswerTracerBloc>()),
                          BlocProvider(
                            create: (context) =>
                                di.locator<KuesionerTracerBloc>()
                                  ..add(GetKuesionerTracerEvent(1)),
                          ),
                          BlocProvider(
                              create: (context) =>
                                  di.locator<PencarianKabupatenTracerBloc>()),
                          BlocProvider(
                              create: (context) =>
                                  di.locator<PencarianPtTracerBloc>()),
                          BlocProvider(
                              create: (context) =>
                                  di.locator<PencarianProdiTracerBloc>()),
                          BlocProvider(
                              create: (context) =>
                                  di.locator<PencarianSpesifikTracerBloc>()
                                    ..add(InitPencarianSpesifikEvent())),
                          BlocProvider(
                            create: (context) =>
                                di.locator<BottomSheetFormTracerBloc>()
                                  ..add(ClearTracerEvent()),
                          ),
                          BlocProvider(
                            create: (context) =>
                                di.locator<BtsTracerProvinsiBloc>(),
                          ),
                          BlocProvider(
                            create: (context) =>
                                di.locator<SivilBloc>()..add(ClearEvent()),
                          ),
                        ],
                        child: KuesionerWajibPage(
                          answer: null,
                          alumniId: alumniId,
                        ));
                  }
                      // BlocProvider(
                      //     create: (context) => di.locator<KuesionerTracerBloc>()
                      //       ..add(GetKuesionerTracerEvent(1)),
                      //     child: KuesionerWajibPage()),
                      ),
                );

                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context)=> KuesionerWajibPage(kuesioner: kuesioner, maxPage: maxPages, page: page,)
                //   )
                // );
              },
              child: Container(
                width: 311.w,
                height: 48.h,
                decoration: BoxDecoration(
                  color: blue4,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Center(
                  child: Text(
                    "Lanjut",
                    style: TextStyle(
                        fontSize: 16.sp,
                        color: white,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 16.h,
            ),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                // width: 155.w,
                // height: 48.h,
                child: Center(
                  child: Text(
                    "Kembali",
                    style: TextStyle(
                        fontSize: 16.sp,
                        color: biruMuda2,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ),
          ],
        )))
    ..animatedFunc = (child, animation) {
      return ScaleTransition(
        child: child,
        scale: Tween(begin: 0.0, end: 1.0).animate(animation),
      );
    }
    ..show();
}

YYDialog YYDialogWarningFieldEmpty(
  BuildContext context,
  String hintText,
) {
  return YYDialog().build(context)
    ..width = 340.w
    ..height = 260.h
    ..backgroundColor = whiteBgPage
    ..borderRadius = 10.0
    ..showCallBack = () {
      print("showCallBack invoke");
    }
    ..barrierDismissible = false
    ..widget(Padding(
      padding: EdgeInsets.only(top: 16.h),
      child: Image.asset(
        'assets/tracerStudy/icon_danger.png',
        width: 62.w,
        height: 62.h,
      ),
    ))
    ..widget(Padding(
      padding: EdgeInsets.only(top: 16.h, left: 16.w, right: 16.w),
      child: Text(
        "Ups, $hintText Kosong!",
        style: TextStyle(
            fontSize: 18.sp, color: neutral90, fontWeight: FontWeight.w700),
        textAlign: TextAlign.center,
      ),
    ))
    ..widget(Padding(
      padding: EdgeInsets.only(top: 18.h, left: 20.w, right: 20.w),
      child: Text(
        "Silahkan anda isi kolom $hintText terlebih dahulu",
        style: TextStyle(
            fontSize: 14.sp, color: neutral60, fontWeight: FontWeight.w500),
        textAlign: TextAlign.center,
      ),
    ))
    ..widget(Padding(
      padding: EdgeInsets.symmetric(vertical: 16.h),
      child: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Container(
          width: 311.w,
          height: 48.h,
          decoration: BoxDecoration(
              color: blue4, borderRadius: BorderRadius.circular(8.r)),
          child: Center(
            child: Text(
              "Kembali",
              style: TextStyle(
                  fontSize: 16.sp, color: white, fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ),
    ))
    ..animatedFunc = (child, animation) {
      return ScaleTransition(
        child: child,
        scale: Tween(begin: 0.0, end: 1.0).animate(animation),
      );
    }
    ..show();
}

YYDialog YYDialogValidasiFailed(
  BuildContext context,
  String hintTextTitle,
  String hintText,
) {
  return YYDialog().build(context)
    ..width = 358.w
    ..height = 262.h
    ..backgroundColor = whiteBgPage
    ..borderRadius = 10.0
    ..showCallBack = () {
      print("showCallBack invoke");
    }
    ..barrierDismissible = false
    ..widget(Padding(
      padding: EdgeInsets.only(top: 16.h),
      child: Image.asset(
        'assets/tracerStudy/ic_validasi_failure.png',
        width: 62.w,
        height: 62.h,
      ),
    ))
    ..widget(Padding(
      padding: EdgeInsets.only(top: 16.h),
      child: Text(
        "$hintTextTitle",
        style: TextStyle(
            fontSize: 18.sp, color: neutral90, fontWeight: FontWeight.w700),
        textAlign: TextAlign.center,
      ),
    ))
    ..widget(Padding(
      padding: EdgeInsets.only(top: 16.h, left: 22.w, right: 22.w),
      child: Text(
        hintText,
        style: TextStyle(
            fontSize: 14.sp, color: neutral60, fontWeight: FontWeight.w500),
        textAlign: TextAlign.center,
      ),
    ))
    ..widget(Padding(
      padding: EdgeInsets.only(top: 27.h),
      child: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Container(
          width: 311.w,
          height: 48.h,
          decoration: BoxDecoration(
              color: blue4, borderRadius: BorderRadius.circular(8.r)),
          child: Center(
            child: Text(
              "Kembali",
              style: TextStyle(
                  fontSize: 16.sp, color: white, fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ),
    ))
    ..animatedFunc = (child, animation) {
      return ScaleTransition(
        child: child,
        scale: Tween(begin: 0.0, end: 1.0).animate(animation),
      );
    }
    ..show();
}
