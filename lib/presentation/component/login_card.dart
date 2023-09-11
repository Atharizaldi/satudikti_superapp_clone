import 'package:app/presentation/component/constant.dart';
import 'package:app/presentation/component/inkEffect.dart';
import 'package:app/presentation/pages/profil/sso/utils/sso_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginCard extends StatelessWidget {
  final authorizationUrl;
  final VoidCallback? onTap;
  final bool isDosenOnlyModule;

  LoginCard({
    Key? key,
    this.onTap,
    required this.isDosenOnlyModule,
    this.authorizationUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20.w),
      child: InkEffect(
        onTap: onTap ??
            () async {
              final authorizationUrl = await createClient();
              print("AUTH URL $authorizationUrl");
              showSSOLoginPage(context, authorizationUrl);
            },
        boxDecoration: BoxDecoration(
            color: white, borderRadius: BorderRadius.circular(10.r)),
        child: LoginCardWidget(
          isDosenOnlyModule: this.isDosenOnlyModule,
        ),
      ),
    );
  }
}

class LoginCardWidget extends StatelessWidget {
  final bool isDosenOnlyModule;

  const LoginCardWidget({
    Key? key,
    required this.isDosenOnlyModule,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            'assets/profil/general.png',
            width: 64.sp,
            height: 64.sp,
            fit: BoxFit.cover,
            alignment: Alignment.topCenter,
          ),
          SizedBox(
            width: 20.w,
          ),
          Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Anda belum login",
                  style: TextStyle(
                    color: blue4,
                    fontWeight: FontWeight.w700,
                    fontSize: 16.sp,
                  ),
                ),
                SizedBox(
                  height: 6.sp,
                ),
                Text(
                  isDosenOnlyModule
                      ? "Silahkan login sebagai dosen terlebih dahulu"
                      : "Silahkan login terlebih dahulu",
                  style: TextStyle(
                      color: teksAbuCerah4,
                      fontWeight: FontWeight.w400,
                      fontSize: 12.sp),
                ),
                SizedBox(height: 20.sp),
                Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    width: 70.w,
                    height: 40.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.r),
                      color: blue4,
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}
