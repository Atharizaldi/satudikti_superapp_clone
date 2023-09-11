import 'package:app/data/source/remote/model/IjazahLN/verifikasi/ptIjazahLNList.dart';
import 'package:app/presentation/component/constant.dart';
import 'package:app/presentation/pages/beranda/ijazahln/bloc/bloc/bts_pt_ijazah_bloc.dart';
import 'package:app/presentation/pages/beranda/ijazahln/bloc/ijazahln/verifikasisk/negarapt/negara_bloc.dart';
import 'package:app/presentation/pages/beranda/sivil/component/bts_component.dart';
import 'package:app/presentation/pages/beranda/sivil/component/text_field_sivil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BottomSheetPTIjazah extends StatefulWidget {
  final BuildContext sivilPageContext;
  final String kodeNegaraParams;

  BottomSheetPTIjazah(
      {required this.sivilPageContext, required this.kodeNegaraParams})
      : super();

  @override
  State<BottomSheetPTIjazah> createState() => _BottomSheetPTIjazahState();
}

class _BottomSheetPTIjazahState extends State<BottomSheetPTIjazah> {
  TextEditingController textEditingController = TextEditingController();

  TextStyle textStyle = TextStyle(
      color: neutral30,
      fontWeight: FontWeight.w400,
      fontSize: 14.sp,
      letterSpacing: 0.5);

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: 0.8,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        decoration: BoxDecoration(
          color: whiteBgPage,
          borderRadius: BorderRadius.vertical(top: Radius.circular(12.r)),
        ),
        child: Column(
          children: [
            SizedBox(height: 16.h),
            Container(
              width: 30.w,
              height: 3.h,
              decoration: BoxDecoration(
                color: neutral20,
                borderRadius: BorderRadius.circular(4.r),
              ),
            ),
            SizedBox(height: 16.h),
            Expanded(
              child: content(textEditingController),
            ),
          ],
        ),
      ),
    );
  }

  Widget content(TextEditingController textEditingController) {
    return Column(
      children: [
        searchSection(textEditingController),
        SizedBox(
          height: 20.h,
        ),
        Expanded(
          child: BlocBuilder<BtsPtIjazahBloc, BtsPtIjazahBlocState>(
            builder: (context, state) {
              if (state is BtsPtIjazahNoInternetState) {
                return btsNoInternet();
              } else if (textEditingController.text.isEmpty) {
                return SizedBox();
              } else if (state is BtsPtIjazahNotFoundState) {
                return btsNotFound("Perguruan Tinggi Tidak Ditemukan");
              } else if (state is BtsPtIjazahLoadedState) {
                return buildPTIjazahList(state.getListPT, state.listPtName);
              } else {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(
                      color: blue4,
                    ),
                  ],
                );
              }
            },
          ),
        ),
      ],
    );
  }

  Widget searchSection(TextEditingController textEditingController) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        color: white,
        boxShadow: [
          BoxShadow(color: neutral10, blurRadius: 6, offset: Offset(0, 2))
        ],
      ),
      child: TextFormField(
        autofocus: true,
        style: textStyle.copyWith(color: neutral80),
        controller: textEditingController,
        decoration: styleWithSearchPrefix("Cari Perguruan Tinggi"),
        onChanged: (value) {
          print("INI VALUE IJAZAH $value");
          BlocProvider.of<BtsPtIjazahBloc>(context).add(BtsSearchPtIjazahEvent(
              idNegara: widget.kodeNegaraParams, query: value));
        },
      ),
    );
  }

  Widget buildPTIjazahList(PtIjazahLNList listPT, List<String> listStringPt) {
    return ListView.builder(
      itemCount: listStringPt.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            BlocProvider.of<NegaraBloc>(widget.sivilPageContext).add(
                UpdatePTIjazahEvent(pt: listPT.data.perguruanTinggi[index]));
            FocusManager.instance.primaryFocus?.unfocus();
            Navigator.pop(context);
          },
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
            child: Text(
              "${listStringPt[index]}",
              style: textStyle.copyWith(color: neutral60),
            ),
          ),
        );
      },
    );
  }
}

class BottomSheetPTIjazahLuarNegeri extends StatefulWidget {
  final BuildContext sivilPageContext;
  final String kodeNegaraParams;

  BottomSheetPTIjazahLuarNegeri(
      {required this.sivilPageContext, required this.kodeNegaraParams})
      : super();

  @override
  State<BottomSheetPTIjazahLuarNegeri> createState() =>
      _BottomSheetPTIjazahLuarNegeriState();
}

class _BottomSheetPTIjazahLuarNegeriState
    extends State<BottomSheetPTIjazahLuarNegeri> {
  TextEditingController textEditingController = TextEditingController();

  TextStyle textStyle = TextStyle(
      color: neutral30,
      fontWeight: FontWeight.w400,
      fontSize: 14.sp,
      letterSpacing: 0.5);

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: 0.8,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        decoration: BoxDecoration(
          color: whiteBgPage,
          borderRadius: BorderRadius.vertical(top: Radius.circular(12.r)),
        ),
        child: Column(
          children: [
            SizedBox(height: 16.h),
            Container(
              width: 30.w,
              height: 3.h,
              decoration: BoxDecoration(
                color: neutral20,
                borderRadius: BorderRadius.circular(4.r),
              ),
            ),
            SizedBox(height: 16.h),
            Expanded(
              child: content(textEditingController, widget.sivilPageContext),
            ),
          ],
        ),
      ),
    );
  }

  Widget content(TextEditingController textEditingController, context2) {
    return Column(
      children: [
        searchSection(textEditingController),
        SizedBox(
          height: 20.h,
        ),
        Expanded(
          child: BlocBuilder<BtsPtIjazahBloc, BtsPtIjazahBlocState>(
            builder: (context, state) {
              if (state is BtsPtIjazahNoInternetState) {
                return btsNoInternet();
              } else if (state is BtsPtIjazahNotFoundState) {
                return btsNotFound("Perguruan Tinggi Tidak Ditemukan");
              } else if (state is BtsPtIjazahLoadedState) {
                return buildPTIjazahList(state.getListPT, state.listPtName);
              } else {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(
                      color: blue4,
                    ),
                  ],
                );
              }
            },
          ),
        ),
      ],
    );
  }

  Widget searchSection(TextEditingController textEditingController) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        color: white,
        boxShadow: [
          BoxShadow(color: neutral10, blurRadius: 6, offset: Offset(0, 2))
        ],
      ),
      child: TextFormField(
        autofocus: true,
        style: textStyle.copyWith(color: neutral80),
        controller: textEditingController,
        decoration: styleWithSearchPrefix("Cari Perguruan Tinggi"),
        onChanged: (value) {
          print("INI SEARCH $value");
          BlocProvider.of<BtsPtIjazahBloc>(context).add(BtsSearchPtIjazahEvent(
              idNegara: widget.kodeNegaraParams, query: value));
        },
      ),
    );
  }

  Widget buildPTIjazahList(PtIjazahLNList listPT, List<String> listStringPt) {
    return ListView.builder(
      itemCount: listStringPt.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            BlocProvider.of<NegaraBloc>(widget.sivilPageContext).add(
                UpdatePTIjazahEvent(pt: listPT.data.perguruanTinggi[index]));
            FocusManager.instance.primaryFocus?.unfocus();
            Navigator.pop(context);
          },
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
            child: Text(
              "${listStringPt[index]}",
              style: textStyle.copyWith(color: neutral60),
            ),
          ),
        );
      },
    );
  }
}
