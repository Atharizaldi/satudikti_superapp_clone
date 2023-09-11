import 'package:app/presentation/component/constant.dart';
import 'package:app/presentation/pages/profil/profilPage.dart';
import 'package:app/presentation/pages/profil/sso/utils/sso_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

cardAlertDialogLoginDosen(BuildContext context) async {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.r))),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {},
                child: Container(
                  alignment: FractionalOffset.topRight,
                  child: GestureDetector(
                    child: Icon(
                      Icons.clear,
                      color: Color(0XFFE0E0E0),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: 50.w,
                  right: 50.w,
                ),
                child: Image.asset(
                  "assets/pddikti/popup_pddikti.png",
                  width: 146.w,
                  height: 128.h,
                ),
              ),
              SizedBox(
                height: 30.h,
              ),
              Text(
                "Modul tidak bisa diakses",
                style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                    color: blueLinear1),
              ),
              SizedBox(
                height: 12.h,
              ),
              Text(
                "Silahkan login sebagai dosen untuk mengakses layanan ini",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    color: neutral70),
              ),
              SizedBox(
                height: 30.h,
              ),
              GestureDetector(
                onTap: () async {
                  Navigator.pop(context);

                  authorizationUrl = await createClient();
                  print("AUTH URL $authorizationUrl");
                  showSSOLoginPage(context, authorizationUrl);
                },
                child: Container(
                  width: 154.w,
                  height: 44.h,
                  decoration: BoxDecoration(
                    border: Border.all(color: blue4),
                    borderRadius: BorderRadius.circular(5.r),
                  ),
                  child: Center(
                    child: Text(
                      'Login',
                      style: TextStyle(
                        color: blue4,
                        fontWeight: FontWeight.w700,
                        fontSize: 14.sp,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      });
}

cardAlertDialogLogin(BuildContext context, String description,
    {VoidCallback? onTapButton, String title = ''}) async {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(12.r))),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(
                  left: 20.w,
                  right: 20.w,
                ),
                child: Image.asset(
                  "assets/sister/popup_sister.png",
                  width: 180.w,
                  height: 135.h,
                ),
              ),
              SizedBox(
                height: 16.h,
              ),
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                    color: neutral90),
              ),
              SizedBox(
                height: 8.h,
              ),
              Text(
                description,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    color: neutral70),
              ),
              SizedBox(
                height: 16.h,
              ),
              GestureDetector(
                onTap: () async {
                  Navigator.pop(context);
                  if (onTapButton != null) {
                    onTapButton();
                  }
                },
                child: Container(
                  width: 311.w,
                  height: 48.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.r),
                    // color: biruTua10,
                    color: Color(0xff248DDA),
                  ),
                  child: Center(
                    child: Text(
                      'Login',
                      style: TextStyle(
                        color: white,
                        fontWeight: FontWeight.w600,
                        fontSize: 16.sp,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              GestureDetector(
                onTap: () {},
                child: Container(
                  child: GestureDetector(
                    child: Text(
                      'Kembali',
                      style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: biruTua10),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 8.h,
              ),
            ],
          ),
        );
      });
}

cardAlertDialogLogout(BuildContext context, String description) async {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.r))),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {},
                child: Container(
                  alignment: FractionalOffset.topRight,
                  child: GestureDetector(
                    child: Icon(
                      Icons.clear,
                      color: Color(0XFFE0E0E0),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: 50.w,
                  right: 50.w,
                ),
                child: Image.asset(
                  "assets/pddikti/popup_pddikti.png",
                  width: 146.w,
                  height: 128.h,
                ),
              ),
              SizedBox(
                height: 30.h,
              ),
              Text(
                "Modul tidak bisa diakses",
                style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                    color: blueLinear1),
              ),
              SizedBox(
                height: 12.h,
              ),
              Text(
                description,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    color: neutral70),
              ),
              SizedBox(
                height: 30.h,
              ),
              GestureDetector(
                onTap: () async {
                  // Navigator.pop(context);
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (builder) => ProfilPage()));
                },
                child: Container(
                  width: 154.w,
                  height: 44.h,
                  decoration: BoxDecoration(
                    border: Border.all(color: blue4),
                    borderRadius: BorderRadius.circular(5.r),
                  ),
                  child: Center(
                    child: Text(
                      'Lanjutkan',
                      style: TextStyle(
                        color: blue4,
                        fontWeight: FontWeight.w700,
                        fontSize: 14.sp,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      });
}
