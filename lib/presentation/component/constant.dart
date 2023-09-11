//konstanta
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

//apus ganti make .h/.w
double screenHeight(BuildContext context) => MediaQuery.of(context).size.height;
double screenWidth(BuildContext context) => MediaQuery.of(context).size.width;
double screenArea(BuildContext context) =>
    MediaQuery.of(context).size.width * MediaQuery.of(context).size.height;

// Flutter Hex Code Opacity Setting
// ==================================
// 100% — FF
// 95% — F2
// 90% — E6
// 85% — D9
// 80% — CC
// 75% — BF
// 70% — B3
// 65% — A6
// 60% — 99
// 55% — 8C
// 50% — 80
// 45% — 73
// 40% — 66
// 35% — 59
// 30% — 4D
// 25% — 40
// 20% — 33
// 15% — 26
// 10% — 1A
// 5% — 0D
// 0% — 00

// Primary and Secondary Colors
// const Color blueLinear1 = Color(0xFF2D3748)
const Color blueLinear1 = Color(0xff116CB7);
const Color blueLinear2 = Color(0xff27409C);
const Color blue2 = Color(0xff1A689E);
const Color blue3 = Color(0xff254A71);
const Color blue4 = Color(0xff248DDA);
const Color blue5 = Color(0xff3652B5);
const Color blue6 = Color(0x1A1A689E); //Blue2 with 10% opactiy

// Background Colors
const Color white = Colors.white;
const Color bgPelajariSelengkapnya = Color(0x66FFFFFF);
const Color whiteBgPage = Color(0xffF9FAFE);
const Color greenBackground = Color(0x1A1A9E4A);
const Color shadow = Color(0x33292929);
const Color neutralBackground = Color(0xffF5F7FF);
const Color blueBackground = Color(0x1A1A689E);

// Neutral Colors
const Color neutral100 = Colors.black;
const Color neutral90 = Color(0xff191919);
const Color neutral80 = Color(0xff333333);
const Color neutral70 = Color(0xff4D4D4D);
const Color neutral60 = Color(0xff666666);
const Color neutral50 = Color(0xff808080);
const Color neutral40 = Color(0xff999999);
const Color neutral30 = Color(0xffB3B3B3);
const Color neutral20 = Color(0xffCCCCCC);
const Color neutral10 = Color(0xffE6E6E6);
const Color neutralCaption = Color(0xff6D727F);

// Buttons and Contrast Colors
const Color green = Color(0xff9EDE73);
const Color red = Color(0xffF66951);
const Color yellow = Color(0xffF7EA00);
const Color yellowStatusColor = Color(0xffF0D805);
const Color yellowStatusColor20 = Color(0xFFFFD052);
const Color alert10 = Color(0xFFDB3232);

// Miscs Colors - Primary and Secondary
Color biruTua10 = Color(0xff3674B9);
Color biruTua3 = Color(0xff2C389E);
Color biruTua8 = Color(0xff274BA3);
Color biruTua11 = Color(0xff2779C5);
Color biruTua12 = Color(0xff09AEE2);

Color biruMuda2 = Color(0xFF248DDA);
Color biruMuda1 = Color(0xff00CBF7);
Color biruMuda3 = Color(0xffE0F2FE);
Color biruMuda4 = Color(0xffE5F4FF);
Color biruMuda5 = Color(0xffF2F4FA);

// Miscs Colors - Neutrals
const Color abu = Color(0xffC4C4C4);
const Color abu2 = Color(0xffCBCACC);
const Color abu5 = Color(0xfff6f6f6);
const Color abu6 = Color(0xffC5C5C5);
const Color abu7 = Color(0xff1F1D1E);
const Color abu8 = Color(0xffD1CFD7);
const Color abuCerah = Color(0xffF8F9FD);
const Color teksAbu = Color(0xffA9A9A9);
const Color teksAbuCerah4 = Color(0xff9B9B9B);
const Color buttonDisable = Color(0xffE9EDF1);
const Color textButtonDisable = Color(0xffA3A3A3);
const Color informationCardColor = Color(0xffFFF1D5);

