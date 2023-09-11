import 'package:app/presentation/component/customAppBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../component/card_Comment.dart';

class KomentarPage extends StatefulWidget {
  const KomentarPage({Key? key}) : super(key: key);

  @override
  State<KomentarPage> createState() => _KomentarPageState();
}

class _KomentarPageState extends State<KomentarPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF9FAFE),
      appBar: CustomAppBar(
        title: 'Komentar',
        textStyle: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 18.sp,
        ),
      ),
      body: SingleChildScrollView(
        child: ListView.separated(
          padding: EdgeInsets.symmetric(vertical: 20.w, horizontal: 16.w),
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: 10,
          itemBuilder: (context, index) {
            return CommentCKM(
              name: 'Anonymous',
              date: '11/12/13',
              detailComment:
              'Best Book of Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut faucibus vulputate mollis. Vivamus libero ipsum, mollis nec elit id.',
              imageURL: 'https://i.pinimg.com/280x280_RS/e4/de/1f/e4de1f7d3225ae69e9e8d7134e0df2a0.jpg',
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return SizedBox(
              height: 32.h,
            );
          },
        ),
      ),
    );
  }
}
