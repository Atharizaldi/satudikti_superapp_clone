import 'dart:async';

import 'package:app/common/baseUrl.dart';
import 'package:app/common/launchUrl.dart';
import 'package:app/data/source/local/sharedpreferences.dart';
import 'package:app/presentation/component/customAppBar.dart';
import 'package:app/presentation/pages/beranda/gmagz/bloc/detailmajalah/majalah_detail_gmagz_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:share_plus/share_plus.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:url_launcher/url_launcher.dart';

class BacaMajalahGMagz extends StatefulWidget {
  String url;
  String judul;
  String id;
  int lanjutBaca;
  bool islanjutBaca;
  String gambar;

  BacaMajalahGMagz(
      {Key? key,
      required this.gambar,
      required this.judul,
      required this.url,
      required this.id,
      this.lanjutBaca = 1,
      this.islanjutBaca = false})
      : super(key: key);

  @override
  State<BacaMajalahGMagz> createState() => _BacaMajalahGMagzState();
}

class _BacaMajalahGMagzState extends State<BacaMajalahGMagz> {
  bool isRead = false;

  late MajalahDetailGMagzBloc _majalahDetailGMagzBloc;
  PdfViewerController _pdfViewerController = PdfViewerController();
  List<String> majalahint = [];

  bool isPressed = false;
  String allPage = '';

  @override
  Widget build(BuildContext context) {
    bool isHorizontal = true;

    _majalahDetailGMagzBloc = BlocProvider.of<MajalahDetailGMagzBloc>(context);

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomAppBar(
          actions: [
            IconButton(
              onPressed: () {
                setState(() {
                  if (isPressed) {
                    isPressed = false;
                  } else {
                    isPressed = true;
                  }
                });
              },
              icon: Icon(
                Icons.more_vert_sharp,
                color: Colors.white,
                size: 30.sp,
              ),
            ),
          ],
          title: widget.judul,
        ),
        body: Align(
          alignment: Alignment.topRight,
          child: Stack(
            alignment: Alignment.topRight,
            children: [
              SfPdfViewer.network(
                '$urlAPI${widget.url}',
                scrollDirection: PdfScrollDirection.horizontal,
                onDocumentLoaded: (PdfDocumentLoadedDetails details) {
                  if (widget.islanjutBaca) {
                    isRead = true;
                  }
                  allPage = details.document.pages.count.toString();
                  majalahint = [
                    allPage,
                    widget.lanjutBaca.toString(),
                    widget.judul,
                    widget.gambar
                  ];

                  Prefs.setMajalahInt(majalahint);
                  Prefs.setMajalah(widget.id);

                  print('Jumlah halaman: ${details.document.pages.count}');
                  Timer(const Duration(seconds: 4), () {
                    _pdfViewerController.jumpToPage(widget.lanjutBaca);
                  });
                },
                onPageChanged: (PdfPageChangedDetails details) {
                  setState(() {
                    majalahint = [
                      allPage,
                      details.newPageNumber.toString(),
                      widget.judul,
                      widget.gambar
                    ];
                    if (!isRead && details.newPageNumber == 3) {
                      isRead = true;
                      _majalahDetailGMagzBloc
                          .add(PutGMagzReader(id: widget.id));
                    }
                    Prefs.setMajalahInt(majalahint);

                    print("INI PAGE SEKARANG ${majalahint}");
                    // prefs.setString('listMenuLainnya',
                    //     MenuItems.encode(menuItemsListLainnya));
                  });
                },
                controller: _pdfViewerController,
              ),
              isPressed
                  ? Wrap(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10.r),
                            boxShadow: [
                              BoxShadow(
                                color: Color.fromRGBO(0, 0, 0, 0.09),
                                offset: Offset(4, 10),
                                blurRadius: 6,
                              ),
                            ],
                          ),
                          margin: EdgeInsets.only(top: 10.w),
                          padding: EdgeInsets.all(17.w),
                          width: 150.w,
                          // height: 112.h,
                          child: Column(
                            children: [
                              InkWell(
                                onTap: () async {
                                  await Share.share("" +
                                      widget.judul +
                                      "" +
                                      "\n\n" +
                                      "Baca Selengkapnya: \n" +
                                      // "https://shopee.co.id/product/326487418/5358717104?d_id=b2bae&utm_content=3EpKSwcQnrv5HCE8MgSnoqFHF3SX" +
                                      // "$urlAPI/v2/gmagz/books/file/BULETIN-PUSDIKLAT-I-ilovepdf-compressed%20(2).pdf" +
                                      "$urlAPI${widget.url}" +
                                      "\n\nDownload aplikasi SatuDikti sekarang, dan dapatkan informasi terkini seputar Pendidikan Tinggi: \nPlaystore s.id/satudikti-android\nAppstore s.id/satudikti-ios");
                                },
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.share,
                                      color: Colors.black,
                                      size: 16.sp,
                                    ),
                                    SizedBox(
                                      width: 10.w,
                                    ),
                                    Text("Share",
                                        style: TextStyle(
                                            fontSize: 16.sp,
                                            color: Color.fromRGBO(
                                                102, 112, 133, 1),
                                            fontWeight: FontWeight.w500,
                                            fontFamily: 'Plus Jakarta Sans'))
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 20.h,
                              ),
                              InkWell(
                                onTap: () async {
                                  _majalahDetailGMagzBloc
                                      .add(PutGMagzDownloader(id: widget.id));
                                  String url = "$urlAPI${widget.url}";
                                  // 'https://dev.welove.web.id/public/android/Bumeeco.apk';
                                  if (await canLaunchUrl(Uri.parse(url))) {
                                    launchURL(url);
                                  } else {
                                    throw 'Could not launch $url';
                                  }
                                },
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.file_download_outlined,
                                      color: Colors.black,
                                      size: 20.sp,
                                    ),
                                    SizedBox(
                                      width: 10.w,
                                    ),
                                    Text("Download",
                                        style: TextStyle(
                                            fontSize: 16.sp,
                                            color: Color.fromRGBO(
                                                102, 112, 133, 1),
                                            fontWeight: FontWeight.w500,
                                            fontFamily: 'Plus Jakarta Sans')),
                                  ],
                                ),
                              ),
                              // InkWell(
                              //   onTap: () async {},
                              //   child: Row(
                              //     children: [
                              //       Icon(
                              //         Icons.file_download_outlined,
                              //         color: Colors.black,
                              //         size: 20.sp,
                              //       ),
                              //       SizedBox(
                              //         width: 10.w,
                              //       ),
                              //       Text("Download",
                              //           style: TextStyle(
                              //               fontSize: 16.sp,
                              //               color: Color.fromRGBO(
                              //                   102, 112, 133, 1),
                              //               fontWeight: FontWeight.w500,
                              //               fontFamily: 'Plus Jakarta Sans')),
                              //     ],
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                      ],
                    )
                  : Container(),
              isPressed
                  ? Positioned(
                      top: 0,
                      right: 10,
                      child: Transform.rotate(
                        angle: 0.785398,
                        child: Container(
                          margin: EdgeInsets.only(top: 5.w),
                          width: 17.w,
                          height: 17.w,
                          color: Colors.white,
                        ),
                      ),
                    )
                  : Container(),
            ],
          ),
        ));
  }
}