// Miscs Colors - Contrasts
const Color green2 = Color(0xffB3FF80);
const Color green3 = Color(0xff00BE82);
const Color green4 = Color(0xff9BD70);
const Color green5 = Color(0xff73DEB1);
const Color green6 = Color(0x1A00BE82);
const Color red2 = Color(0xffE34B31);
const Color red3 = Color(0xffFF6C53);
const Color red4 = Color(0xffFFE5E0);
const Color redDark = Color(0xffCD6767);
const Color lightRed = Color(0xffFF7C7C);
const Color yellow2 = Color(0xfff4d462);
const Color yellow3 = Color(0xffFFF48F);

Color orange = Color(0xffFBC224);
Color orange2 = Color(0xffFFB94F);
Color orange3 = Color(0x99F79400);
Color orangeCardStatus = Color(0xffF7AD2B);

//redesign
Color selectedLabelColor = blue3;
Color unselectedLabelColor = white;
//used for text, border, and num bg
Color selectedTextColor = white;
Color unselectedTextColor = neutral30;

// Shadows
List<BoxShadow>? shadow1 = [
  BoxShadow(
    color: Color.fromRGBO(151, 151, 151, 0.08),
    blurRadius: 15.sp,
    offset: Offset(0, 4.sp),
  )
];

List<BoxShadow>? shadow2 = [
  BoxShadow(
    color: Color.fromRGBO(85, 85, 85, 0.05),
    blurRadius: 10.sp,
    offset: Offset(0, 10.sp),
  )
];

List<BoxShadow>? shadow3 = [
  BoxShadow(
    color: Color.fromRGBO(0, 0, 0, 0.04),
    blurRadius: 4.0,
    offset: Offset(0, 2),
  )
];
// Shadows

// Gradients
LinearGradient appBarGradient = LinearGradient(
  colors: [blueLinear1, blueLinear2],
  begin: Alignment.centerLeft,
  end: Alignment.centerRight,
);

LinearGradient splashGradient = LinearGradient(
  colors: [blueLinear1, blueLinear2],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);

LinearGradient beasiswaBgGradient = LinearGradient(
  colors: [blueLinear1, blueLinear1, blueLinear2],
  begin: Alignment.topLeft,
  end: Alignment.bottomCenter,
  stops: [0, 0.11, 0.65],
);

LinearGradient berandaBgGradient = LinearGradient(
  colors: [blueLinear1, blueLinear1, blueLinear2],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  stops: [0, 0.11, 0.57],
);

LinearGradient berandaCarouselGradient = LinearGradient(
  colors: [blue4, blue5],
  begin: Alignment.centerLeft,
  end: Alignment.centerRight,
);

LinearGradient berandaHubungiButtonGradient = LinearGradient(
  colors: [biruTua10, biruTua8],
  begin: Alignment.centerLeft,
  end: Alignment.centerRight,
);

LinearGradient kompdosHubungiButtonGradient = LinearGradient(
  colors: [blue4, blue5],
  begin: Alignment.centerLeft,
  end: Alignment.centerRight,
);

LinearGradient sliverBgGradient = LinearGradient(
  colors: [blueLinear1, blueLinear1, blueLinear2],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  stops: [0.1, 0.13, 0.35],
);

LinearGradient kedairekaButtonBgGradient = LinearGradient(
  colors: [red, red2],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  stops: [0.0, 1.0],
);

LinearGradient kedairekaInformasiBgGradient = LinearGradient(
  colors: [Color(0xFF116CB7), Color(0xFF27409C)],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  stops: [0.0, 1.0],
);

LinearGradient pelajariSelengkapnyaBgGradient = LinearGradient(
  colors: [Color(0x1a3652b5), Color(0x1af0992d)],
  begin: Alignment.centerLeft,
  end: Alignment.centerRight,
);

LinearGradient acceptedPAKGradient = LinearGradient(
  colors: [Color(0xffE0FFCB), Color(0xffDAFFC1)],
  begin: Alignment.bottomLeft,
  end: Alignment.topRight,
);

LinearGradient sintaKunjungiWebsiteBgGradient = LinearGradient(
  colors: [blue4, blue5],
  begin: Alignment.centerLeft,
  end: Alignment.centerRight,
);

