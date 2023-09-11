import 'dart:convert';

import 'package:app/presentation/component/constant.dart';
import 'package:app/presentation/component/customSliverBarKuesioner.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logger/logger.dart';

import '../../../../../../data/source/remote/model/tracer/TracerKuesioner.dart';
import '../../component/card_component.dart';
import '../../component/dialog_component.dart';
import '../../component/txtinput_component.dart';

class KuesionerIdentitas extends StatefulWidget {
  final List<TextEditingController> result;
  final String alumniId;
  final String nim;
  final String nama;
  final String tahunLulus;
  final String kodePt;
  final String kodeProdi;
  final String nik;

  const KuesionerIdentitas({
    Key? key,
    required this.result,
    required this.alumniId,
    required this.nim,
    required this.tahunLulus,
    required this.nama,
    required this.kodePt,
    required this.kodeProdi,
    required this.nik,
  }) : super(key: key);

  @override
  State<KuesionerIdentitas> createState() => _KuesionerIdentitasState();
}

class _KuesionerIdentitasState extends State<KuesionerIdentitas> {
  TextEditingController emailTextController = TextEditingController();
  TextEditingController npwpTextController = TextEditingController();
  TextEditingController noHPTextController = TextEditingController();

  List<Question>? _kuesioner;
  GetKuesioner? getResponse;
  int? maxPages;

  Future<void> getKuesioner() async {
    var response = await rootBundle.loadString('assets/tracer/dummyData1.json');
    print(response);
    setState(() {
      getResponse = GetKuesioner.fromJson(jsonDecode(response));
      _kuesioner = getResponse!.data;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    this.getKuesioner();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(gradient: sliverBgGradient),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: CustomSliverBarKuesioner(
            appBarTitle: "Kuesioner",
            child: Container(
              color: whiteBgPage,
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 32.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  bannerSubJudulTracer("Identitas"),
                  SizedBox(
                    height: 20.h,
                  ),
                  _textField(),
                  SizedBox(
                    height: 24.h,
                  ),
                  _buttonNext()
                ],
              ),
            )),
      ),
    );
  }

  Widget _textField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _typeForm(
            jenis: "nim",
            asset: "assets/tracerStudy/icon_idcard.png",
            label: "NIM",
            hintText: widget.nim,
            isrequired: false,
            isnotedit: true,
            controller: widget.result[2]),
        SizedBox(
          height: 20.h,
        ),
        _typeForm(
          jenis: "thnlulus",
          asset: "assets/tracerStudy/icon_perguruantinggi.png",
          label: "Tahun Lulus",
          hintText: widget.tahunLulus,
          isrequired: false,
          isnotedit: true,
        ),
        SizedBox(
          height: 20.h,
        ),
        _typeForm(
          jenis: "nama",
          asset: "assets/tracerStudy/icon_user.png",
          label: "Nama",
          hintText: widget.nama,
          isrequired: false,
          isnotedit: true,
        ),
        SizedBox(
          height: 20.h,
        ),
        _typeForm(
          jenis: "kodept",
          asset: "assets/tracerStudy/icon_perguruantinggi.png",
          label: "Kode PT",
          hintText: widget.kodePt,
          isrequired: false,
          isnotedit: true,
        ),
        SizedBox(
          height: 20.h,
        ),
        _typeForm(
          jenis: "kodeprodi",
          asset: "assets/tracerStudy/icon_programstudi.png",
          label: "Kode Prodi",
          hintText: widget.kodeProdi,
          isrequired: false,
          isnotedit: true,
        ),
        SizedBox(
          height: 20.h,
        ),
        _typeForm(
            jenis: "nik",
            asset: "assets/tracerStudy/icon_idcard.png",
            label: "NIK",
            hintText: widget.nik,
            isrequired: false,
            isnotedit: true,
            controller: widget.result[4]),
        SizedBox(
          height: 20.h,
        ),
        _typeForm(
            jenis: "email",
            asset: "assets/tracerStudy/icon_message.png",
            label: "Alamat Email",
            hintText: "Input",
            isrequired: false,
            isnotedit: false,
            controller: emailTextController),
        SizedBox(
          height: 20.h,
        ),
        _typeForm(
            jenis: "npwp",
            asset: "assets/tracerStudy/icon_idcard.png",
            label: "NPWP",
            hintText: "Input",
            isrequired: false,
            isnotedit: false,
            controller: npwpTextController),
        SizedBox(
          height: 20.h,
        ),
        _typeForm(
            jenis: "telp",
            asset: "assets/tracerStudy/icon_phone.png",
            label: "Nomor Telepon/HP",
            hintText: "Input",
            isrequired: false,
            isnotedit: false,
            controller: noHPTextController),
        SizedBox(
          height: 20.h,
        ),
      ],
    );
  }

  Widget _typeForm({
    required String jenis,
    required String asset,
    required String label,
    String? hintText,
    required bool isrequired,
    required bool isnotedit,
    TextEditingController? controller,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            children: [
              WidgetSpan(
                child: Image.asset(
                  asset,
                  width: 21.w,
                  height: 19.w,
                ),
              ),
              WidgetSpan(
                child: SizedBox(
                  width: 8.w,
                ),
              ),
              TextSpan(
                text: label,
                style: TextStyle(
                    color: blue2,
                    fontSize: 12.sp,
                    letterSpacing: 0.5,
                    fontWeight: FontWeight.w400),
              ),
              isrequired
                  ? TextSpan(
                      text: '*',
                      style: TextStyle(
                          color: Colors.red,
                          fontSize: 12.sp,
                          letterSpacing: 0.5,
                          fontWeight: FontWeight.w400),
                    )
                  : !isnotedit
                      ? TextSpan(
                          text: ' (Opsional)',
                          style: TextStyle(
                              color: blue4,
                              fontSize: 12.sp,
                              letterSpacing: 0.5,
                              fontWeight: FontWeight.w400),
                        )
                      : TextSpan(text: '')
            ],
          ),
        ),
        SizedBox(
          height: 6.h,
        ),
        Container(
          decoration: BoxDecoration(
              color: isnotedit ? neutral10 : white,
              borderRadius: BorderRadius.circular(5.r)),
          child: TextFormField(
            style: hintTextStyle.copyWith(color: neutral90),
            controller: controller,
            readOnly: isnotedit,
            initialValue: controller == null ? hintText : null,
            decoration: inputDecorationTextInput(
                color: isnotedit ? neutral10 : white,
                hintText: hintText ?? "Input",
                suffixIcon: (jenis == "date")
                    ? Icon(
                        Icons.date_range_rounded,
                        color: Color(0xffD3DCE3),
                      )
                    : SizedBox()),
          ),
        ),
      ],
    );
  }

  Widget _buttonNext() {
    return GestureDetector(
      onTap: () {
        // TO DO POST
        Logger().i("tidak kosong");

        // Navigate to next page
        YYDialogLanjutKuesioner(context, widget.alumniId, 2, widget.kodeProdi,
            widget.kodePt, widget.nik, widget.nim);
      },
      child: Align(
        alignment: Alignment.centerRight,
        child: Container(
          height: 50.h,
          width: 358.w,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: biruMuda2, borderRadius: BorderRadius.circular(5.r)),
          child: Center(
            child: Text(
              'Selanjutnya',
              style: TextStyle(
                color: white,
                fontSize: 18.sp,
                letterSpacing: 1,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
