import 'package:app/data/source/remote/model/IjazahLN/verifikasi/ptIjazahLNList.dart';
import 'package:app/injection.dart' as di;
import 'package:app/presentation/component/constant.dart';
import 'package:app/presentation/component/customAppBar.dart';
import 'package:app/presentation/pages/beranda/ijazahln/bloc/bloc/bts_pt_ijazah_bloc.dart';
import 'package:app/presentation/pages/beranda/ijazahln/bloc/cubit/selectedijazah_cubit.dart';
import 'package:app/presentation/pages/beranda/ijazahln/component/type_field_pt.dart';
import 'package:app/presentation/pages/beranda/ijazahln/pencarianPTLN/bloc/detail_prodi_ptln_bloc.dart';
import 'package:app/presentation/pages/beranda/ijazahln/pencarianPTLN/detailProdiPTLN.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HasilPTLN extends StatefulWidget {
  final String namaNegara;
  final String idNegara;

  const HasilPTLN({Key? key, required this.namaNegara, required this.idNegara})
      : super(key: key);

  @override
  State<HasilPTLN> createState() => _HasilPTLNState();
}

class _HasilPTLNState extends State<HasilPTLN> {
  TextEditingController ptController = new TextEditingController();

  @override
  void initState() {
    ptController.clear();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => di.locator<SelectedijazahCubit>(),
      child: Scaffold(
        backgroundColor: whiteBgPage,
        appBar: CustomAppBar(
          titleWidget: Text(
            "Pencarian Perguruan Tinggi LN",
            style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 24.w, horizontal: 16.w),
            child: Column(
              children: [
                SizedBox(
                  height: 6.w,
                ),
                _searchBar(),
                SizedBox(
                  height: 8.w,
                ),
                _buttonCari(),
                BlocBuilder<BtsPtIjazahBloc, BtsPtIjazahBlocState>(
                  builder: (context, state) {
                    if (state is BtsPtIjazahLoadedState) {
                      return _hasilPT(state.getListPT);
                    } else {
                      return Container();
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _hasilPT(PtIjazahLNList getListPT) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          "Hasil Pencarian",
          style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
              color: blue3,
              height: 1.5.sp),
        ),
        SizedBox(
          height: 8.w,
        ),
        SizedBox(
          height: 20.w,
        ),
        _tableHasilPT(getListPT),
      ],
    );
  }

  Widget _tableHasilPT(PtIjazahLNList getListPT) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 23.w, vertical: 23.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.w),
        color: white,
      ),
      child: DataTable(
          columnSpacing: 12.w,
          dataRowHeight: 65.h,
          columns: [
            DataColumn(
              label: Container(
                width: 200.w,
                child: Text(
                  "Nama Perguruan Tinggi",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 10.sp,
                    color: neutral60,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            DataColumn(
              label: Container(
                width: 104.w,
              ),
            )
          ],
          rows: getListPT.data.perguruanTinggi.asMap().entries.map((pt) {
            return DataRow(
                color: (pt.key + 1).isOdd
                    ? MaterialStateProperty.all(white)
                    : MaterialStateProperty.all(whiteBgPage),
                cells: [
                  DataCell(Container(
                    width: 200.w,
                    child: SelectableText(
                      pt.value.ptName,
                      style: TextStyle(fontSize: 10.sp, color: neutral60),
                    ),
                  )),
                  DataCell(
                    Container(
                      width: 104.w,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (builder) => BlocProvider(
                                        create: (context) =>
                                            di.locator<DetailProdiPtlnBloc>()
                                              ..add(GetDetailProdiPtlnEvent(
                                                idPt: pt.value.ptId,
                                              )),
                                        child: DetailProdiPTLN(
                                          namaPT: pt.value.ptName,
                                        ),
                                      )));
                        },
                        child: Text(
                          "Lihat",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 10.sp,
                            color: blue4,
                          ),
                        ),
                      ),
                    ),
                  )
                ]);
          }).toList()),
    );
  }

  Widget _searchBar() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SelectableText(
          "Perguruan Tinggi di ‘${widget.namaNegara}'",
          style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
              color: blue3,
              height: 1.5.sp),
        ),
        SizedBox(
          height: 20.w,
        ),
        RichText(
          text: TextSpan(children: [
            WidgetSpan(
                child: Image.asset(
              'assets/icons/ijazahln/icon_pt.png',
              width: 16.sp,
              height: 16.sp,
            )),
            WidgetSpan(
                child: SizedBox(
              width: 8.w,
            )),
            TextSpan(
              text: "Nama Perguruan Tinggi",
              style: TextStyle(color: blue4, fontSize: 14.sp),
            ),
            TextSpan(text: '*', style: TextStyle(color: Colors.red))
          ]),
        ),
        SizedBox(height: 8.w),
        TextFieldPTIjazahLuarNegeri(
            ijazahPencarianLuarNegeri: context,
            textEditingController: ptController,
            isChecked: true,
            kodeNegaraParams: widget.idNegara)
      ],
    );
  }

  Widget _buttonCari() {
    return Align(
      alignment: Alignment.centerRight,
      child: GestureDetector(
        onTap: () {
          if (ptController.text.isNotEmpty) {
            _onPressedCari();
          } else {
            SnackBar isiMessage = SnackBar(
              content: Text(
                'Harap isi Perguruan Tinggi terlebih dahulu',
                style: TextStyle(fontSize: 12.sp),
              ),
            );
            ScaffoldMessenger.of(context).showSnackBar(isiMessage);
          }
        },
        child: BlocBuilder<SelectedijazahCubit, bool>(
            builder: (context, isSelected) {
              return Container(
                margin: EdgeInsets.only(top: screenHeight(context) * (1 / 50)),
                height: 48.sp,
                width: 171.sp,
                decoration: BoxDecoration(
                    color: isSelected ? blue4 : buttonDisable,
                    borderRadius: BorderRadius.circular(5)),
                child: Center(
                  child: Text(
                    'Cari',
                    style: TextStyle(
                        color: isSelected ? white : textButtonDisable,
                        fontSize: 12.sp,
                        letterSpacing: 1,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              );
            },
          ),
        ),
    );
  }

  void _onPressedCari() {
    BlocProvider.of<BtsPtIjazahBloc>(context)
      ..add(BtsSearchPtIjazahEvent(
          query: ptController.text, idNegara: widget.idNegara));
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
