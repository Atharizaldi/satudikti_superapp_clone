import 'dart:async';

import 'package:app/data/source/remote/model/tracer/AnswerKuesioner.dart';
import 'package:app/data/source/remote/model/tracer/getList/getListProdi.dart';
import 'package:app/presentation/component/constant.dart';
import 'package:app/presentation/pages/beranda/tracerStudy/bloc/pencarian_bloc/pencarian_prodi_bloc/pencarian_prodi_bloc.dart';
import 'package:app/presentation/pages/beranda/tracerStudy/bloc/pencarian_bloc/pencarian_prodi_bloc/pencarian_prodi_event.dart';
import 'package:app/presentation/pages/beranda/tracerStudy/bloc/pencarian_bloc/pencarian_prodi_bloc/pencarian_prodi_state.dart';
import 'package:app/presentation/pages/beranda/tracerStudy/component/bts_component.dart';
import 'package:app/presentation/pages/beranda/tracerStudy/component/text_field_tracer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logger/logger.dart';

class BottomSheetProdiTracer extends StatefulWidget {
  final BuildContext kuesionerPageContext;
  final String alumniId;
  final String questionId;
  final String kodePT;
  final Map<String, String> selectedProdiObject;
  final Map<String, AnswerKuesioner> listAnswer;
  final TextEditingController textEditingControllerProdi;

  BottomSheetProdiTracer({
    required this.kuesionerPageContext,
    required this.alumniId,
    required this.questionId,
    required this.kodePT,
    required this.selectedProdiObject,
    required this.listAnswer,
    required this.textEditingControllerProdi,
  }) : super();

  @override
  State<BottomSheetProdiTracer> createState() => _BottomSheetProdiState();
}

class _BottomSheetProdiState extends State<BottomSheetProdiTracer> {
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
          child:
              BlocBuilder<PencarianProdiTracerBloc, PencarianProdiTracerState>(
            builder: (context, state) {
              Logger().i("BtsProdiState : $state");
              if (state is PencarianProdiTracerNoInternetState) {
                return btsNoInternet();
              } else if (textEditingController.text.isEmpty) {
                return SizedBox();
              } else if (state is PencarianProdiTracerErrorState) {
                return btsNotFound("Perguruan Tinggi Tidak Ditemukan");
              } else if (state is PencarianProdiTracerLoadedState) {
                return buildProdiList(state.listProdi);
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
        decoration: styleWithSearchPrefix("Cari Perogram Studi"),
        onChanged: (value) {
          if (_debounce?.isActive ?? false) _debounce?.cancel();
          _debounce = Timer(const Duration(milliseconds: 1000), () {
            BlocProvider.of<PencarianProdiTracerBloc>(context).add(
                GetListProdiTracerEvent(kodePT: widget.kodePT, keyword: value));
          });
        },
      ),
    );
  }

  Widget buildProdiList(List<DataProdiTracer> listProdi) {
    return ListView.builder(
      itemCount: listProdi.length,
      itemBuilder: (context, index) {
        String namaProdi = listProdi[index].namaProdi;
        String kodeProdi = listProdi[index].kodeProdi;
        return GestureDetector(
          onTap: () {
            setState(() {
              widget.selectedProdiObject.clear();
              widget.selectedProdiObject[kodeProdi] = namaProdi;
              widget.textEditingControllerProdi.value = widget
                  .textEditingControllerProdi.value
                  .copyWith(text: namaProdi);
              widget.listAnswer[widget.questionId] = AnswerKuesioner(
                alumniId: widget.alumniId,
                answer: widget.selectedProdiObject.keys.first,
                questionId: widget.questionId,
              );
            });
            Navigator.pop(context, widget.listAnswer);
          },
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
            child: Text(
              "$namaProdi",
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
