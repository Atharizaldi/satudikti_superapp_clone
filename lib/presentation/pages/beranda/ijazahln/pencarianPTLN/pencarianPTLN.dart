import 'package:app/injection.dart' as di;
import 'package:app/presentation/component/constant.dart';
import 'package:app/presentation/component/customSliverBar.dart';
import 'package:app/presentation/pages/beranda/ijazahln/bloc/bloc/bts_pt_ijazah_bloc.dart';
import 'package:app/presentation/pages/beranda/ijazahln/bloc/ijazahln/verifikasisk/negarapt/negara_bloc.dart';
import 'package:app/presentation/pages/beranda/ijazahln/component/reusableWidgets/informationCard.dart';
import 'package:app/presentation/pages/beranda/ijazahln/component/type_field_pt.dart';
import 'package:app/presentation/pages/beranda/ijazahln/pencarianPTLN/hasilPTLN.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PencarianPTLN extends StatefulWidget {
  const PencarianPTLN({Key? key}) : super(key: key);

  @override
  State<PencarianPTLN> createState() => _PencarianPTLNState();
}

class _PencarianPTLNState extends State<PencarianPTLN> {
  TextEditingController negaraController = new TextEditingController();

  @override
  void initState() {
    negaraController.clear();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return Container(
        color: blueLinear2,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: CustomSliverBar(
            expandedHeight: 260.w,
            appBarTitle: "Ijazah LN",
            header: FlexibleSpaceBar(background: Header()),
            child: Container(
              color: whiteBgPage,
              height: 650.h,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 30.h, horizontal: 16.w),
                child: Column(
                  children: [
                    InformationCard(
                        text: RichText(
                            text: TextSpan(children: [
                      TextSpan(
                          text:
                              "Untuk mencari asal perguruan tinggi, silahkan inputkan pencarian negara dalam ",
                          style: TextStyle(
                            color: neutralCaption,
                            fontSize: 10.sp,
                            height: 1.5,
                            letterSpacing: 0.08.sp,
                          )),
                      TextSpan(
                        text: "Bahasa Inggris",
                        style: TextStyle(
                            letterSpacing: 0.08.sp,
                            fontSize: 10.sp,
                            color: neutralCaption,
                            height: 1.5,
                            fontWeight: FontWeight.w700),
                      ),
                      TextSpan(
                        text: ". Contoh : Japan, Germany, South Korea",
                        style: TextStyle(
                            letterSpacing: 0.08.sp,
                            fontSize: 10.sp,
                            color: neutralCaption,
                            height: 1.5),
                      ),
                    ]))),
                    SizedBox(
                      height: 30.h,
                    ),
                    _searchBar(),
                    SizedBox(
                      height: 8.h,
                    ),
                    _buttonCari(),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }

  Widget _searchBar() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(children: [
            WidgetSpan(
                child: Image.asset(
              'assets/icons/ijazahln/icon_location.png',
              width: 16.sp,
              height: 16.sp,
            )),
            WidgetSpan(
                child: SizedBox(
              width: 8.w,
            )),
            TextSpan(
              text: "Asal Negara Perguruan Tinggi",
              style: TextStyle(color: blue4, fontSize: 14.sp),
            ),
            TextSpan(text: '*', style: TextStyle(color: Colors.red))
          ]),
        ),
        SizedBox(height: 8.w),
        textFieldNegaraIjazah(context, negaraController),
        SizedBox(height: 8.w),
      ],
    );
  }

  Widget _buttonCari() {
    return BlocBuilder<NegaraBloc, NegaraState>(
      builder: (context, state) {
        if (state is NegaraInitialState) {
          return Align(
            alignment: Alignment.centerRight,
            child: GestureDetector(
              onTap: () {
                String idNegara = state.kodeNegara ?? '';
                _onPressedCari(idNegara);
              },
              child: Container(
                  height: 50.h,
                  width: 358.w,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: state.namaNegara != null ? blue4 : buttonDisable,
                      borderRadius: BorderRadius.circular(5)),
                  child: Center(
                    child: Text(
                      'Cari',
                      style: TextStyle(
                          color: state.namaNegara != null
                              ? white
                              : textButtonDisable,
                          fontSize: 14.sp,
                          letterSpacing: 1,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
              ),
          );
        }
        return Container();
      },
    );
  }

  void _onPressedCari(String idNegara) {
    if (negaraController.text.isNotEmpty) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) => MultiBlocProvider(
                    providers: [
                      BlocProvider(
                        create: (context) => di.locator<NegaraBloc>(),
                      ),
                      BlocProvider(
                        create: (context) => di.locator<BtsPtIjazahBloc>()
                          ..add(BtsSearchPtIjazahEvent(
                              query: "", idNegara: idNegara)),
                      ),
                    ],
                    child: HasilPTLN(
                        namaNegara: negaraController.text, idNegara: idNegara),
                  )));
    } else {
      SnackBar isiMessage = SnackBar(
        content: Text(
          'Harap isi Negara terlebih dahulu',
          style: TextStyle(fontSize: 12.sp),
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(isiMessage);
    }
  }

  InputDecoration styleBorder(String hint) {
    return InputDecoration(
        suffixIcon: Icon(
          Icons.arrow_drop_down,
          color: neutralCaption,
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(style: BorderStyle.none),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(style: BorderStyle.none),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(style: BorderStyle.none),
        ),
        contentPadding:
            EdgeInsets.symmetric(horizontal: 12.sp, vertical: 16.sp),
        hintText: hint,
        hintStyle: TextStyle(fontSize: 14.sp));
  }
}

class Header extends StatelessWidget {
  const Header({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(gradient: beasiswaBgGradient),
      child: Stack(
        children: [
          Positioned(
            right: -4.w,
            bottom: -6.w,
            child: Opacity(
              opacity: 0.75,
              child: Image.asset(
                'assets/ijazahln/ilus_caript.png',
                width: 182.w,
                height: 182.w,
              ),
            ),
          ),
          Positioned(
            left: 23.w,
            bottom: 25.w,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Cari Perguruan Tinggi\nLuar Negeri",
                  style: TextStyle(
                      color: whiteBgPage,
                      fontWeight: FontWeight.bold,
                      fontSize: 24.sp,
                      letterSpacing: 0.08.sp),
                ),
                SizedBox(
                  height: 12.h,
                ),
                Container(
                  width: 250.w,
                  child: Text(
                    "Cari Perguruan Tinggi berdasarkan negara untuk menyetarakan ijazah anda",
                    style: TextStyle(
                        color: white,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
