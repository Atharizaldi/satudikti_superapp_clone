import 'package:app/presentation/component/SkeletonLoading.dart';
import 'package:app/presentation/component/constant.dart';
import 'package:app/presentation/pages/beranda/kompetensiDosen/components/programTerdaftar/skeleton_card_program_terdaftar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SkeletonMainProgramTerdaftar extends StatelessWidget {
  const SkeletonMainProgramTerdaftar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SkeletonCardProgramTerdaftar(
          backgroundColor: whiteBgPage,
        ),
        SizedBox(
          height: 20.sp,
        ),
        SkeletonLoading(
          width: double.infinity,
          height: 50.sp,
          cornerRadius: 10.r,
        )
      ],
    );
  }
}
