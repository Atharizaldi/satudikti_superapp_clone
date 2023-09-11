import 'dart:async';

import 'package:app/data/source/remote/model/tracer/AnswerKuesioner.dart';
import 'package:app/presentation/pages/beranda/tracerStudy/component/bts_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logger/logger.dart';

import '../../../../../../component/constant.dart';
import '../../text_field_tracer.dart';
import 'bloc/bts_Kabupaten_bloc.dart';

class BottomSheetKabupaten extends StatefulWidget {
  final BuildContext kuesionerPageContext;
  final String alumniId;
  final String questionId;
  final Map<String, AnswerKuesioner> listAnswer;
  final Map<String, String> listAllKabupaten;
  final Map<String, String> selectedKabupatenObject;
  final TextEditingController textEditingControllerKabupaten;

  BottomSheetKabupaten({
    required this.kuesionerPageContext,
    required this.listAllKabupaten, 
    required this.selectedKabupatenObject, 
    required this.textEditingControllerKabupaten, 
    required this.listAnswer, 
    required this.alumniId, 
    required this.questionId,
  }) : super();

  @override
  State<BottomSheetKabupaten> createState() => _BottomSheetKabupatenState();
}

class _BottomSheetKabupatenState extends State<BottomSheetKabupaten> {
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
          child: BlocBuilder<BtsTracerKabupatenBloc, BtsKabupatenState>(
            builder: (context, state) {
              Logger().i("BtsKabupatenState : $state");
              if (state is BtsKabupatenNoInternetState) {
                return btsNoInternet();
              } else if (textEditingController.text.isEmpty) {
                return SizedBox();
              } else if (state is BtsKabupatenNotFoundState) {
                return btsNotFound("Kabupaten Tidak Ditemukan");
              } else if (state is BtsKabupatenLoadedState) {
                return buildKabupatenList(state.matchesKabupaten);
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
        decoration: styleWithSearchPrefix("Cari Kabupaten"),
        onChanged: (value) {
          if (_debounce?.isActive ?? false) _debounce?.cancel();
          _debounce = Timer(const Duration(milliseconds: 1000), () {
            BlocProvider.of<BtsTracerKabupatenBloc>(context).add(
                BtsSearchKabupatenEvent(
                    query: value, listAllKabupaten: widget.listAllKabupaten));
          });
        },
      ),
    );
  }

  Widget buildKabupatenList(List<String> listStringKabupaten) {
    return ListView.builder(
      itemCount: listStringKabupaten.length,
      itemBuilder: (context, index) {
        String namaKabupaten = listStringKabupaten[index];
        return GestureDetector(
          onTap: () {
            setState(() {
              widget.selectedKabupatenObject.clear();

              widget.selectedKabupatenObject[widget.listAllKabupaten[namaKabupaten]!] =
                namaKabupaten; 
                
              widget.textEditingControllerKabupaten.value =
                widget.textEditingControllerKabupaten.value.copyWith(text: namaKabupaten);

              widget.listAnswer[widget.questionId] = AnswerKuesioner(
                alumniId: widget.alumniId,
                questionId: widget.questionId,
                answer: widget.selectedKabupatenObject.keys.first
              );
            });
            Navigator.pop(context);
          },
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
            child: Text(
              "$namaKabupaten",
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
