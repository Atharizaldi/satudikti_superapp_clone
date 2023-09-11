import 'package:app/data/source/local/sharedpreferences.dart';
import 'package:app/injection.dart' as di;
import 'package:app/presentation/component/constant.dart';
import 'package:app/presentation/component/customAppBar.dart';
import 'package:app/presentation/pages/beranda/pddikti/bloc/detail_pencarian/pt/detail_pencarian_pt_bloc.dart';
import 'package:app/presentation/pages/beranda/pddikti/bloc/usulan_dosen/usulan_dosen_bloc.dart';
import 'package:app/presentation/pages/beranda/pddikti/component/bottom_sheet_form/bottom_sheet_formField/bottom_sheet_formfield.dart';
import 'package:app/presentation/pages/beranda/pddikti/component/perguruanTinggi/idPTModal.dart';
import 'package:app/presentation/pages/beranda/pddikti/cubit/date/date_cubit.dart';
import 'package:app/presentation/pages/beranda/pddikti/pages/cek_status_usulan_dosen/daftar_riwayat_usulan_dosen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

///INI SEMENTARA AJA, KALO FIX NANTI DI PDDIKTI MAIN PAGE PAKE PAGE INI YAK///
class CekStatusUsulanDosen extends StatefulWidget {
  CekStatusUsulanDosen({Key? key}) : super(key: key);

  @override
  State<CekStatusUsulanDosen> createState() => _CekStatusUsulanDosenState();
}

class _CekStatusUsulanDosenState extends State<CekStatusUsulanDosen> {
  TextEditingController namaController = new TextEditingController();
  TextEditingController namaPerguruanTinggiController =
      new TextEditingController();

  TextEditingController dateController = new TextEditingController();
  TextEditingController ptTextController = TextEditingController();
  // TextEditingController namaIbuKandungController = new TextEditingController();
  late DetailPencarianPtBloc _detailPencarianPtBloc;

  String? date;

  String? dateView;

  String? nomorResgistrasiValue;

  DateTime selectedDate = DateTime.now();