LinearGradient tentangSatuDiktiBgGradient = LinearGradient(
    colors: [biruTua11.withOpacity(0.1), biruTua12.withOpacity(0.1)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight);

LinearGradient pengumumanDetailLinearGradient = LinearGradient(
  colors: [Color(0xffA7D5FF), Color(0xffC2DEFF)],
  begin: Alignment.centerLeft,
  end: Alignment.centerRight,
);

LinearGradient dataTidakDitemukanPDDikti = LinearGradient(
  colors: [Color(0XFFEAE8F8), Color(0XFFE9E7F4)],
  begin: Alignment.centerLeft,
  end: Alignment.centerRight,
);

LinearGradient bimaNomorSurat = LinearGradient(
  colors: [Color.fromRGBO(232, 237, 241, 1), Color.fromRGBO(245, 247, 249, 1)],
  begin: Alignment.centerLeft,
  end: Alignment.centerRight,
);

LinearGradient bimaCategoryDikti = LinearGradient(
  colors: [Color.fromRGBO(208, 233, 251, 1), Color.fromRGBO(232, 244, 253, 1)],
  begin: Alignment.centerLeft,
  end: Alignment.centerRight,
);

LinearGradient bimaCategoryDiksi = LinearGradient(
  colors: [Color.fromRGBO(215, 234, 217, 1), Color.fromRGBO(235, 244, 236, 1)],
  begin: Alignment.centerLeft,
  end: Alignment.centerRight,
);

LinearGradient gmagzPelajariSelengkapnyaBgGradient = LinearGradient(
  colors: [Color(0x1A28459C), Color(0x1A5EBDF3)],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  stops: [0.0, 1.0],
);

// Gradients

// Text Styles
TextStyle stylePelajariSelengkapnya =
    TextStyle(color: white, fontSize: 14.sp, fontWeight: FontWeight.w500);

TextStyle styleKMParagraph = TextStyle(
  fontSize: 16.sp,
  height: 1.75.sp,
  letterSpacing: 0.5.sp,
);

final TextStyle textStyleParagraph = TextStyle(
  fontSize: 16.sp,
  height: 1.75.sp,
  letterSpacing: 0.5.sp,
  color: abu7,
);

final TextStyle textStyleSmallParagraph = TextStyle(
  fontSize: 12.sp,
  letterSpacing: 0.5.sp,
  color: neutral30,
);

TextStyle styleSubJudul = TextStyle(
  color: blue3,
  fontSize: 20.sp,
  fontWeight: FontWeight.bold,
);

TextStyle styleSubJudul2 = TextStyle(
  fontSize: 14.sp,
  fontWeight: FontWeight.w400,
  color: neutral50,
);

TextStyle styleSubJudul2Medium = TextStyle(
  fontSize: 14.sp,
  fontWeight: FontWeight.w500,
  color: neutral50,
);

TextStyle styleGraphSubHeader = TextStyle(
  color: blue4,
  fontSize: 14.sp,
  fontWeight: FontWeight.w700,
);

TextStyle hintTextStyle = TextStyle(
  fontSize: 14.sp,
  color: unselectedTextColor,
);

TextStyle styleGraphKM = TextStyle(fontSize: 8.sp);

TextStyle cardTitleStyle = TextStyle(
  fontWeight: FontWeight.bold,
  fontSize: 16.sp,
  color: blue4,
);

TextStyle cardTextStyle = TextStyle(
  fontSize: 12.sp,
  fontWeight: FontWeight.w500,
  color: neutral60,
);

TextStyle tableTitleStyle = TextStyle(
  color: neutral60,
  fontWeight: FontWeight.w700,
  fontSize: 14.sp,
);
TextStyle tableTextStyle = TextStyle(
  color: neutral60,
  fontWeight: FontWeight.w400,
  fontSize: 14.sp,
);

// Text Styles

// Snackbars
SnackBar noInternet = SnackBar(
  width: 160,
  content: Text(
    'Koneksi internet bermasalah',
    textAlign: TextAlign.center,
    style: TextStyle(fontSize: 10.sp),
  ),
  behavior: SnackBarBehavior.floating,
);

SnackBar comingSoon = SnackBar(
  content: Text(
    'Halaman sedang dalam tahap pengembangan. Ditunggu ya!',
    style: TextStyle(fontSize: 12.sp),
  ),
);

// Snackbars

//default limit api
var defaultLimit = 10;

var suggestionsBoxDecoration =
    SuggestionsBoxDecoration(color: white, elevation: 0.5, shadowColor: white);

var speedSkeleton = 1500;

var subtitleForm = TextStyle(
  color: blue2,
  fontSize: 12.sp,
);
