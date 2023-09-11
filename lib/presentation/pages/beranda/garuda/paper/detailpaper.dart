import 'package:app/common/launchUrl.dart';
import 'package:app/presentation/component/constant.dart';
import 'package:app/presentation/component/customAppBar.dart';
import 'package:app/presentation/pages/beranda/garuda/components/newListStyleCardGaruda.dart';
import 'package:app/presentation/pages/beranda/garuda/journal/detailjournal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DetailPaperGaruda extends StatelessWidget {
  final String title;
  final String sourceName;
  final String publisher;
  final String journalName;
  final String journalDescription;
  final String journalEissn;
  final String sourceIssue;
  final String abstract;
  final String issn;
  final String downloadOriginal;
  final String downloadBibtex;
  final String downloadRis;
  const DetailPaperGaruda(
      {Key? key,
      required this.sourceName,
      required this.publisher,
      required this.journalName,
      required this.title,
      required this.sourceIssue,
      required this.abstract,
      required this.issn,
      required this.downloadOriginal,
      required this.downloadBibtex,
      required this.downloadRis,
      required this.journalDescription,
      required this.journalEissn})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Paper'),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 32,
            ),
            Padding(
              padding: EdgeInsets.only(left: 16.w, right: 17.w),
              child: SelectableText(
                this.title,
                style: TextStyle(
                    color: blue2,
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5),
              ),
            ),
            SizedBox(
              height: 18.h,
            ),
            Padding(
              padding: EdgeInsets.only(left: 16.w, right: 17.w),
              child: SelectableText(
                this.publisher,
                enableInteractiveSelection: false,
                style: TextStyle(
                  color: blue4,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                ),
                onTap: () {
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => AuthorProfileGaruda()));
                },
              ),
            ),
            SizedBox(
              height: 18.h,
            ),
            Padding(
              padding: EdgeInsets.only(left: 16.w, right: 17.w),
              child: SelectableText(
                this.journalName,
                style: TextStyle(
                  color: neutral50,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            SizedBox(
              height: 18.h,
            ),
            Padding(
              padding: EdgeInsets.only(left: 16.w, right: 17.w),
              child: SelectableText(
                this.sourceIssue,
                style: TextStyle(
                  color: neutral30,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            SizedBox(
              height: 32.h,
            ),
            Padding(
              padding: EdgeInsets.only(left: 16.w, right: 17.w),
              child: Text(
                this.abstract,
                style: TextStyle(
                    color: abu7,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 0.5),
              ),
            ),
            SizedBox(
              height: 32.h,
            ),
            NewListStyleGarudaJurnalSearch(
              heightSpace: 0,
              function: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DetailJournalGaruda(
                              title: journalName == "" ? " - " : journalName,
                              published: publisher == "" ? " - " : publisher,
                              litTags: ['-'],
                              description: abstract == "" ? " - " : abstract,
                              issn: journalEissn == "" ? " - " : journalEissn,
                              essn: issn == "" ? " - " : issn,
                            )));
              },
              image: "assets/garuda/iconjurnal.png",
              title: this.journalName,
              subTitle: this.publisher,
              listTagName: [],
              ssn: "Jurnal ISSN: ${this.issn}",
            ),
            SizedBox(
              height: 40.h,
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(color: white, boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.25),
            blurRadius: 25,
            spreadRadius: 0,
            offset: Offset(0, 6),
          )
        ]),
        child: Container(
          height: 100.w,
          child: InkWell(
            onTap: () {
              // no func for a while
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () {
                    launchURL(this.downloadOriginal);
                  },
                  child: ButtonDownload(
                    image: "assets/garuda/pdf.png",
                    title: "Download PDF",
                    color: red,
                  ),
                ),
                InkWell(
                  onTap: () {
                    launchURL(this.downloadRis);
                  },
                  child: ButtonDownload(
                    image: "assets/garuda/riss.png",
                    title: "Download RIS",
                    color: blue4,
                  ),
                ),
                InkWell(
                  onTap: () {
                    launchURL(this.downloadBibtex);
                  },
                  child: ButtonDownload(
                    image: "assets/garuda/bibteex.png",
                    title: "Download BibTex",
                    color: green3,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ButtonDownload extends StatelessWidget {
  final dynamic image;
  final String title;
  final Color color;
  const ButtonDownload({
    Key? key,
    required this.image,
    required this.title,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 62.w,
      width: 62.w,
      child: Column(
        children: [
          SizedBox(
            height: 9.w,
          ),
          Image.asset(
            this.image,
            width: 16.w,
            height: 16.h,
          ),
          SizedBox(
            height: 6.w,
          ),
          Flexible(
            child: Text(this.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: this.color,
                    fontWeight: FontWeight.w400,
                    fontSize: 10.sp)),
          ),
        ],
      ),
    );
  }
}
