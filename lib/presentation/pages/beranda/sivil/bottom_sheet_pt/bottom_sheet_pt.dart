import 'dart:async';

import 'package:app/data/source/remote/model/pddikti/perguruanTinggi/getListPT.dart';
import 'package:app/presentation/component/constant.dart';
import 'package:app/presentation/pages/beranda/sivil/bloc/sivil_bloc.dart';
import 'package:app/presentation/pages/beranda/sivil/bottom_sheet_pt/bloc/bts_pt_bloc.dart';
import 'package:app/presentation/pages/beranda/sivil/component/bts_component.dart';
import 'package:app/presentation/pages/beranda/sivil/component/text_field_sivil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logger/logger.dart';

class BottomSheetPT extends StatefulWidget {
  final BuildContext sivilPageContext;

  BottomSheetPT({required this.sivilPageContext}) : super();

  @override
  State<BottomSheetPT> createState() => _BottomSheetPTState();
}

class _BottomSheetPTState extends State<BottomSheetPT> {
  TextEditingController textEditingController = TextEditingController();
  Timer? _debounce;

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
          child: BlocBuilder<BtsPtBloc, BtsPtState>(
            builder: (context, state) {
              Logger().i("BtsPtState : $state");
              if (state is BtsPtNoInternetState) {
                return btsNoInternet();
              } else if (textEditingController.text.isEmpty) {
                return SizedBox();
              } else if (state is BtsPtNotFoundState) {
                return btsNotFound("Perguruan Tinggi Tidak Ditemukan");
              } else if (state is BtsPtLoadedState) {
                return buildPtList(state.getListPT, state.listPtName);
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
          if (_debounce?.isActive ?? false) _debounce?.cancel();
          _debounce = Timer(const Duration(milliseconds: 1000), () {
            BlocProvider.of<BtsPtBloc>(context)
                .add(BtsSearchPtEvent(query: value));
          });
        },
      ),
    );
  }

  Widget buildPtList(GetListPT listPt, List<String> listStringPt) {
    return ListView.builder(
      itemCount: listStringPt.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            BlocProvider.of<SivilBloc>(widget.sivilPageContext)
                .add(UpdatePTEvent(pt: listPt.data.perguruanTinggi[index]));
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

  @override
  void dispose() {
    textEditingController.dispose();
    _debounce?.cancel();
    super.dispose();
  }
}
