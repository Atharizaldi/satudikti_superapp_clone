import 'dart:async';

import 'package:app/presentation/component/constant.dart';
import 'package:app/presentation/pages/beranda/pddikti/bloc/bottom_sheet_form/bottom_sheet_form_bloc.dart';
import 'package:app/presentation/pages/beranda/pddikti/component/bottom_sheet_form/bottom_sheet_provinsi/bloc/bts_provinsi_bloc.dart';
import 'package:app/presentation/pages/beranda/sivil/component/bts_component.dart';
import 'package:app/presentation/pages/beranda/sivil/component/text_field_sivil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logger/logger.dart';

class BottomSheetProvinsi extends StatefulWidget {
  final BuildContext sivilPageContext;
  final Map<String, String> listAllProvinsi;

  BottomSheetProvinsi({
    required this.sivilPageContext,
    required this.listAllProvinsi,
  }) : super();

  @override
  State<BottomSheetProvinsi> createState() => _BottomSheetProvinsiState();
}

class _BottomSheetProvinsiState extends State<BottomSheetProvinsi> {
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
          child: BlocBuilder<BtsProvinsiBloc, BtsProvinsiState>(
            builder: (context, state) {
              Logger().i("BtsProvinsiState : $state");
              if (state is BtsProvinsiNoInternetState) {
                return btsNoInternet();
              } else if (textEditingController.text.isEmpty) {
                return SizedBox();
              } else if (state is BtsProvinsiNotFoundState) {
                return btsNotFound("Provinsi Tidak Ditemukan");
              } else if (state is BtsProvinsiLoadedState) {
                return buildProvinsiList(state.matchesProvinsi);
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
        decoration: styleWithSearchPrefix("Cari Provinsi"),
        onChanged: (value) {
          if (_debounce?.isActive ?? false) _debounce?.cancel();
          _debounce = Timer(const Duration(milliseconds: 1000), () {
            BlocProvider.of<BtsProvinsiBloc>(context).add(
                BtsSearchProvinsiEvent(
                    query: value, listAllProvinsi: widget.listAllProvinsi));
          });
        },
      ),
    );
  }

  Widget buildProvinsiList(List<String> listStringProvinsi) {
    return ListView.builder(
      itemCount: listStringProvinsi.length,
      itemBuilder: (context, index) {
        String namaProvinsi = listStringProvinsi[index];
        return GestureDetector(
          onTap: () {
            BlocProvider.of<BottomSheetFormBloc>(widget.sivilPageContext).add(
                UpdateProvinsiEvent(
                    namaProvinsi: namaProvinsi,
                    kodeProvinsi: widget.listAllProvinsi[namaProvinsi]!));
            FocusManager.instance.primaryFocus?.unfocus();
            Navigator.pop(context);
          },
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
            child: Text(
              "$namaProvinsi",
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