  List<String> recentDocument = [];

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
      date = DateFormat('yyyy-MM-dd').format(picked);
      dateView = DateFormat('dd/MM/yyyy').format(picked);
      print("Formatted date $date");
      BlocProvider.of<DateCubit>(context).changeDate(dateView!);
      dateController.text = dateView!;
    }
  }

  String nidnDosen = '';

  static Future<SharedPreferences> getPrefs() async {
    final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    return await _prefs;
  }

  void getRecentDocument() async {
    SharedPreferences prefs = await getPrefs();
    setState(() {
      if (prefs.getStringList("StatusUD")!.isNotEmpty) {
        recentDocument = [
          prefs.getStringList("StatusUD")![0],
          prefs.getStringList("StatusUD")![1],
          prefs.getStringList("StatusUD")![2],
        ];
      }
    });
  }

  @override
  void initState() {
    super.initState();
    getRecentDocument();
    nidnDosen = Prefs.getNidnDosen() ?? '';
  }

  String pt = '';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DateCubit(),
      child: Scaffold(
        appBar: CustomAppBar(
          title: 'Status Usulan Dosen',
        ),
        backgroundColor: Colors.transparent,
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
          color: whiteBgPage,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Cek Usulan Dosen',
                style: TextStyle(
                    color: blue3, fontSize: 20.sp, fontWeight: FontWeight.w700),
              ),
              SizedBox(
                height: 20.h,
              ),
              rowTextField(
                label: "Nama",
                hintText: "Nama",
                controller: namaController,
              ),
              SizedBox(
                height: 20.h,
              ),
              BlocBuilder<DateCubit, DateState>(
                builder: (context, state) {
                  if (state is DateLoaded) {
                    dateController.text = state.date;
                    return rowDateField(
                      label: "Tanggal Lahir",
                      hintText: "dd/mm/yyyy",
                      controller: dateController,
                      context: context,
                    );
                  } else {
                    return rowDateField(
                      label: "Tanggal Lahir",
                      hintText: "Pilih Tanggal Lahir",
                      controller: dateController,
                      context: context,
                    );
                  }
                },
              ),
              SizedBox(
                height: 20.h,
              ),
              _ptDropdown(context, (selectedPT) {
                setState(() {
                  pt = selectedPT;
                });
              }),
              // rowTextField(
              //   label: "Nama Ibu Kandung",
              //   hintText: "Nama Ibu Kandung",
              //   controller: namaIbuKandungController,
              // ),
              SizedBox(
                height: 30.h,
              ),
              _buttonCari(),
              SizedBox(
                height: 20.h,
              ),
              if (nidnDosen != '') _bannerRiwayat(context),
              SizedBox(
                height: 48.h,
              ),
              // TODO : Fix params cek status usulan saya
              // Coba pakai nik sebagai unique params pada endpoint cek usulan dosen
              // _cardCekStatusUsulanSaya(),
            ],
          ),
        ),
      ),
    );
  }

  BlocBuilder<DateCubit, DateState> _buttonCari() {
    return BlocBuilder<DateCubit, DateState>(
      builder: (context, state) {
        return GestureDetector(
          onTap: () async {
            SharedPreferences prefs = await getPrefs();
            if (namaController.text.isNotEmpty &&
                state is DateLoaded &&
                namaPerguruanTinggiController.text.isNotEmpty) {
              String nama = namaController.text;
              // String namaIbuKandung = namaPerguruanTinggiController.text;
              prefs.setStringList("StatusUD", [
                nama,
                date!,
                dateView!,
              ]);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BlocProvider(
                      create: (context) => di.locator<UsulanDosenBloc>()
                        ..add(
                          GetUsulanDosenEvent(
                              namaDosen: nama,
                              tanggalLahir: date!,
                              idPT: pt,
                              isLogin: 'false',
                              nidn: ''),
                        ),
                      child: DaftarRiwayatUsulanDosen(),
                      // child: BlocProvider(
                      //   create: (context) => TabBarCubit(),
                      //   child: RiwayatUsulanPage(),
                      // ),
                    ),
                  ));
            } else {
              SnackBar isifield = SnackBar(
                content: Text(
                  'Harap isi semua kolom terlebih dahulu',
                  style: TextStyle(fontSize: 12.sp),
                ),
              );
              ScaffoldMessenger.of(context).showSnackBar(isifield);
            }
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
                  'Cari Usulan',
                  style: TextStyle(
                    color: white,
                    fontSize: 14.sp,
                    letterSpacing: 1,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Column rowDateField({
    required String label,
    bool isRequired = true,
    required String hintText,
    required TextEditingController controller,
    required BuildContext context,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(children: [
            TextSpan(
              text: '$label ',
              style: TextStyle(
                color: Color.fromRGBO(52, 64, 84, 1),
                fontSize: 14.sp,
                letterSpacing: 0.08.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            isRequired
                ? TextSpan(
                    text: '*',
                    style: TextStyle(
                        color: Colors.red, fontWeight: FontWeight.bold))
                : WidgetSpan(child: SizedBox()),
          ]),
        ),
        SizedBox(
          height: 8.h,
        ),
        GestureDetector(
          onTap: () {
            _selectDate(context);
          },
          child: Container(
            color: white,
            child: IgnorePointer(
              child: TextFormField(
                readOnly: true,
                style: hintTextStyle.copyWith(color: neutral80),
                controller: controller,
                decoration: inputDecorationTextInput(
                  hintText: hintText,
                  suffixIcon: Icon(
                    Icons.date_range_rounded,
                    size: 20.sp,
                    color: Color.fromRGBO(71, 84, 103, 1),
                  ),
                ),
                enabled: false,
                onSaved: (value) => nomorResgistrasiValue = value,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _ptDropdown(BuildContext context, Function(String) ptCallback) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(children: [
            TextSpan(
              text: 'Perguruan Tinggi ',
              style: TextStyle(
                color: Color.fromRGBO(52, 64, 84, 1),
                fontSize: 14.sp,
                letterSpacing: 0.08.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            TextSpan(
                text: " *",
                // text: '*',
                style:
                    TextStyle(color: Colors.red, fontWeight: FontWeight.bold))
          ]),
        ),
        SizedBox(
          height: 8.h,
        ),
        GestureDetector(
          onTap: () {
            // BlocProvider(
            //   create: (context) => di.locator<DetailPencarianPtBloc>()
            //     ..add(IDPTPDDIKTIEvent(id: '')),
            // );
            // BlocBuilder(
            //   builder: (context, state) {
            //     _detailPencarianPtBloc =
            //               BlocProvider.of<DetailPencarianPtBloc>(context);

            //   },
            // );
            showModalBottomSheet(
                isScrollControlled: true,
                isDismissible: true,
                backgroundColor: Colors.transparent,
                context: context,
                builder: (context) {
                  return BlocProvider(
                      create: (context) => di.locator<DetailPencarianPtBloc>()
                        ..add(IDPTPDDIKTIEvent(id: '')),
                      child: IDMODALPDDIKTI(
                        pt: 'pt',
                        context: context,
                        controller: namaPerguruanTinggiController,
                        onPtSelected: (selectedPt) {
                          ptCallback(selectedPt);
                        },
                      ));
                });
            print("CEK $pt");
          },
          child: Container(
            color: Colors.white,
            child: TextFormField(
              style: TextStyle(
                fontSize: 14.sp,
                color: neutral60,
                fontWeight: FontWeight.w400,
              ),
              controller: namaPerguruanTinggiController,
              decoration: InputDecoration(
                isDense: true,
                suffixIcon: Icon(
                  Icons.arrow_drop_down,
                  color: neutralCaption,
                ),
                border: OutlineInputBorder(
                  // borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                hintText: "Pilih perguruan tinggi",
                hintStyle: TextStyle(
                  fontSize: 14.sp,
                  color: neutral20,
                  fontWeight: FontWeight.w400,
                ),
              ),
              enabled: false,
            ),
          ),
        ),
      ],
    );
  }

  Column rowTextField({
    required String label,
    bool isRequired = true,
    required String hintText,
    required TextEditingController controller,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(children: [
            TextSpan(
              text: '$label ',
              style: TextStyle(
                color: Color.fromRGBO(52, 64, 84, 1),
                fontSize: 14.sp,
                letterSpacing: 0.08.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            isRequired
                ? TextSpan(
                    text: '*',
                    style: TextStyle(
                        color: Colors.red, fontWeight: FontWeight.bold))
                : WidgetSpan(child: SizedBox()),
          ]),
        ),
        SizedBox(
          height: 8.h,
        ),
        GestureDetector(
          onTap: () {
            controller.clear();
            showModalBottomSheet(
              isScrollControlled: true,
              isDismissible: true,
              backgroundColor: Colors.transparent,
              context: context,
              builder: (context) {
                return BottomSheetFormField(
                  cekStatusUsulanDosenPageContext: context,
                  textEditingController: controller,
                  hintText: hintText,
                );
              },
            );
          },
          child: Container(
            color: white,
            child: TextFormField(
              onChanged: (val) {
                setState(() {});
              },
              style: hintTextStyle.copyWith(color: neutral80),
              controller: controller,
              decoration: inputDecorationTextInput(hintText: hintText),
              enabled: false,
              // onChanged: (value) => {
              //   // setState(() {
              //   //   this.nomorResgistrasiValue = value;
              //   // })
              // },
              onSaved: (value) => nomorResgistrasiValue = value,
            ),
          ),
        ),
      ],
    );
  }

  InputDecoration inputDecorationTextInput(
      {required String hintText, Widget? suffixIcon}) {
    return InputDecoration(
      hintText: hintText,
      contentPadding: EdgeInsets.symmetric(horizontal: 12.sp, vertical: 16.sp),
      hintStyle: TextStyle(
        color: abu,
        // fontSize: screenArea(context) * (0.00005),
      ),
      suffixIcon: suffixIcon,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.r),
        borderSide:
            BorderSide(color: white, style: BorderStyle.solid, width: 2),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.r),
        borderSide:
            BorderSide(color: white, style: BorderStyle.solid, width: 2),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.r),
        borderSide:
            BorderSide(color: white, style: BorderStyle.solid, width: 1.2),
      ),
      isDense: true,
    );
  }

  // Widget _bannerRecentDocument() {
  //   return GestureDetector(
  //     onTap: () {
  //       if (recentDocument.isNotEmpty) {
  //         Navigator.push(
  //             context,
  //             MaterialPageRoute(
  //               builder: (context) => BlocProvider(
  //                 create: (context) => di.locator<UsulanDosenBloc>()
  //                   ..add(
  //                     GetUsulanDosenEvent(
  //                       namaDosen: recentDocument[0],
  //                       tanggalLahir: recentDocument[1],
  //                       namaIbuKandung: recentDocument[2],
  //                     ),
  //                   ),
  //                 child: BlocProvider(
  //                   create: (context) => TabBarCubit(),
  //                   child: RiwayatUsulanPage(),
  //                 ),
  //               ),
  //             ));
  //       }
  //     },
  //     child: Container(
  //       width: 360.w,
  //       height: 115.sp,
  //       padding: EdgeInsets.symmetric(horizontal: 15.w),
  //       decoration: BoxDecoration(
  //         borderRadius: BorderRadius.circular(10),
  //         color: white,
  //       ),
  //       child: Column(
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           Text(
  //             recentDocument[0],
  //             style: TextStyle(
  //                 fontSize: 15.sp,
  //                 fontWeight: FontWeight.w700,
  //                 letterSpacing: -0.006.sp,
  //                 color: Colors.black),
  //           ),
  //           SizedBox(
  //             height: 10.w,
  //           ),
  //           Text(
  //             recentDocument[3],
  //             style: TextStyle(
  //                 fontSize: 14.sp,
  //                 fontWeight: FontWeight.w500,
  //                 letterSpacing: -0.006.sp,
  //                 color: Colors.black),
  //           ),
  //           SizedBox(
  //             height: 10.w,
  //           ),
  //           Text(
  //             recentDocument[2],
  //             style: TextStyle(
  //                 fontSize: 14.sp,
  //                 fontWeight: FontWeight.w500,
  //                 letterSpacing: -0.006.sp,
  //                 color: Colors.black),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  Widget _bannerRiwayat(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BlocProvider(
                create: (context) => di.locator<UsulanDosenBloc>()
                  ..add(
                    GetUsulanDosenEvent(
                        namaDosen: '',
                        tanggalLahir: '',
                        idPT: '',
                        isLogin: 'true',
                        nidn: nidnDosen),
                  ),
                child: DaftarRiwayatUsulanDosen(),
              ),
            ));
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => RiwayatUsulanPerubahanDataPDDIKTIPage(),
        //   ),
        // );
      },
      child: Container(
        width: double.infinity,
        child: Card(
          color: blueLinear1,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: 50.w,
                      height: 50.h,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(25.r)),
                    ),
                    Image.asset(
                      'assets/faq/sister_lihat_faq.png',
                      width: 34.w,
                      height: 41.h,
                      scale: 2.0,
                    ),
                  ],
                ),
                SizedBox(width: 20.w),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Pernah mengajukan usulan?",
                      style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w700,
                          letterSpacing: -0.006.sp,
                          color: white),
                    ),
                    SizedBox(
                      height: 10.w,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Cek riwayat usulan",
                          style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                              letterSpacing: -0.006.sp,
                              color: white),
                        ),
                        SizedBox(
                          width: 2,
                        ),
                        Icon(
                          Icons.navigate_next,
                          color: white,
                          size: 16,
                        )
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
