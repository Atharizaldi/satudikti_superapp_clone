import 'package:app/presentation/component/SkeletonLoading.dart';
import 'package:app/presentation/component/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MajalahCard extends StatelessWidget {
  const MajalahCard(
      {Key? key,
        required this.image,
        required this.title,
        required this.date,
        required this.rating,
        required this.press,
        this.scaleSize})
      : super(key: key);

  final String image, title, date;
  final double rating;
  final double? scaleSize;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    final double defaultScaleSize = 0.8;
    return Transform.scale(
      scale: scaleSize ?? defaultScaleSize,
      child: Container(
        margin: EdgeInsets.only(
          left: (scaleSize ?? defaultScaleSize) != 1 ? 2 : 16.w,
          right: (scaleSize ?? defaultScaleSize) != 1 ? 0 : 16.w,
          top: (scaleSize ?? defaultScaleSize) != 1 ? 0 : 16.w,
          bottom: (scaleSize ?? defaultScaleSize) != 1 ? 4 : 0,
        ),
        width: 160.w,
        child: GestureDetector(
          onTap: press,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.r),
                    child: Image.network(
                      image,
                      loadingBuilder: (BuildContext context, Widget child,
                          ImageChunkEvent? loadingProgress) {
                        if (loadingProgress == null) return child;
                        return SkeletonLoading(width: 150.w, height: 200.w);
                      },
                      height: 232.w,
                      width: 169.w,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    top: 4.h,
                    right: 5.w,
                    child: Container(
                      decoration: BoxDecoration(
                        color: white,
                        borderRadius: BorderRadius.circular(16.sp),
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromRGBO(0, 0, 0, 0.02),
                            offset: Offset(0, 4),
                            blurRadius: 8,
                          )
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(4),
                        child: Row(
                          children: [
                            Icon(Icons.star,
                                color: Color(0xFFF3D75F), size: 12.h),
                            SizedBox(width: 3.w),
                            Text('$rating',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12.sp)),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8.h),
              Padding(
                padding: EdgeInsets.all(2.0),
                child: Column(
                  children: [
                    Text('$title',
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          overflow: TextOverflow.ellipsis,
                          fontSize: 16.sp,
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          letterSpacing: -0.5.sp,
                        )),
                    SizedBox(height: 4.h),
                    Text(
                      '$date',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: neutral50,
                        fontWeight: FontWeight.w400,
                        fontSize: 14.sp,
                        letterSpacing: -0.5.sp,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}