import 'package:app/common/dateFormat.dart';
import 'package:app/presentation/component/SkeletonLoading.dart';
import 'package:app/presentation/component/constant.dart';
import 'package:app/presentation/component/inkEffect.dart';
import 'package:app/presentation/pages/showWebsite.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:truncate/truncate.dart';

void _onShowWebsiteTap(BuildContext context, String program, String url) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => ShowWebsite(
        title: program,
        link: url,
      ),
    ),
  );
}

class CardMBKM extends StatelessWidget {
  final String program, startDate, endDate, penjelasan, image, url;
  CardMBKM(
      {Key? key,
      required this.program,
      required this.startDate,
      required this.endDate,
      required this.penjelasan,
      required this.image,
      required this.url})
      : super(key: key);

  final FormatDate formatDate = FormatDate();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        boxShadow: [
          BoxShadow(
            color: Color(0x1A5C5E61),
            spreadRadius: -4,
            blurRadius: 16,
            offset: Offset(0, 12), // changes position of shadow
          ),
          BoxShadow(
            color: Color(0x0D5C5E61),
            spreadRadius: -2,
            blurRadius: 6,
            offset: Offset(0, 4), // changes position of shadow
          )
        ],
      ),
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      child: InkEffect(
        boxDecoration: BoxDecoration(
          color: white,
          borderRadius: BorderRadius.circular(10.r),
        ),
        onTap: () => _onShowWebsiteTap(context, program, url),
        child: Container(
          padding: EdgeInsets.all(12.w),
          width: double.infinity,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              this.image.isNotEmpty
                  ? Container(
                      width: 64.w,
                      height: 64.w,
                      padding: EdgeInsets.symmetric(horizontal: 4.w),
                      decoration: BoxDecoration(
                        color: whiteBgPage,
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Image.network(
                        "https://devsuperapp-api.dikti.go.id/v2/" + this.image,
                        loadingBuilder: (BuildContext context, Widget child,
                            ImageChunkEvent? loadingProgress) {
                          if (loadingProgress == null) return child;
                          return SkeletonLoading(
                            width: 64.w,
                            height: 64.w,
                            cornerRadius: 8.r,
                          );
                        },
                        errorBuilder: (BuildContext context, Object exception,
                            StackTrace? stacktrace) {
                          return Image.asset('assets/km.png');
                        },
                      ),
                    )
                  : Container(
                      width: 64.w,
                      height: 64.w,
                      padding: EdgeInsets.symmetric(horizontal: 4.w),
                      decoration: BoxDecoration(
                        color: whiteBgPage,
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Image.asset('assets/km.png')),
              SizedBox(width: 15.w),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 233.w,
                    child: SelectableText(
                      truncate(this.program, 50),
                      enableInteractiveSelection: false,
                      onTap: () => _onShowWebsiteTap(context, program, url),
                      style: TextStyle(
                        color: blue4,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                        height: 1.5.sp,
                      ),
                    ),
                  ),
                  this.startDate == "" ? SizedBox() : SizedBox(height: 10.w),
                  this.startDate == ""
                      ? SizedBox()
                      : Container(
                          width: 255.w,
                          height: 36.h,
                          padding: EdgeInsets.symmetric(
                              horizontal: 8.w, vertical: 4.h),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4.r),
                            color: Color(0xFFF5F7FF),
                          ),
                          child: Row(
                            children: [
                              Image.asset(
                                'assets/km/icons/calendar_icon.png',
                                width: 13.5.w,
                                height: 15.w,
                                color: neutral60,
                              ),
                              SizedBox(width: 7.w),
                              SelectableText(
                                truncate(
                                    '${formatDate.formatDate(this.startDate)} - ${formatDate.formatDate(this.endDate)}',
                                    35),
                                enableInteractiveSelection: false,
                                onTap: () =>
                                    _onShowWebsiteTap(context, program, url),
                                style: TextStyle(
                                  color: neutral80,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              )
                            ],
                          ),
                        ),
                  SizedBox(height: 10.h),
                  Container(
                    width: 232.w,
                    child: Text(
                      penjelasan,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: neutral60,
                          fontSize: 12.sp,
                          height: 1.5,
                          letterSpacing: -0.021),
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Lihat & Daftar',
                        style: TextStyle(
                            color: blue4,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w700,
                            letterSpacing: -0.021),
                      ),
                      SizedBox(width: 12.5.w),
                      Icon(
                        Icons.arrow_forward_ios_outlined,
                        color: blue4,
                        size: 12.sp,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
