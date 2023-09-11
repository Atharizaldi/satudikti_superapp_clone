import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CardWithImage extends StatelessWidget {
  final Color colorCard;
  final Color colorTextTitle;
  final Color colorTextSubTitle;
  final String textTitle;
  final String textSubTitle;
  final String image;
  final double? positionTopColumn;
  final double? positionBottomColumn;
  final double? positionLeftColumn;
  final double? positionRightColumn;
  final double? positionTopImage;
  final double? positionBottomImage;
  final double? positionLeftImage;
  final double? positionRightImage;
  final double? imageWidth;
  final double? imageHeight;
  const CardWithImage({
    Key? key,
    this.positionTopColumn,
    this.positionBottomColumn,
    this.positionLeftColumn,
    this.positionRightColumn,
    this.positionTopImage,
    this.positionBottomImage,
    this.positionLeftImage,
    this.positionRightImage,
    this.imageWidth,
    this.imageHeight,
    required this.image,
    required this.colorCard,
    required this.colorTextTitle,
    required this.colorTextSubTitle,
    required this.textTitle,
    required this.textSubTitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 159.h,
      color: this.colorCard,
      width: double.infinity,
      child: Stack(
        children: [
          Positioned(
            top: this.positionTopColumn,
            bottom: this.positionBottomColumn,
            left: this.positionLeftColumn,
            right: this.positionRightColumn,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 36.h),
                Padding(
                  padding: const EdgeInsets.only(left: 17.0),
                  child: Container(
                    width: 187.w,
                    child: Text(
                      this.textTitle,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14.sp,
                          color: this.colorTextTitle),
                    ),
                  ),
                ),
                SizedBox(
                  height: 9.h,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 17.0),
                  child: Container(
                    height: 60.h,
                    width: 187.w,
                    child: Text(
                      this.textSubTitle,
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 12.sp,
                          color: this.colorTextSubTitle),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: this.positionTopImage,
            bottom: this.positionBottomImage,
            left: this.positionLeftImage,
            right: this.positionRightImage,
            child: Image.asset(
              this.image,
              width: this.imageWidth,
              height: this.imageHeight,
            ),
          ),
        ],
      ),
    );
  }
}
