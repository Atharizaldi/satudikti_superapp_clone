import 'package:app/injection.dart' as di;
import 'package:app/presentation/component/constant.dart';
import 'package:app/presentation/component/customSliverBar.dart';
import 'package:app/presentation/pages/beranda/pddikti/component/bottom_sheet_form/text_field_pddikti.dart';
import 'package:app/presentation/pages/beranda/sivil/bloc/sivil_bloc.dart';
import 'package:app/presentation/pages/beranda/tracerStudy/component/card_component.dart';
import 'package:app/presentation/pages/beranda/tracerStudy/component/dialog_component.dart';
import 'package:app/presentation/pages/beranda/tracerStudy/component/txtinput_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../bloc/kuesioner/kuesioner_bloc.dart';
import '../bloc/kuesioner/kuesioner_event.dart';
import '../bloc/kuesioner/kuesioner_state.dart';
import '../component/infokuesioner_card.dart';

class KuesionerPage extends StatefulWidget {
  @override
  State<KuesionerPage> createState() => _KuesionerPageState();
}

class _KuesionerPageState extends State<KuesionerPage> {
  TextEditingController ptTextController = TextEditingController();
  TextEditingController prodiTextController = TextEditingController();
  TextEditingController nimTextController = TextEditingController();
  TextEditingController dateTextController = TextEditingController();
  TextEditingController nikTextController = TextEditingController();

  TextEditingController namaPerguruanTinggiController =
      new TextEditingController();
  TextEditingController programStudiController = new TextEditingController();
  var ptKode;
  Map<String, String> selectedPTObject = {"kodePT": ""};
  Map<String, String> selectedProdiObject = {"kodeProdi": ""};
  Map<String, String> selectedProvinsiObject = {"kodeProvinsi": ""};

  var prodiKode;

  String? date;

  List<bool> isnotValid = [false, false, false, false, false];

  String? dateFormatted;

  String? nomorResgistrasiValue;

  DateTime selectedDate = DateTime.now();

