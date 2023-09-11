// import 'package:app/presentation/pages/mainPage.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:percent_indicator/circular_percent_indicator.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:smooth_page_indicator/smooth_page_indicator.dart';

// import '../../../data/source/remote/model/faq/faqList.dart';
// import '../../component/constant.dart';

// class OnBoardingDua extends StatefulWidget {
//   final FAQList listFAQ;
//   const OnBoardingDua({Key? key, required this.listFAQ}) : super(key: key);

//   @override
//   State<OnBoardingDua> createState() => _OnBoardingDuaState();
// }

// class _OnBoardingDuaState extends State<OnBoardingDua> {
//   int slide = 0;
//   bool halIndex = true;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           mainAxisSize: MainAxisSize.max,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             halIndex ?
//             GestureDetector(
//                 onHorizontalDragUpdate: (details){
//                   if(details.delta.dx < 0){
//                     setState(() {
//                       slide = 1;
//                       halIndex = false;
//                     });
//                   }
//                 },
//                 child:
//             Column(
//               mainAxisAlignment: MainAxisAlignment.start,
//               mainAxisSize: MainAxisSize.max,
//               crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     Image.asset('assets/onboarding2_batch4.png', width: 283.w, height: 356.h,),
//                     SizedBox(height: 45.h,),
//                     Text('Satu Aplikasi untuk Semua', style: TextStyle(
//                       fontSize: 20.sp,
//                       letterSpacing: -0.017,
//                       height: 1.5,
//                       fontWeight: FontWeight.w700,
//                       color: blue3,
//                     )),
//                     SizedBox(height: 8.h,),
//                     SizedBox(
//                       width: 320.w,
//                       child:
//                       Text(
//                         'Mahasiswa, dosen, tendik, hingga masyarakat\n umum bisa mengakses Satudikti.',
//                         style: TextStyle(
//                           fontWeight: FontWeight.w400,
//                           fontSize: 14.sp,
//                           height: 2,
//                           letterSpacing: -0.006,
//                           color: neutral70,
//                         ),
//                         textAlign: TextAlign.center,),
//                     )
//                   ],
//                 )) :
//             GestureDetector(
//                 onHorizontalDragUpdate: (details){
//                   if(details.delta.dx > 0){
//                     setState(() {
//                       slide = 0;
//                       halIndex = true;
//                     });
//                   }
//                 },
//                 child:
//             Column(
//               mainAxisAlignment: MainAxisAlignment.start,
//               mainAxisSize: MainAxisSize.max,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                   Image.asset('assets/onboarding3_batch4.png', width: 350.w, height: 356.h,),
//                   SizedBox(height: 16.5.h,),
//                   Text('Mudah, Cepat dan Akurat', style: TextStyle(
//                     fontSize: 20.sp,
//                     letterSpacing: -0.017,
//                     height: 1.5,
//                     fontWeight: FontWeight.w700,
//                     color: blue3,
//                   )),
//                   SizedBox(height: 8.h,),
//                   SizedBox(
//                     width: 320.w,
//                     child:
//                     Text(
//                       'Akses berbagai layanan dan informasi terkini\n seputar Pendidikan Tinggi, lewat Satudikti.',
//                       style: TextStyle(
//                         fontWeight: FontWeight.w500,
//                         fontSize: 14.sp,
//                         height: 2,
//                         letterSpacing: -0.006,
//                         color: neutral70,
//                       ),
//                       textAlign: TextAlign.center,),
//                   ),

//                 ],)),
//             SizedBox(height: 53.57.h,),
//             sliderIndicator(),
//             SizedBox(height: 50.h,),
//             Padding(padding: EdgeInsets.symmetric(horizontal: 25),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   GestureDetector(
//                     onTap: () {
//                       Navigator.pushReplacement(
//                           context,
//                           PageRouteBuilder(
//                             transitionDuration: Duration(
//                               seconds: 1,
//                             ),
//                             pageBuilder: (context, animation, animationTime) {
//                               return MainPage(
//                                 listFAQ: widget.listFAQ,
//                                 statusCode: 200,
//                               );
//                             },
//                             transitionsBuilder:
//                                 (context, animation, secondaryAnimation, child) {
//                               return FadeTransition(
//                                 opacity: animation,
//                                 child: child,
//                               );
//                             },
//                           ));
//                     },
//                     child: Text('Skip', style: TextStyle(
//                         fontSize: 14.sp,
//                         fontWeight: FontWeight.w700,
//                         color: neutral30,
//                         letterSpacing: -0.006
//                     ),),
//                   ),
//                   Spacer(),
//                   CircularPercentIndicator(
//                     radius: 27,
//                     backgroundWidth: 0,
//                     lineWidth: 2.5,
//                     percent: halIndex ? 0.5 : 1,
//                     progressColor: blueLinear1,
//                     center:
//                     ElevatedButton(
//                       onPressed: () async{
//                         final prefs = await SharedPreferences.getInstance();
//                         setState(() {
//                           slide += 1;
//                           halIndex = false;
//                           prefs.setBool("onBoarding", false);
//                         });
//                         if(slide == 2) {
//                           Navigator.pushReplacement(
//                               context,
//                               PageRouteBuilder(
//                                 transitionDuration: Duration(
//                                   seconds: 1,
//                                 ),
//                                 pageBuilder: (context, animation, animationTime) {
//                                   return MainPage(
//                                     listFAQ: widget.listFAQ,
//                                     statusCode: 200,
//                                   );
//                                 },
//                                 transitionsBuilder:
//                                     (context, animation, secondaryAnimation, child) {
//                                   return FadeTransition(
//                                     opacity: animation,
//                                     child: child,
//                                   );
//                                 },
//                               ));
//                         }
//                       },
//                       style: ElevatedButton.styleFrom(
//                           padding: EdgeInsets.zero,
//                           shape: CircleBorder()
//                       ),
//                       child: Ink(
//                         decoration: BoxDecoration(
//                             gradient: appBarGradient,
//                             shape: BoxShape.circle),
//                         child: Container(
//                           width: 44.w,
//                           height: 44.h,
//                           alignment: Alignment.center,
//                           child: Icon(
//                             Icons.arrow_forward,
//                             color: white,),
//                         ),
//                       ),
//                     ),)
//                 ],),)
//           ],
//         ),
//       ),
//     );
//   }

//   Widget sliderIndicator() => AnimatedSmoothIndicator(
//     activeIndex: slide,
//     count: 2,
//     effect: ExpandingDotsEffect(
//       spacing: 16.0,
//       radius: 100.0,
//       dotWidth: 8.0,
//       dotHeight: 8.0,
//       strokeWidth: 1.5,
//       dotColor: neutral40,
//       activeDotColor: blue3,
//   )
//   );
// }
