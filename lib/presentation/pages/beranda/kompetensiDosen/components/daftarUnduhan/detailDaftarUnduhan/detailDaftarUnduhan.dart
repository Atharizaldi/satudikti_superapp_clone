import 'package:app/common/baseUrl.dart';
import 'package:app/injection.dart' as di;
import 'package:app/presentation/component/blocs/PDFViewerBloc/pdfviewer_bloc.dart';
import 'package:app/presentation/component/constant.dart';
import 'package:app/presentation/component/customAppBar.dart';
import 'package:app/presentation/component/customPDFViewer.dart';
import 'package:app/presentation/pages/beranda/kompetensiDosen/bloc/file_list/file_list_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class DetailDaftarunduhan extends StatefulWidget {
  final String id;
  final String name;
  final String url;
  const DetailDaftarunduhan(
      {Key? key, required this.id, required this.name, required this.url})
      : super(key: key);

  @override
  State<DetailDaftarunduhan> createState() => _DetailDaftarunduhanState();
}

class _DetailDaftarunduhanState extends State<DetailDaftarunduhan> {
  late PdfViewerController _pdfViewerController;

  @override
  void initState() {
    _pdfViewerController = PdfViewerController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(
        "INI YG DITAMPILIN PDFNA $urlStagging/kompetensi/file/unduh/${widget.url}");
    return Scaffold(
      backgroundColor: whiteBgPage,
      appBar: CustomAppBar(
        title: "Daftar Unduhan",
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 0.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 30.sp,
              ),
              Text(
                widget.name,
                style: styleSubJudul.copyWith(color: blue4),
              ),
              SizedBox(
                height: 30.sp,
              ),
              Container(
                  height: 511.w,
                  alignment: Alignment.center,
                  child: BlocProvider(
                    create: (buildcontext) => di.locator<PdfviewerBloc>(),
                    child: CustomPDFViewer(
                      url: "$urlStagging/kompetensi/file/unduh/${widget.url}",
                    ),
                  )),
              SizedBox(
                height: 20.sp,
              ),
              Material(
                color: redDark,
                borderRadius: BorderRadius.circular(5.r),
                child: InkWell(
                  onTap: () {
                    print("tap download ${widget.url}");
                    BlocProvider.of<FileListBloc>(context)
                      ..add(DownloadPDFEvent(id: widget.url));
                  },
                  child: Container(
                    width: 171.w,
                    padding: EdgeInsets.only(
                        top: 10.sp,
                        bottom: 10.sp,
                        left: 22.5.sp,
                        right: 20.5.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/icons/icon_pdf.png',
                          width: 12.w,
                        ),
                        SizedBox(
                          width: 16.w,
                        ),
                        Text(
                          "Download PDF",
                          style: styleSubJudul2.copyWith(color: white),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 33.sp,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
