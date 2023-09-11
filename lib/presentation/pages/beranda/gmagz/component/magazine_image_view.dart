import 'package:app/presentation/component/SkeletonLoading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DetailMagImageView extends StatefulWidget {
  const DetailMagImageView(
      {Key? key, required this.imageURL, required this.judulMajalah})
      : super(key: key);

  final String imageURL;
  final String judulMajalah;

  @override
  State<DetailMagImageView> createState() => _DetailMagImageViewState();
}

class _DetailMagImageViewState extends State<DetailMagImageView> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.only(bottom: 20.w),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(111, 24, 111, 0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.r),
                child: Image.network(
                  widget.imageURL,
                  loadingBuilder: (BuildContext context, Widget child,
                      ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) return child;
                    return SkeletonLoading(width: 168.w, height: 244.w);
                  },
                  width: 168.w,
                  height: 244.w,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20.w),
              child: Text(
                widget.judulMajalah,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
