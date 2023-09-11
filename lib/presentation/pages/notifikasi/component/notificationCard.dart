import 'package:app/presentation/component/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotificationCard extends StatelessWidget {
  final bool isRead;
  final bool isPengumuman;
  final String category;
  final VoidCallback onTap;
  final String title;

  const NotificationCard({
    Key? key,
    required this.isRead,
    required this.isPengumuman,
    required this.category,
    required this.onTap,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: isRead ? white : Color(0xffDEEFFF),
        height: 115.h,
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildNotifImage(),
            Expanded(flex: 1, child: _buildTitleAndCategory()),
          ],
        ),
      ),
    );
  }

  Widget _buildNotifImage() {
    String? assetPath;
    switch (category) {
      case "news":
        {
          assetPath = "assets/notifikasi/fxemoji_newspaper_baru.png";
        }
        break;
      case "pengumuman":
        {
          assetPath = "assets/notifikasi/fxemoji_loudspeaker_baru.png";
        }
        break;
      case "Komdos":
        {
          assetPath = "assets/notifikasi/fxemoji_komdos.png";
        }
        break;
      case "PDDIKTI":
        {
          assetPath = "assets/notifikasi/fxemoji_pddikti.png";
        }
        break;
      case "selancarPAK":
        {
          assetPath = "assets/notifikasi/fxemoji_selancarPAK.png";
        }
        break;
      default:
        {
          assetPath = "assets/notifikasi/fxemoji_loudspeaker_baru.png";
        }
        break;
    }

    return Container(
      width: 50.w,
      height: 50.w,
      margin: EdgeInsets.only(right: 35.w),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(assetPath),
        ),
      ),
    );
  }

  Widget _buildTitleAndCategory() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildCategory(),
        Text(
          "$title",
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
          style: TextStyle(
              fontSize: 14.sp,
              fontWeight: isRead ? FontWeight.w400 : FontWeight.w700,
              color: blue2),
        ),
      ],
    );
  }

  Widget _buildCategory() {
    String? formattedCategory;
    switch (category) {
      case "news":
        {
          formattedCategory = "Berita";
        }
        break;
      case "pengumuman":
        {
          formattedCategory = "Pengumuman";
        }
        break;
      case "Komdos":
        {
          formattedCategory = "Kompetensi Dosen";
        }
        break;
      case "PDDIKTI":
        {
          formattedCategory = "Usulan Dosen";
        }
        break;
      case "selancarPAK":
        {
          formattedCategory = "Selancar PAK";
        }
        break;
      default:
        {
          formattedCategory = category;
        }
        break;
    }

    // if (isPengumuman) {
    //   return Container(
    //     margin: EdgeInsets.only(top: 8.h),
    //     child: Text(
    //       category,
    //       style: TextStyle(
    //           color: neutralCaption,
    //           fontWeight: FontWeight.w400,
    //           fontSize: 11.sp),
    //     ),
    //   );
    // } else {
    //   return Container();
    // }
    return Container(
      margin: EdgeInsets.only(bottom: 8.h),
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r), color: blue6),
      child: Text(
        formattedCategory,
        style: TextStyle(
          fontSize: 12.sp,
          fontWeight: FontWeight.w500,
          color: blue2,
        ),
      ),
    );
  }
}
