import 'package:app/presentation/component/SkeletonLoading.dart';
import 'package:app/presentation/component/pop_up_alert/dialog_alert.dart';
import 'package:app/presentation/pages/beranda/sivil/bloc/sivil_bloc.dart';
import 'package:app/presentation/pages/beranda/tracerStudy/bloc/kuesioner/kuesioner_bloc.dart';
import 'package:app/presentation/pages/beranda/tracerStudy/bloc/tracer_bloc.dart';
import 'package:app/presentation/pages/beranda/tracerStudy/kuesioner/kuesionerPage.dart';
import 'package:app/presentation/pages/beranda/tracerStudy/statistik/statistikTracerPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../component/constant.dart';
import '../../../../component/inkEffect.dart';
import 'package:app/injection.dart' as di;

Widget layanan(BuildContext context) {
  return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Pilih Layanan",
          style: TextStyle(
              color: blue3, fontWeight: FontWeight.w700, fontSize: 20.sp),
        ),
        SizedBox(
          height: 20.h,
        ),
        BlocProvider(
          create: (context) =>
              di.locator<TracerBloc>()..add(TracerConfigEvent(moduleId: 14)),
          child:
              BlocBuilder<TracerBloc, TracerState>(builder: ((context, state) {
            if (state is TracerConfigInitial) {
              return Column(
                children: [
                  SkeletonLoading(
                    width: double.infinity,
                    height: 100.h,
                    cornerRadius: 10.r,
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  SkeletonLoading(
                    width: double.infinity,
                    height: 100.h,
                    cornerRadius: 10.r,
                  ),
                ],
              );
            } else if (state is TracerConfigLoadingState) {
              return Column(
                children: [
                  SkeletonLoading(
                    width: double.infinity,
                    height: 100.h,
                    cornerRadius: 10.r,
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  SkeletonLoading(
                    width: double.infinity,
                    height: 100.h,
                    cornerRadius: 10.r,
                  ),
                ],
              );
            } else if (state is TracerConfigLoadedState) {
              return Column(
                children: [
                  cardLayanan(
                    "Isi Kuesioner",
                    "Program pengisian kuesioner untuk pendataan lulusan dari suatu perguruan tinggi.",
                    () {
                      if (state.config.data![1].value == "true") {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BlocProvider(
                                create: (context) =>
                                    di.locator<KuesionerTracerBloc>(),
                                child: KuesionerPage()),
                          ),
                        );
                      } else {
                        // TODO Dialog for holding Module
                        YYDialogModuleNotReady(
                            context,
                            "Kuesioner Belum Tersedia!",
                            "Mohon maaf modul ini belum tersedia dan masih dalam tahap pengembangan.");
                      }
                    },
                    Image.asset(
                      "assets/tracerStudy/ic_kuesioner.png",
                      width: 24.w,
                      height: 30.w,
                      fit: BoxFit.fill,
                      alignment: Alignment.center,
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  cardLayanan(
                    "Statistik",
                    "Temukan data perguruan tinggi berdasaran lulusan dari suatu perguruan tinggi.",
                    () {
                      if (state.config.data![0].value == "true") {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BlocProvider(
                              create: (context) => di.locator<SivilBloc>(),
                              child: StatistikTracer(),
                            ),
                          ),
                        );
                      } else {
                        // TODO Dialog for holding Module
                        YYDialogModuleNotReady(
                            context,
                            "Statistik Belum Tersedia!",
                            "Mohon maaf modul ini belum tersedia dan masih dalam tahap pengembangan.");
                      }
                    },
                    Image.asset(
                      "assets/tracerStudy/ic_statistik.png",
                      width: 28.w,
                      height: 28.w,
                      fit: BoxFit.fill,
                      alignment: Alignment.center,
                    ),
                  )
                ],
              );
            } else {
              return Text("Layanan masih dalam tahap pengembangan");
            }
          })),
        ),
      ]);
  // return Column(
  //   mainAxisAlignment: MainAxisAlignment.start,
  //   crossAxisAlignment: CrossAxisAlignment.start,
  //   children: [
  //     Text(
  //       "Pilih Layanan",
  //       style: TextStyle(
  //           color: blue3, fontWeight: FontWeight.w700, fontSize: 20.sp),
  //     ),
  //     SizedBox(
  //       height: 20.h,
  //     ),
  //     cardLayanan(
  //       "Isi Kuesioner",
  //       "Program pengisian kuesioner untuk pendataan lulusan dari suatu perguruan tinggi.",
  //       () {},
  //       Image.asset(
  //         "assets/tracerStudy/ic_kuesioner.png",
  //         width: 24.w,
  //         height: 30.w,
  //         fit: BoxFit.fill,
  //         alignment: Alignment.center,
  //       ),
  //     ),
  //     SizedBox(
  //       height: 20.h,
  //     ),
  //     cardLayanan(
  //       "Statistik",
  //       "Temukan data perguruan tinggi berdasaran lulusan dari suatu perguruan tinggi.",
  //       () {
  //         Navigator.push(
  //           context,
  //           MaterialPageRoute(
  //             builder: (context) => BlocProvider(
  //               create: (context) => di.locator<SivilBloc>(),
  //               child: StatistikTracer(),
  //             ),
  //           ),
  //         );
  //       },
  //       Image.asset(
  //         "assets/tracerStudy/ic_statistik.png",
  //         width: 28.w,
  //         height: 28.w,
  //         fit: BoxFit.fill,
  //         alignment: Alignment.center,
  //       ),
  //     ),
  //   ],
  // );
}

