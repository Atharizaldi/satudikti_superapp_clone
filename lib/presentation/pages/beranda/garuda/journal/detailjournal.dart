import 'package:app/presentation/component/constant.dart';
import 'package:app/presentation/component/customAppBar.dart';
import 'package:app/presentation/component/search/searchBar.dart';
import 'package:app/presentation/pages/beranda/garuda/components/detailSearchBarGarudaPaper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DetailJournalGaruda extends StatelessWidget {
  final String title, published, description, issn, essn;
  final List<String> litTags;
  const DetailJournalGaruda(
      {Key? key,
      required this.title,
      required this.published,
      required this.description,
      required this.issn,
      required this.essn,
      required this.litTags})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteBgPage,
      appBar: CustomAppBar(title: 'Jurnal'),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 32.h,
            ),
            Container(
                height: 155.w,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image:
                          AssetImage("assets/garuda/fix_detail_journal.png")),
                )),
            SizedBox(
              height: 20.h,
            ),
            Padding(
              padding: EdgeInsets.only(left: 15.w, right: 18.w),
              child: SelectableText(
                this.title,
                style: TextStyle(
                  color: blue2,
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: 12.h,
            ),
            Padding(
              padding: EdgeInsets.only(left: 15.w, right: 18.w),
              child: SelectableText(
                "Published By: ${this.published}",
                style: TextStyle(
                  color: neutral50,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            SizedBox(
              height: 12.h,
            ),
            Padding(
              padding: EdgeInsets.only(left: 15.w),
              child: Row(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width / 2.3,
                    child: SelectableText(
                      "ISSN: ${this.issn}",
                      style: TextStyle(
                        color: neutral50,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 2.3,
                    child: SelectableText(
                      "ESSN: ${this.essn}",
                      style: TextStyle(
                        color: neutral50,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 12.h,
            ),
            Padding(
              padding: EdgeInsets.only(left: 15.0.w, right: 15.0.w),
              child: Wrap(
                spacing: 6.w,
                runSpacing: 4.h,
                children: this.litTags.map((e) => _listTag(e)).toList(),
              ),
            ),
            SizedBox(
              height: 32.h,
            ),
            Padding(
              padding: EdgeInsets.only(left: 15.w, right: 17.w),
              child: Text(
                this.description,
                style: TextStyle(
                    color: neutral100,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 0.5),
              ),
            ),
            SizedBox(
              height: 50.h,
            ),
          ],
        ),
      ),
    );
  }

  Widget _listTag(String areaName) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        border: Border.all(color: green3),
        borderRadius: BorderRadius.circular(5.r),
      ),
      child: Text(
        areaName,
        style: TextStyle(
          fontSize: 10.sp,
          fontWeight: FontWeight.w200,
          color: green3,
        ),
      ),
    );
  }

  Widget _searchBar(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (builder) => DetailSearchBarGarudaPaper()));
      },
      child: Container(
        color: Colors.transparent,
        child: IgnorePointer(
          child: SearchBar(
            openKeyboard: false,
            hintText: 'Cari Artikel',
            searchType: TypeSearchBar.regular,
          ),
        ),
      ),
    );
  }
}