  _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      fieldHintText: "MM/DD/YYYY",
      currentDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2025),
    );
    print("Picked DATE $picked");
    if (picked != null) {
      date = DateFormat('dd/MM/yyyy').format(picked);
      dateFormatted = DateFormat('yyyy-MM-dd').format(picked);
      print("DateUnFormatted date $date");
      print("Formatted date $dateFormatted");
      // BlocProvider.of<DateCubit>(context).changeDate(dateView!);
      dateTextController.text = dateFormatted!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<KuesionerTracerBloc, KuesionerTracerState>(
      listener: (context, state) {
        if (state is ValidasiDataSuccessState) {
          print("suksesssss");
          Navigator.pop(context);
          if (state.data.message == "Alumni sudah mengisi kuesioner") {
            YYDialogFinish(context, state.data.data!.alumniId.toString());
          } else if (state.data.message ==
              "jawaban kuesioner ini sudah kamu isi") {
            YYDialogFinish(context, state.data.data!.alumniId.toString());
          } else {
            YYDialogSuccess(
              context,
              [
                ptTextController,
                prodiTextController,
                nimTextController,
                dateTextController,
                nikTextController
              ],
              state.data.data!.alumniId.toString(),
              state.data.data!.nim.toString(),
              state.data.data!.tahunLulus.toString(),
              state.data.data!.nama.toString(),
              state.data.data!.kodePt.toString(),
              state.data.data!.kodeProdi.toString(),
              state.data.data!.nik.toString(),
            );
          }
          //return Text("sukses");
        } else if (state is ValidasiDataFailedState) {
          //TODO: Dialog gagal masih placeholder
          String textContent;
          Navigator.pop(context);
          if (state.data.message == "Data Tersebut Belum dinyatakan Lulus") {
            textContent =
                "Maaf Anda belum dinyatakan lulus. Kuesioner hanya dapat diisi oleh alumni perguruan tinggi.";
          } else {
            textContent =
                "Data tidak ditemukan pada PDDikti. Silahkan cek data yang dimasukan";
          }

          YYDialogValidasiFailed(
            context,
            "Ups, Validasi Gagal",
            textContent,
          );
          // YYDialogFinishKuesioner(context, "", "", "", "", "");
        } else if (state is ValidasiDataLoadingState) {
          //TODO: Dialog koneksi error masih placeholder
          YYDialogLoading(
            context,
          );
          //  YYDialogFinishKuesioner(context, "", "", "", "", "");
          //Navigator.pop(context);
        } else {
          //TODO: Dialog koneksi error masih placeholder
          //  YYDialogFinishKuesioner(context, "", "", "", "", "");
          // showDialog<String>(
          //   context: context,
          //   builder: (BuildContext context) => AlertDialog(
          //     title: const Text('PLACEHOLDER DIALOG'),
          //     content: const Text('Koneksi error'),
          //     actions: <Widget>[
          //       TextButton(
          //         onPressed: () => Navigator.pop(context, 'Cancel'),
          //         child: const Text('Cancel'),
          //       ),
          //       TextButton(
          //         onPressed: () => Navigator.pop(context, 'OK'),
          //         child: const Text('OK'),
          //       ),
          //     ],
          //   ),
          // );
          YYDialogValidasiFailed(
            context,
            "Ups, Validasi Gagal",
            "Data tidak ditemukan pada PDDikti. Silahkan cek data yang dimasukan",
          );
        }
      },
      child: Container(
        decoration: BoxDecoration(gradient: sliverBgGradient),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: CustomSliverBar(
              expandedHeight: 260.w,
              appBarTitle: "Kuesioner",
              header: FlexibleSpaceBar(
                background: _header(),
              ),
              child: Container(
                color: whiteBgPage,
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 32.h),
                child: SingleChildScrollView(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InfoKuesionerCard(),
                        SizedBox(height: 28.h),
                        bannerSubJudulTracer("Validasi Data"),
                        SizedBox(height: 20.h),
                        _textField(),
                        _buttonNext(),
                      ]),
                ),
              )),
        ),
      ),
    );
  }

  Widget _header() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(gradient: beasiswaBgGradient),
      child: Stack(children: [
        Positioned(
          bottom: -20.w,
          right: -24.w,
          child: Image.asset(
            'assets/kompetensiDosen/header_kompetensi_dosen.png',
            width: 261.w,
            height: 261.w,
          ),
        ),
        Positioned(
          bottom: 22.w,
          child: Container(
            width: 346.w,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 23.0.w, right: 21.w),
                  child: Container(
                    height: 30.w,
                    child: Text(
                      "Kuesioner Tracer Study",
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w700,
                        color: white,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.w,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 23.w, right: 21.w),
                  child: Container(
                    height: 72.w,
                    child: Text(
                      "Pengisian Kuesioner untuk membantu mengevaluasi perbaikan serta pengembangan kualitas dan sistem pendidikan Perguruan Tinggi",
                      style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }

  Text rowLabel({
    required String asset,
    required String keterangan,
    bool isRequired = true,
  }) {
    return Text.rich(
      TextSpan(children: [
        WidgetSpan(
          child: Image.asset(
            asset,
            width: 16.sp,
            height: 16.sp,
          ),
        ),
        WidgetSpan(
          child: SizedBox(
            width: 8.sp,
          ),
        ),
        TextSpan(
            text: '$keterangan ',
            style: TextStyle(
                color: blue2,
                fontSize: 12.sp,
                letterSpacing: 0.2.sp,
                fontWeight: FontWeight.w500),
            children: [
              isRequired ? asterisk() : WidgetSpan(child: SizedBox()),
            ])
      ]),
      textAlign: TextAlign.center,
    );
  }

  TextSpan asterisk() {
    return TextSpan(
        text: '*',
        style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold));
  }

  Widget _textField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BlocProvider(
          create: (context) => di.locator<SivilBloc>(),
          child: Builder(builder: (context) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // perguruan tinggi
                rowLabel(
                  asset: "assets/icons/ijazahln/icon_pt.png",
                  keterangan: "Perguruan Tinggi",
                ),
                SizedBox(
                  height: 13.h,
                ),
                textFieldPTPDDikti(
                    context, namaPerguruanTinggiController, selectedPTObject),
                SizedBox(
                  height: screenHeight(context) * (1 / 60),
                ),

                // program studi
                rowLabel(
                  asset: "assets/icons/pddikti/icon_prodi.png",
                  keterangan: "Program Studi",
                ),
                SizedBox(
                  height: 13.h,
                ),
                textFieldProdiPDDikti(
                    context, programStudiController, selectedProdiObject),
              ],
            );
          }),
        ),
        SizedBox(
          height: 20.h,
        ),
        _typeForm(
            id: 3,
            jenis: "nim",
            asset: "assets/tracerStudy/icon_idcard.png",
            label: "NIM",
            hintText: "Masukkan NIM anda",
            messageError: "Harap masukan NIM",
            isrequired: true,
            isNotValid: isnotValid[2],
            controller: nimTextController),
        SizedBox(
          height: 20.h,
        ),
        _typeFormDate(
            id: 4,
            asset: "assets/tracerStudy/icon_calendar2.png",
            label: "Tanggal Lahir",
            hintText: "dd/mm/yyyy",
            messageError: "Harap masukan tanggal lahir",
            isrequired: true,
            isNotValid: isnotValid[3],
            controller: dateTextController,
            context: context),
        SizedBox(
          height: 20.h,
        ),
        _typeForm(
            id: 5,
            jenis: "nik",
            asset: "assets/tracerStudy/icon_idcard.png",
            label: "NIK",
            hintText: "Masukkan NIK anda",
            messageError: "Harap masukan NIK",
            isrequired: true,
            isNotValid: isnotValid[4],
            controller: nikTextController),
        SizedBox(
          height: 24.h,
        ),
      ],
    );
  }

  Widget _typeFormDate({
    required int id,
    required String asset,
    required String label,
    required String hintText,
    required String messageError,
    required bool isrequired,
    required bool isNotValid,
    required TextEditingController controller,
    required BuildContext context,
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
                  : WidgetSpan(child: SizedBox())
            ],
          ),
        ),
        SizedBox(
          height: 8.h,
        ),
        GestureDetector(
          onTap: () {
            _selectDate(context);
            setState(() {
              isnotValid[id - 1] = false;
            });
          },
          child: Container(
            color: white,
            child: IgnorePointer(
              child: TextFormField(
                readOnly: true,
                style: hintTextStyle.copyWith(color: neutral80),
                controller: controller,
                decoration: inputDecorationTextInput(
                  color: white,
                  hintText: hintText,
                  suffixIcon: Icon(
                    Icons.date_range_rounded,
                    color: Color(0xffD3DCE3),
                  ),
                ),
              ),
            ),
          ),
        ),
        isNotValid
            ? Container(
                margin: EdgeInsets.only(top: 8.h),
                child: RichText(
                    text: TextSpan(children: [
                  WidgetSpan(
                    child: Image.asset(
                      'assets/tracerStudy/icon_danger.png',
                      width: 15.w,
                      height: 15.w,
                    ),
                  ),
                  WidgetSpan(
                    child: SizedBox(
                      width: 8.w,
                    ),
                  ),
                  TextSpan(
                    text: messageError,
                    style: TextStyle(
                        color: alert10,
                        fontSize: 12.sp,
                        letterSpacing: 0.5,
                        fontWeight: FontWeight.w400),
                  ),
                ])),
              )
            : SizedBox()
      ],
    );
  }

  Widget _typeForm({
    required int id,
    required String jenis,
    required String asset,
    required String label,
    required String hintText,
    required String messageError,
    required bool isrequired,
    required bool isNotValid,
    required TextEditingController controller,
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
                  : TextSpan(
                      text: '',
                    )
            ],
          ),
        ),
        SizedBox(
          height: 6.h,
        ),
        Container(
          decoration: BoxDecoration(
              color: white, borderRadius: BorderRadius.circular(5.r)),
          child: TextFormField(
            style: hintTextStyle.copyWith(color: neutral80),
            controller: controller,
            decoration:
                inputDecorationTextInput(color: white, hintText: hintText),
            onChanged: (value) {
              setState(() {
                controller.text.isNotEmpty
                    ? isnotValid[id - 1] = false
                    : isnotValid[id - 1] = true;
              });
            },
          ),
        ),
        isNotValid
            ? Container(
                margin: EdgeInsets.only(top: 8.h),
                child: RichText(
                    text: TextSpan(children: [
                  WidgetSpan(
                    child: Image.asset(
                      'assets/tracerStudy/icon_danger.png',
                      width: 15.w,
                      height: 15.w,
                    ),
                  ),
                  WidgetSpan(
                    child: SizedBox(
                      width: 8.w,
                    ),
                  ),
                  TextSpan(
                    text: messageError,
                    style: TextStyle(
                        color: alert10,
                        fontSize: 12.sp,
                        letterSpacing: 0.5,
                        fontWeight: FontWeight.w400),
                  ),
                ])),
              )
            : SizedBox()
      ],
    );
  }

  Widget _buttonNext() {
    return GestureDetector(
      onTap: () {
        print("Kode PT MAHASISWA ${selectedPTObject["kodePT"]}");
        print("Kode Prodi MAHASISWA ${selectedProdiObject["kodeProdi"]}");
        print("Tanggal ${dateTextController.text}");

        BlocProvider.of<KuesionerTracerBloc>(context).add(PostValidateDataEvent(
            kodePt: selectedPTObject["kodePT"]!,
            kodeProdi: selectedProdiObject["kodeProdi"]!,
            nim: nimTextController.text,
            tglLahir: dateFormatted!,
            nik: nikTextController.text));

        // BlocProvider(
        //   create: (context) => di.locator<KuesionerTracerBloc>()
        //     ..add(PostValidateDataEvent(
        //         kodePt: selectedPTObject["kodePT"].toString(),
        //         kodeProdi: selectedProdiObject["kodeProdi"].toString(),
        //         nim: nimTextController.text,
        //         tglLahir: dateTextController.text,
        //         nik: nikTextController.text)),
        //   child: Builder(builder: (context) {
        //     return BlocBuilder<KuesionerTracerBloc, KuesionerTracerState>(
        //         builder: (context, state) {
        //       if (state is ValidasiDataFailedState) {
        //         YYDialogSuccess(
        //           context,
        //           [
        //             ptTextController,
        //             prodiTextController,
        //             nimTextController,
        //             dateTextController,
        //             nikTextController
        //           ],
        //         );
        //         return Text("");
        //       } else if (state is ValidasiDataSuccessState) {
        //         return Text("");
        //       } else {
        //         return Text("");
        //       }
        //     });
        //   }),
        // );
        // if (
        //   nimTextController.text.isNotEmpty &&
        //     dateTextController.text.isNotEmpty &&
        //     nikTextController.text.isNotEmpty) {
        //   // TO DO POST
        //   Logger().i("tidak kosong");

        //   // Navigate to next page
        //   setState(() {
        //     isnotValid = [false, false, false, false, false];
        //   });

        // } else {
        //   setState(() {
        //     (ptTextController.text.isEmpty &&
        //             prodiTextController.text.isEmpty &&
        //             nimTextController.text.isEmpty &&
        //             dateTextController.text.isEmpty &&
        //             nikTextController.text.isEmpty)
        //         ? isnotValid = [true, true, true, true, true]
        //         : ptTextController.text.isEmpty
        //             ? isnotValid[0] = true
        //             : isnotValid[0] = false;
        //     prodiTextController.text.isEmpty
        //         ? isnotValid[1] = true
        //         : isnotValid[1] = false;
        //     nimTextController.text.isEmpty
        //         ? isnotValid[2] = true
        //         : isnotValid[2] = false;
        //     dateTextController.text.isEmpty
        //         ? isnotValid[3] = true
        //         : isnotValid[3] = false;
        //     nikTextController.text.isEmpty
        //         ? isnotValid[4] = true
        //         : isnotValid[4] = false;
        //   });
        // }
      },
      child: Align(
        alignment: Alignment.center,
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