Widget cardLayanan(
    String title, String subTitle, VoidCallback onTap, Widget centerImage) {
  return InkEffect(
    onTap: onTap,
    boxDecoration:
        BoxDecoration(color: white, borderRadius: BorderRadius.circular(10.r)),
    child: Padding(
      padding: EdgeInsets.all(20.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 64.h,
            height: 64.h,
            decoration: BoxDecoration(
              color: Color(0xffF8F9FD),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Center(child: centerImage),
          ),
          SizedBox(
            width: 20.w,
          ),
          Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                      color: blue4,
                      fontWeight: FontWeight.w700,
                      fontSize: 14.sp),
                ),
                SizedBox(
                  width: 6.h,
                ),
                Text(
                  subTitle,
                  style: TextStyle(
                      color: teksAbuCerah4,
                      fontWeight: FontWeight.w400,
                      fontSize: 12.sp,
                      letterSpacing: 0.5),
                ),
              ],
            ),
          )
        ],
      ),
    ),
  );
}

Widget cardLayananDisable(
    String title, String subTitle, VoidCallback onTap, Widget centerImage) {
  return InkEffect(
    onTap: onTap,
    boxDecoration:
        BoxDecoration(color: white, borderRadius: BorderRadius.circular(10.r)),
    child: Stack(children: [
      Padding(
        padding: EdgeInsets.all(20.w),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 64.h,
                height: 64.h,
                decoration: BoxDecoration(
                  color: Color(0xffF8F9FD),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Center(child: centerImage),
              ),
              SizedBox(
                width: 20.w,
              ),
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                          color: blue4,
                          fontWeight: FontWeight.w700,
                          fontSize: 14.sp),
                    ),
                    SizedBox(
                      width: 6.h,
                    ),
                    Text(
                      subTitle,
                      style: TextStyle(
                          color: teksAbuCerah4,
                          fontWeight: FontWeight.w400,
                          fontSize: 12.sp,
                          letterSpacing: 0.5),
                    ),
                  ],
                ),
              ),
            ]),
      ),
      Container(
        padding: EdgeInsets.all(52.w),
        decoration: BoxDecoration(
            color: Color(0x66B3B3B3),
            borderRadius: BorderRadius.circular(10.r)),
      )
    ]),
  );
}
