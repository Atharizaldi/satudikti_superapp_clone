import 'package:app/data/source/remote/model/tracer/AnswerKuesioner.dart';
import 'package:app/injection.dart' as di;
import 'package:app/presentation/component/constant.dart';
import 'package:app/presentation/pages/beranda/pddikti/component/bottom_sheet_form/text_field_pddikti.dart';
import 'package:app/presentation/pages/beranda/tracerStudy/bloc/bottom_sheet_form/bottom_sheet_form_bloc.dart';
import 'package:app/presentation/pages/beranda/tracerStudy/bloc/pencarian_bloc/pencarian_kabupaten_bloc/pencarian_kabupaten_bloc.dart';
import 'package:app/presentation/pages/beranda/tracerStudy/bloc/pencarian_bloc/pencarian_kabupaten_bloc/pencarian_kabupaten_state.dart';
import 'package:app/presentation/pages/beranda/tracerStudy/bloc/pencarian_bloc/pencarian_prodi_bloc/pencarian_prodi_bloc.dart';
import 'package:app/presentation/pages/beranda/tracerStudy/bloc/pencarian_bloc/pencarian_pt_bloc/pencarian_pt_bloc.dart';
import 'package:app/presentation/pages/beranda/tracerStudy/component/buttom_sheet_form/bottom_sheet_kabupaten/bloc/bts_Kabupaten_bloc.dart';
import 'package:app/presentation/pages/beranda/tracerStudy/component/buttom_sheet_form/bottom_sheet_kabupaten/bottom_sheet_kabupaten.dart';
import 'package:app/presentation/pages/beranda/tracerStudy/component/buttom_sheet_form/bottom_sheet_prodi/bottom_sheet_prodi.dart';
import 'package:app/presentation/pages/beranda/tracerStudy/component/buttom_sheet_form/bottom_sheet_provinsi/bloc/bts_provinsi_bloc.dart';
import 'package:app/presentation/pages/beranda/tracerStudy/component/buttom_sheet_form/bottom_sheet_provinsi/bottom_sheet_provinsi.dart';
import 'package:app/presentation/pages/beranda/tracerStudy/component/buttom_sheet_form/bottom_sheet_pt/bottom_sheet_pt.dart';
import 'package:app/presentation/pages/beranda/tracerStudy/component/dialog_component.dart';
import 'package:app/presentation/pages/beranda/tracerStudy/component/txtinput_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../../../data/source/remote/model/tracer/TracerKuesioner.dart';

class PertanyaanKuesioner extends StatefulWidget {
  final BuildContext kuisionerPageContext;
  final String alumniId;
  final List<Question> kuesioner;
  final Map<String, String> selectedPTObject;
  final Map<String, String> selectedProdiObject;
  Map<String, String> selectedProvinsiObject;
  final Map<String, String> selectedKabupatenObject;
  final Map<String, String> listAllProvinsi;
  final Map<String, AnswerKuesioner> answerKuesioner;

  PertanyaanKuesioner({
    required this.kuisionerPageContext,
    required this.alumniId,
    required this.kuesioner,
    required this.selectedPTObject,
    required this.selectedProdiObject,
    required this.selectedProvinsiObject,
    required this.selectedKabupatenObject,
    required this.listAllProvinsi,
    required this.answerKuesioner,
  }) : super();

  @override
  State<PertanyaanKuesioner> createState() => _PertanyaanKuesionerState();
}

class _PertanyaanKuesionerState extends State<PertanyaanKuesioner> {
  TextEditingController textEditingControllerProvinsi = TextEditingController();
  TextEditingController textEditingControllerKabupaten =
      TextEditingController();
  TextEditingController textEditingControllerPT = TextEditingController();
  TextEditingController textEditingControllerProdi = TextEditingController();
  TextEditingController textEditingControllerDummy = TextEditingController();
  TextEditingController dateTextController = TextEditingController();
  bool showExtraAnswer = false;
  String? date;
  String? dateView;

  Map<String, String> _controller = {'a': 'b'};
  Map<String, String> _controllerChild = {'a': 'b'};
  Map<String, TextEditingController> mapTextEditingController = {
    'a': TextEditingController()
  };
  Map<String, bool> mapSingleChoiceController = {'a': false};
  Map<String, bool> mapCheckboxController = {'a': false};
  Map<String, List<String>> mapDropDownController = {'a': []};
  Map<String, int> mapIndexController = {'a': 1};
  Map<String, List<String>> itemsDropDown = {
    'a': ['a']
  };
  Map<String, String> valueDropDown = {'a': 'a'};
  Map<String, List<String>> listAnswerCheckBox = {
    'a': ['a']
  };

  Map<String, String> hasilKabupaten = {'a': 'b'};
  Map<String, String> hasilPT = {'a': 'b'};

  Map<String, String> selectedPTObject = {"kodePT": ""};
  Map<String, String> selectedProdiObject = {"kodeProdi": ""};
  Map<String, String> selectedProvinsiObject = {"kodeProvinsi": ""};
  Map<String, String> selectedKabupatenObject = {"kodeKabupaten": ""};

  DateTime selectedDate = DateTime.now();

  _selectDate(
    BuildContext context,
    int questionId,
    Map<String, AnswerKuesioner> listAnswer,
  ) async {
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
      dateView = DateFormat('yyyy-MM-dd').format(picked);
      print("DateUnFormatted date $date");
      print("Formatted date $dateView");
      // BlocProvider.of<DateCubit>(context).changeDate(dateView!);

      dateTextController.text = dateView!;
      listAnswer[questionId.toString()] = AnswerKuesioner(
        alumniId: widget.alumniId,
        questionId: questionId.toString(),
        answer: date,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(left: 16.w, right: 14.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 24.h,
            ),
            // cek
            for (int i = 0; i < widget.kuesioner.length; i++)
              _fieldPertanyaan(
                kuesioner: widget.kuesioner[i],
                order: widget.kuesioner[i].order,
                controller: _controller,
                controllerChild: _controllerChild,
                listAnswer: widget.answerKuesioner,
              ),
          ],
        ));
  }

  Widget _fieldPertanyaan({
    required Question kuesioner,
    required Map<String, String> controller,
    required Map<String, String> controllerChild,
    required Map<String, AnswerKuesioner> listAnswer,
    required int order,
  }) {
    return Container(
        child: (kuesioner.answerType.answerTypeId == 1)
            ? _kuesionerSingleChoice(
                kuesioner.answerType.answerTypeId,
                order,
                kuesioner.questionId,
                kuesioner.question,
                kuesioner.isRequired,
                kuesioner.hasChild,
                kuesioner.isChild,
                kuesioner.answerList,
                kuesioner.child,
                kuesioner.relationWith,
                controller,
                controllerChild,
                listAnswer,
              )
            : (kuesioner.answerType.answerTypeId == 2)
                ? _kuesionerMultipleChoice(
                    kuesioner.answerType.answerTypeId,
                    order,
                    kuesioner.questionId,
                    kuesioner.question,
                    kuesioner.isRequired,
                    kuesioner.hasChild,
                    kuesioner.isChild,
                    kuesioner.answerList,
                    kuesioner.child,
                    kuesioner.relationWith,
                    controller,
                    controllerChild,
                    listAnswer,
                  )
                : (kuesioner.answerType.answerTypeId == 3)
                    ? _kuesionerDropDown(
                        kuesioner.answerType.answerTypeId,
                        mapIndexController,
                        order,
                        kuesioner.questionId,
                        kuesioner.question,
                        kuesioner.isRequired,
                        kuesioner.isChild,
                        kuesioner.relationWith,
                        kuesioner.answerList,
                        controller,
                        controllerChild,
                        listAnswer,
                      )
                    : (kuesioner.answerType.answerTypeId == 4)
                        ? _kuesionerInputText(
                            kuesioner.answerType.answerTypeId,
                            order,
                            kuesioner.questionId,
                            1,
                            kuesioner.question,
                            kuesioner.isRequired,
                            kuesioner.isChild,
                            kuesioner.hasChild,
                            kuesioner.relationWith,
                            controller,
                            controllerChild,
                            listAnswer,
                          )
                        : (kuesioner.answerType.answerTypeId == 5)
                            ? _kuesionerRange(
                                kuesioner.answerType.answerTypeId,
                                order,
                                kuesioner.questionId,
                                kuesioner.question,
                                kuesioner.isRequired,
                                kuesioner.isChild,
                                kuesioner.relationWith,
                                kuesioner.rangeLabel!,
                                controller,
                                controllerChild,
                                listAnswer,
                              )
                            : (kuesioner.answerType.answerTypeId == 6)
                                // ? Text("asd")
                                ? _kuesionerDate(
                                    kuesioner.answerType.answerTypeId,
                                    order,
                                    kuesioner.questionId,
                                    kuesioner.question,
                                    kuesioner.isRequired,
                                    kuesioner.hasChild,
                                    kuesioner.isChild,
                                    kuesioner.child,
                                    kuesioner.relationWith,
                                    controller,
                                    controllerChild,
                                    listAnswer,
                                  )
                                : (kuesioner.answerType.answerTypeId == 7)
                                    // ? Text("ASDa")
                                    ? _kuesionerWithoutAnswer(
                                        kuesioner.answerType.answerTypeId,
                                        order,
                                        kuesioner.questionId,
                                        kuesioner.question,
                                        kuesioner.isRequired,
                                        kuesioner.hasChild,
                                        kuesioner.isChild,
                                        kuesioner.child,
                                        kuesioner.relationWith,
                                        controller,
                                        controllerChild,
                                        listAnswer,
                                      )
                                    : (kuesioner.answerType.answerTypeId == 8)
                                        ? BlocProvider(
                                            create: (context) => di.locator<
                                                BottomSheetFormTracerBloc>(),
                                            child: Builder(builder: (context) {
                                              return _kuesionerProvinsi(
                                                kuesioner
                                                    .answerType.answerTypeId,
                                                order,
                                                kuesioner.questionId,
                                                kuesioner.question,
                                                kuesioner.sourceData,
                                                kuesioner.isRequired,
                                                kuesioner.isChild,
                                                kuesioner.hasChild,
                                                kuesioner.child,
                                                kuesioner.relationWith,
                                                controller,
                                                controllerChild,
                                                listAnswer,
                                              );
                                            }),
                                          )
                                        : (kuesioner.answerType.answerTypeId ==
                                                9)
                                            ? BlocProvider(
                                                create: (context) => di.locator<
                                                    BottomSheetFormTracerBloc>(),
                                                child:
                                                    Builder(builder: (context) {
                                                  return _kuesionerKabupaten(
                                                    kuesioner.answerType
                                                        .answerTypeId,
                                                    order,
                                                    kuesioner.questionId,
                                                    kuesioner.question,
                                                    kuesioner.sourceData,
                                                    kuesioner.isRequired,
                                                    kuesioner.isChild,
                                                    kuesioner.hasChild,
                                                    kuesioner.child,
                                                    kuesioner.relationWith,
                                                    controller,
                                                    controllerChild,
                                                    listAnswer,
                                                  );
                                                }),
                                              )
                                            : (kuesioner.answerType
                                                        .answerTypeId ==
                                                    10)
                                                ? _kuesionerPT(
                                                    kuesioner.answerType
                                                        .answerTypeId,
                                                    order,
                                                    kuesioner.questionId,
                                                    kuesioner.question,
                                                    kuesioner.sourceData,
                                                    kuesioner.isRequired,
                                                    kuesioner.isChild,
                                                    kuesioner.hasChild,
                                                    kuesioner.child,
                                                    kuesioner.relationWith,
                                                    controller,
                                                    controllerChild,
                                                    listAnswer,
                                                  )
                                                : (kuesioner.answerType
                                                            .answerTypeId ==
                                                        11)
                                                    ? _kuesionerProdi(
                                                        kuesioner.answerType
                                                            .answerTypeId,
                                                        order,
                                                        kuesioner.questionId,
                                                        kuesioner.question,
                                                        kuesioner.sourceData,
                                                        kuesioner.isRequired,
                                                        kuesioner.isChild,
                                                        kuesioner.hasChild,
                                                        kuesioner.child,
                                                        kuesioner.relationWith,
                                                        controller,
                                                        controllerChild,
                                                        listAnswer,
                                                      )
                                                    : (kuesioner.answerType
                                                                .answerTypeId ==
                                                            12)
                                                        ? _kuesionerInputNumber(
                                                            kuesioner.answerType
                                                                .answerTypeId,
                                                            order,
                                                            kuesioner
                                                                .questionId,
                                                            kuesioner.question,
                                                            kuesioner
                                                                .isRequired,
                                                            kuesioner.hasChild,
                                                            kuesioner.isChild,
                                                            kuesioner.child,
                                                            kuesioner
                                                                .relationWith,
                                                            controller,
                                                            controllerChild,
                                                            listAnswer,
                                                          )
                                                        : SizedBox());
  }

  Widget _kuesionerSingleChoice(
    int answertype,
    int index,
    int questionId,
    String question,
    bool isRequired,
    bool hasChild,
    bool isChild,
    List<AnswerList>? answerList,
    List<Child>? childList,
    int? relationWith,
    Map<String, String> controller,
    Map<String, String> controllerChild,
    Map<String, AnswerKuesioner> listAnswer,
  ) {
    return Container(
      margin: EdgeInsets.only(bottom: 24.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                (!isChild)
                    ? Text(
                        index.toString() + ". ",
                        style: TextStyle(
                            color: neutral80,
                            fontSize: 16.sp,
                            letterSpacing: 0.5,
                            fontWeight: FontWeight.w500),
                      )
                    : SizedBox(),
                Container(
                  constraints: BoxConstraints(maxWidth: 296.w),
                  child: RichText(
                    text: TextSpan(
                      children: [
                        WidgetSpan(
                            child: Text(
                          question,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: neutral80,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500),
                        )),
                        isRequired
                            ? TextSpan(
                                text: '*',
                                style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 16.sp,
                                    letterSpacing: 0.5,
                                    fontWeight: FontWeight.w500),
                              )
                            : TextSpan(text: '')
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          (answerList != null)
              ? Padding(
                  padding: EdgeInsets.only(left: 8.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      for (int i = 0; i < answerList.length; i++)
                        _radioButtonVerticalType(
                          answertype,
                          index,
                          questionId,
                          answerList[i].answerListId,
                          answerList[i].answerLabel,
                          answerList[i].extraAnswer,
                          isChild,
                          answerList[i].extraAnswerType,
                          controller,
                          controllerChild,
                          listAnswer,
                        )
                    ],
                  ),
                )
              : SizedBox(),
          (hasChild)
              ? Container(
                  margin: EdgeInsets.only(top: 16.h),
                  child: Column(
                    children: [
                      for (int i = 0; i < childList!.length; i++)
                        (childList[i].answerType.answerTypeId == 12)
                            ? _kuesionerInputNumber(
                                childList[i].answerType.answerTypeId,
                                childList[i].order,
                                childList[i].questionId,
                                childList[i].question,
                                childList[i].isRequired,
                                childList[i].hasChild,
                                childList[i].isChild,
                                childList[i].child,
                                childList[i].relationWith,
                                controller,
                                controllerChild,
                                listAnswer)
                            : (answertype == 4)
                                ? _kuesionerInputText(
                                    childList[i].answerType.answerTypeId,
                                    childList[i].order,
                                    childList[i].questionId,
                                    1,
                                    childList[i].question,
                                    childList[i].isRequired,
                                    childList[i].isChild,
                                    childList[i].hasChild,
                                    childList[i].relationWith,
                                    controller,
                                    controllerChild,
                                    listAnswer)
                                : SizedBox()
                    ],
                  ),
                )
              : SizedBox()
        ],
      ),
    );
  }

  Widget _kuesionerMultipleChoice(
    int answertype,
    int index,
    int questionId,
    String question,
    bool isRequired,
    bool hasChild,
    bool isChild,
    List<AnswerList>? answerList,
    List<Child>? childList,
    int? relationWith,
    Map<String, String> controller,
    Map<String, String> controllerChild,
    Map<String, AnswerKuesioner> listAnswer,
  ) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                (!isChild)
                    ? Text(
                        index.toString() + ". ",
                        style: TextStyle(
                            color: neutral80,
                            fontSize: 16.sp,
                            letterSpacing: 0.5,
                            fontWeight: FontWeight.w500),
                      )
                    : SizedBox(),
                Container(
                  constraints: BoxConstraints(maxWidth: 296.w),
                  child: RichText(
                    text: TextSpan(
                      children: [
                        WidgetSpan(
                            child: Text(
                          question,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: neutral80,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500),
                        )),
                        isRequired
                            ? TextSpan(
                                text: '*',
                                style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 16.sp,
                                    letterSpacing: 0.5,
                                    fontWeight: FontWeight.w500),
                              )
                            : TextSpan(text: '')
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          (answerList != null)
              ? Padding(
                  padding: EdgeInsets.all(2),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      for (int i = 0; i < answerList.length; i++)
                        _checkBoxType(
                          answertype,
                          answerList[i].answerListId,
                          questionId,
                          answerList[i].answerLabel,
                          answerList[i].extraAnswer,
                          mapCheckboxController,
                          isChild,
                          answerList[i].extraAnswerType,
                          controller,
                          controllerChild,
                          listAnswer,
                        )
                    ],
                  ),
                )
              : SizedBox(),
          (hasChild)
              ? Container(
                  child: Column(
                    children: [
                      for (int i = 0; i < childList!.length; i++)
                        _kuesionerInputText(
                          childList[i].answerType.answerTypeId,
                          childList[i].order,
                          childList[i].questionId,
                          childList[i].order,
                          childList[i].question,
                          childList[i].isRequired,
                          childList[i].isChild,
                          childList[i].hasChild,
                          childList[i].relationWith,
                          controller,
                          controllerChild,
                          listAnswer,
                        )
                    ],
                  ),
                )
              : SizedBox()
        ],
      ),
    );
  }

  Widget _kuesionerDropDown(
    int answertype,
    Map<String, int> index,
    int order,
    int questionId,
    String question,
    bool isRequired,
    bool ischild,
    int? relationWith,
    List<AnswerList>? answerList,
    Map<String, String> controller,
    Map<String, String> controllerChild,
    Map<String, AnswerKuesioner> listAnswer,
  ) {
    if (answerList != null) {
      if (index[questionId.toString()] != answerList.length) {
        itemsDropDown[questionId.toString()] = ['Silahkan Pilih'];
        controller[questionId.toString()] = 'Silahkan Pilih';
        for (int i = 0; i < answerList.length; i++) {
          itemsDropDown[questionId.toString()]!.add(answerList[i].answerLabel);
          index[questionId.toString()] = i + 1;
          valueDropDown[answerList[i].answerLabel] =
              answerList[i].answerListId.toString();
        }
      }
    }
    return Container(
      margin: EdgeInsets.only(bottom: 24.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              children: [
                (!ischild)
                    ? TextSpan(
                        text: order.toString() + ". ",
                        style: TextStyle(
                            color: neutral80,
                            fontSize: 16.sp,
                            letterSpacing: 0.5,
                            fontWeight: FontWeight.w500),
                      )
                    : TextSpan(),
                TextSpan(
                  text: question,
                  style: TextStyle(
                      color: neutral80,
                      fontSize: 16.sp,
                      letterSpacing: 0.5,
                      fontWeight: FontWeight.w500),
                ),
                isRequired
                    ? TextSpan(
                        text: '*',
                        style: TextStyle(
                            color: Colors.red,
                            fontSize: 16.sp,
                            letterSpacing: 0.5,
                            fontWeight: FontWeight.w500),
                      )
                    : TextSpan(text: '')
              ],
            ),
          ),
          SizedBox(
            height: 14.h,
          ),
          SizedBox(
            height: 14.h,
          ),
          _dropDown(
            questionId,
            controller,
            listAnswer,
          )
        ],
      ),
    );
  }

  Widget _kuesionerInputText(
    int answertype,
    int index,
    int questionId,
    int answerId,
    String question,
    bool isRequired,
    bool isChild,
    bool hasChild,
    int? relationWith,
    Map<String, String> controller,
    Map<String, String> controllerChild,
    Map<String, AnswerKuesioner> listAnswer,
  ) {
    final splitted = question.split('[SPLIT]');
    return Container(
      margin: EdgeInsets.only(bottom: 24.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                (!isChild)
                    ? Text(
                        index.toString() + ". ",
                        style: TextStyle(
                            color: neutral80,
                            fontSize: 16.sp,
                            letterSpacing: 0.5,
                            fontWeight: FontWeight.w500),
                      )
                    : SizedBox(),
                Container(
                  constraints: BoxConstraints(maxWidth: 300.w),
                  child: RichText(
                    text: TextSpan(
                      children: [
                        WidgetSpan(
                            child: Text(
                          splitted.first,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: neutral80,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500),
                        )),
                        isRequired
                            ? TextSpan(
                                text: '*',
                                style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 16.sp,
                                    letterSpacing: 0.5,
                                    fontWeight: FontWeight.w500),
                              )
                            : TextSpan(text: '')
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 14.h,
          ),
          _formTypeString(
            answertype,
            relationWith,
            "Masukkan Jawaban",
            'text',
            index,
            questionId,
            answerId,
            isChild,
            false,
            controller,
            controllerChild,
            mapTextEditingController,
            listAnswer,
          ),
          SizedBox(
            height: 8.h,
          ),
          (splitted.length > 1) ? Text(splitted[1]) : SizedBox(),
        ],
      ),
    );
  }

  Widget _kuesionerRange(
    int answertype,
    int index,
    int questionId,
    String question,
    bool isRequired,
    bool isChild,
    int? relationWith,
    List<String> rangeLabel,
    Map<String, String> controller,
    Map<String, String> controllerChild,
    Map<String, AnswerKuesioner> listAnswer,
  ) {
    String start = rangeLabel.first;
    String end = rangeLabel.last;
    return Container(
      margin: EdgeInsets.only(bottom: 24.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                (!isChild)
                    ? Text(
                        index.toString() + ". ",
                        style: TextStyle(
                            color: neutral80,
                            fontSize: 16.sp,
                            letterSpacing: 0.5,
                            fontWeight: FontWeight.w500),
                      )
                    : SizedBox(),
                Container(
                  constraints: BoxConstraints(maxWidth: 250.w),
                  child: RichText(
                    text: TextSpan(
                      children: [
                        WidgetSpan(
                            child: Text(
                          question,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: neutral80,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500),
                        )),
                        isRequired
                            ? TextSpan(
                                text: '*',
                                style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 16.sp,
                                    letterSpacing: 0.5,
                                    fontWeight: FontWeight.w500),
                              )
                            : TextSpan(text: '')
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 8.h,
          ),
          (isChild)
              ? Container(
                  width: double.infinity,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      for (int i = 1; i <= 5; i++)
                        _radioButtonHorizontalType(
                          i,
                          questionId,
                          question,
                          isChild,
                          controller,
                          controllerChild,
                          listAnswer,
                        )
                    ],
                  ))
              : SizedBox(),
          SizedBox(
            height: 12.h,
          ),
          Container(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    alignment: Alignment.centerLeft,
                    child: Center(
                      child: Column(
                        children: [
                          Text(start.substring(0, 5)),
                          Text(start.substring(6)),
                        ],
                      ),
                    )),
                SizedBox(
                  width: 120.w,
                ),
                Container(
                    alignment: Alignment.centerRight,
                    child: Center(
                      child: Column(
                        children: [
                          Text(end.substring(0, 6)),
                          Text(end.substring(7)),
                        ],
                      ),
                    ))
              ],
            ),
          ),
          SizedBox(
            height: 24.h,
          ),
          Divider(
            color: neutral20,
            thickness: 1,
            indent: 1,
            endIndent: 1,
          ),
        ],
      ),
    );
  }

  Widget _kuesionerWithoutAnswer(
    int answertype,
    int index,
    int questionId,
    String question,
    bool isRequired,
    bool hasChild,
    bool isChild,
    List<Child>? childList,
    int? relationWith,
    Map<String, String> controller,
    Map<String, String> controllerChild,
    Map<String, AnswerKuesioner> listAnswer,
  ) {
    return Container(
      margin: EdgeInsets.only(bottom: 24.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                (!isChild)
                    ? Text(
                        index.toString() + ". ",
                        style: TextStyle(
                            color: neutral80,
                            fontSize: 16.sp,
                            letterSpacing: 0.5,
                            fontWeight: FontWeight.w500),
                      )
                    : SizedBox(),
                Container(
                  constraints: BoxConstraints(maxWidth: 300.w),
                  child: RichText(
                    text: TextSpan(
                      children: [
                        WidgetSpan(
                            child: Text(
                          question,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: neutral80,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500),
                        )),
                        isRequired
                            ? TextSpan(
                                text: '*',
                                style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 16.sp,
                                    letterSpacing: 0.5,
                                    fontWeight: FontWeight.w500),
                              )
                            : TextSpan(text: '')
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          (childList != null)
              ? Container(
                  margin: EdgeInsets.only(top: 14.h, left: 20.w, right: 16.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      for (int i = 0; i < childList.length; i++)
                        ((childList[i].answerType.answerTypeId == 1)
                            ? _kuesionerSingleChoice(
                                childList[i].answerType.answerTypeId,
                                childList[i].order,
                                childList[i].questionId,
                                childList[i].question,
                                childList[i].isRequired,
                                childList[i].hasChild,
                                childList[i].isChild,
                                childList[i].answerList,
                                childList[i].child,
                                childList[i].relationWith,
                                controller,
                                controllerChild,
                                listAnswer,
                              )
                            : (childList[i].answerType.answerTypeId == 2)
                                ? _kuesionerMultipleChoice(
                                    childList[i].answerType.answerTypeId,
                                    childList[i].order,
                                    childList[i].questionId,
                                    childList[i].question,
                                    childList[i].isRequired,
                                    childList[i].hasChild,
                                    childList[i].isChild,
                                    childList[i].answerList,
                                    childList[i].child,
                                    childList[i].relationWith,
                                    controller,
                                    controllerChild,
                                    listAnswer,
                                  )
                                : (childList[i].answerType.answerTypeId == 3)
                                    ? _kuesionerDropDown(
                                        childList[i].answerType.answerTypeId,
                                        mapIndexController,
                                        childList[i].order,
                                        childList[i].questionId,
                                        childList[i].question,
                                        childList[i].isRequired,
                                        childList[i].isChild,
                                        childList[i].relationWith,
                                        childList[i].answerList,
                                        controller,
                                        controllerChild,
                                        listAnswer,
                                      )
                                    : (childList[i].answerType.answerTypeId ==
                                            4)
                                        ? _kuesionerInputText(
                                            childList[i]
                                                .answerType
                                                .answerTypeId,
                                            childList[i].order,
                                            childList[i].questionId,
                                            childList[i].order,
                                            childList[i].question,
                                            childList[i].isRequired,
                                            childList[i].isChild,
                                            childList[i].hasChild,
                                            childList[i].relationWith,
                                            controller,
                                            controllerChild,
                                            listAnswer,
                                          )
                                        : (childList[i]
                                                    .answerType
                                                    .answerTypeId ==
                                                5)
                                            ? _kuesionerRange(
                                                childList[i]
                                                    .answerType
                                                    .answerTypeId,
                                                childList[i].order,
                                                childList[i].questionId,
                                                childList[i].question,
                                                childList[i].isRequired,
                                                childList[i].isChild,
                                                childList[i].relationWith,
                                                childList[i].rangeLabel!,
                                                controller,
                                                controllerChild,
                                                listAnswer,
                                              )
                                            : (childList[i]
                                                        .answerType
                                                        .answerTypeId ==
                                                    6)
                                                ? _kuesionerDate(
                                                    childList[i]
                                                        .answerType
                                                        .answerTypeId,
                                                    childList[i].order,
                                                    childList[i].questionId,
                                                    childList[i].question,
                                                    childList[i].isRequired,
                                                    childList[i].hasChild,
                                                    childList[i].isChild,
                                                    childList[i].child,
                                                    childList[i].relationWith,
                                                    controller,
                                                    controllerChild,
                                                    listAnswer)
                                                : (childList[i]
                                                            .answerType
                                                            .answerTypeId ==
                                                        7)
                                                    ? _kuesionerWithoutAnswer(
                                                        childList[i]
                                                            .answerType
                                                            .answerTypeId,
                                                        childList[i].order,
                                                        childList[i].questionId,
                                                        childList[i].question,
                                                        childList[i].isRequired,
                                                        childList[i].hasChild,
                                                        childList[i].isChild,
                                                        childList[i].child,
                                                        childList[i]
                                                            .relationWith,
                                                        controller,
                                                        controllerChild,
                                                        listAnswer,
                                                      )
                                                    : (childList[i]
                                                                .answerType
                                                                .answerTypeId ==
                                                            8)
                                                        ? BlocProvider(
                                                            create: (context) =>
                                                                di.locator<
                                                                    BottomSheetFormTracerBloc>(),
                                                            child: Builder(
                                                                builder:
                                                                    (context) {
                                                              return _kuesionerProvinsi(
                                                                childList[i]
                                                                    .answerType
                                                                    .answerTypeId,
                                                                childList[i]
                                                                    .order,
                                                                childList[i]
                                                                    .questionId,
                                                                childList[i]
                                                                    .question,
                                                                childList[i]
                                                                    .sourceData,
                                                                childList[i]
                                                                    .isRequired,
                                                                childList[i]
                                                                    .hasChild,
                                                                childList[i]
                                                                    .isChild,
                                                                childList[i]
                                                                    .child,
                                                                childList[i]
                                                                    .relationWith,
                                                                controller,
                                                                controllerChild,
                                                                listAnswer,
                                                              );
                                                            }),
                                                          )
                                                        : (childList[i]
                                                                    .answerType
                                                                    .answerTypeId ==
                                                                9)
                                                            ? BlocProvider(
                                                                create: (context) =>
                                                                    di.locator<
                                                                        BottomSheetFormTracerBloc>(),
                                                                child: Builder(
                                                                    builder:
                                                                        (context) {
                                                                  return _kuesionerKabupaten(
                                                                    childList[i]
                                                                        .answerType
                                                                        .answerTypeId,
                                                                    childList[i]
                                                                        .order,
                                                                    childList[i]
                                                                        .questionId,
                                                                    childList[i]
                                                                        .question,
                                                                    childList[i]
                                                                        .sourceData,
                                                                    childList[i]
                                                                        .isRequired,
                                                                    childList[i]
                                                                        .hasChild,
                                                                    childList[i]
                                                                        .isChild,
                                                                    childList[i]
                                                                        .child,
                                                                    childList[i]
                                                                        .relationWith,
                                                                    controller,
                                                                    controllerChild,
                                                                    listAnswer,
                                                                  );
                                                                }),
                                                              )
                                                            : (childList[i]
                                                                        .answerType
                                                                        .answerTypeId ==
                                                                    10)
                                                                ? _kuesionerPT(
                                                                    childList[i]
                                                                        .answerType
                                                                        .answerTypeId,
                                                                    childList[i]
                                                                        .order,
                                                                    childList[i]
                                                                        .questionId,
                                                                    childList[i]
                                                                        .question,
                                                                    childList[i]
                                                                        .sourceData,
                                                                    childList[i]
                                                                        .isRequired,
                                                                    childList[i]
                                                                        .hasChild,
                                                                    childList[i]
                                                                        .isChild,
                                                                    childList[i]
                                                                        .child,
                                                                    childList[i]
                                                                        .relationWith,
                                                                    controller,
                                                                    controllerChild,
                                                                    listAnswer,
                                                                  )
                                                                : (childList[i]
                                                                            .answerType
                                                                            .answerTypeId ==
                                                                        11)
                                                                    ? _kuesionerProdi(
                                                                        childList[i]
                                                                            .answerType
                                                                            .answerTypeId,
                                                                        childList[i]
                                                                            .order,
                                                                        childList[i]
                                                                            .questionId,
                                                                        childList[i]
                                                                            .question,
                                                                        childList[i]
                                                                            .sourceData,
                                                                        childList[i]
                                                                            .isRequired,
                                                                        childList[i]
                                                                            .hasChild,
                                                                        childList[i]
                                                                            .isChild,
                                                                        childList[i]
                                                                            .child,
                                                                        childList[i]
                                                                            .relationWith,
                                                                        controller,
                                                                        controllerChild,
                                                                        listAnswer,
                                                                      )
                                                                    : SizedBox()),
                    ],
                  ),
                )
              : SizedBox()
        ],
      ),
    );
  }

  Widget _kuesionerDate(
    int answertype,
    int index,
    int questionId,
    String question,
    bool isRequired,
    bool hasChild,
    bool isChild,
    List<Child>? childList,
    int? relationWith,
    Map<String, String> controller,
    Map<String, String> controllerChild,
    Map<String, AnswerKuesioner> listAnswer,
  ) {
    return Container(
      margin: EdgeInsets.only(bottom: 24.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                (!isChild)
                    ? Text(
                        index.toString() + ". ",
                        style: TextStyle(
                            color: neutral80,
                            fontSize: 16.sp,
                            letterSpacing: 0.5,
                            fontWeight: FontWeight.w500),
                      )
                    : SizedBox(),
                Container(
                  constraints: BoxConstraints(maxWidth: 300.w),
                  child: RichText(
                    text: TextSpan(
                      children: [
                        WidgetSpan(
                            child: Text(
                          question,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: neutral80,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500),
                        )),
                        isRequired
                            ? TextSpan(
                                text: '*',
                                style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 16.sp,
                                    letterSpacing: 0.5,
                                    fontWeight: FontWeight.w500),
                              )
                            : TextSpan(text: '')
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 14.h,
          ),
          _formTypeDate(
            'Masukkan Jawaban',
            questionId,
            listAnswer,
          )
        ],
      ),
    );
  }

  Widget _kuesionerProvinsi(
    int answertype,
    int index,
    int questionId,
    String question,
    String? sourceData,
    bool isRequired,
    bool isChild,
    bool hasChild,
    List<Child>? childList,
    int? relationWith,
    Map<String, String> controller,
    Map<String, String> controllerChild,
    Map<String, AnswerKuesioner> listAnswer,
  ) {
    return Container(
      margin: EdgeInsets.only(bottom: 24.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                (isChild)
                    ? Text(
                        index.toString() + ". ",
                        style: TextStyle(
                            color: neutral80,
                            fontSize: 16.sp,
                            letterSpacing: 0.5,
                            fontWeight: FontWeight.w500),
                      )
                    : SizedBox(),
                Container(
                  constraints: BoxConstraints(maxWidth: 300.w),
                  child: RichText(
                    text: TextSpan(
                      children: [
                        WidgetSpan(
                            child: Text(
                          question,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: neutral80,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500),
                        )),
                        isRequired
                            ? TextSpan(
                                text: '*',
                                style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 16.sp,
                                    letterSpacing: 0.5,
                                    fontWeight: FontWeight.w500),
                              )
                            : TextSpan(text: '')
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 8.h,
          ),
          _formTypeString(
            answertype,
            relationWith,
            'Silahkan Pilih',
            'provinsi',
            index,
            questionId,
            1,
            isChild,
            false,
            controller,
            controllerChild,
            mapTextEditingController,
            listAnswer,
          )
        ],
      ),
    );
  }

  Widget _kuesionerPT(
    int answertype,
    int index,
    int questionId,
    String question,
    String? sourceData,
    bool isRequired,
    bool isChild,
    bool hasChild,
    List<Child>? childList,
    int? relationWith,
    Map<String, String> controller,
    Map<String, String> controllerChild,
    Map<String, AnswerKuesioner> listAnswer,
  ) {
    return Container(
      margin: EdgeInsets.only(bottom: 24.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                (isChild)
                    ? Text(
                        index.toString() + ". ",
                        style: TextStyle(
                            color: neutral80,
                            fontSize: 16.sp,
                            letterSpacing: 0.5,
                            fontWeight: FontWeight.w500),
                      )
                    : SizedBox(),
                Container(
                  constraints: BoxConstraints(maxWidth: 300.w),
                  child: RichText(
                    text: TextSpan(
                      children: [
                        WidgetSpan(
                            child: Text(
                          question,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: neutral80,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500),
                        )),
                        isRequired
                            ? TextSpan(
                                text: '*',
                                style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 16.sp,
                                    letterSpacing: 0.5,
                                    fontWeight: FontWeight.w500),
                              )
                            : TextSpan(text: '')
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 14.h,
          ),
          _formTypeString(
            answertype,
            relationWith,
            'Silahkan Pilih',
            'pt',
            index,
            questionId,
            1,
            isChild,
            false,
            controller,
            controllerChild,
            mapTextEditingController,
            listAnswer,
          )
        ],
      ),
    );
  }

  Widget _kuesionerProdi(
    int answertype,
    int index,
    int questionId,
    String question,
    String? sourceData,
    bool isRequired,
    bool isChild,
    bool hasChild,
    List<Child>? childList,
    int? relationWith,
    Map<String, String> controller,
    Map<String, String> controllerChild,
    Map<String, AnswerKuesioner> listAnswer,
  ) {
    return Container(
      margin: EdgeInsets.only(bottom: 24.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                (isChild)
                    ? Text(
                        index.toString() + ". ",
                        style: TextStyle(
                            color: neutral80,
                            fontSize: 16.sp,
                            letterSpacing: 0.5,
                            fontWeight: FontWeight.w500),
                      )
                    : SizedBox(),
                Container(
                  constraints: BoxConstraints(maxWidth: 300.w),
                  child: RichText(
                    text: TextSpan(
                      children: [
                        WidgetSpan(
                            child: Text(
                          question,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: neutral80,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500),
                        )),
                        isRequired
                            ? TextSpan(
                                text: '*',
                                style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 16.sp,
                                    letterSpacing: 0.5,
                                    fontWeight: FontWeight.w500),
                              )
                            : TextSpan(text: '')
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 14.h,
          ),
          _formTypeString(
            answertype,
            relationWith,
            'Silahkan Pilih',
            'prodi',
            index,
            questionId,
            1,
            isChild,
            false,
            controller,
            controllerChild,
            mapTextEditingController,
            listAnswer,
          )
        ],
      ),
    );
  }

  Widget _kuesionerKabupaten(
    int answertype,
    int index,
    int questionId,
    String question,
    String? sourceData,
    bool isRequired,
    bool hasChild,
    bool isChild,
    List<Child>? childList,
    int? relationWith,
    Map<String, String> controller,
    Map<String, String> controllerChild,
    Map<String, AnswerKuesioner> listAnswer,
  ) {
    return Container(
      margin: EdgeInsets.only(bottom: 24.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                (!isChild)
                    ? Text(
                        index.toString() + ". ",
                        style: TextStyle(
                            color: neutral80,
                            fontSize: 16.sp,
                            letterSpacing: 0.5,
                            fontWeight: FontWeight.w500),
                      )
                    : SizedBox(),
                Container(
                  constraints: BoxConstraints(maxWidth: 300.w),
                  child: RichText(
                    text: TextSpan(
                      children: [
                        WidgetSpan(
                            child: Text(
                          question,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: neutral80,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500),
                        )),
                        isRequired
                            ? TextSpan(
                                text: '*',
                                style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 16.sp,
                                    letterSpacing: 0.5,
                                    fontWeight: FontWeight.w500),
                              )
                            : TextSpan(text: '')
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 8.h,
          ),
          _formTypeString(
            answertype,
            relationWith,
            'Silahkan Pilih',
            'kabupaten',
            index,
            questionId,
            1,
            isChild,
            false,
            controller,
            controllerChild,
            mapTextEditingController,
            listAnswer,
          )
        ],
      ),
    );
  }

  Widget _kuesionerInputNumber(
    int answertype,
    int index,
    int questionId,
    String question,
    bool isRequired,
    bool hasChild,
    bool isChild,
    List<Child>? childList,
    int? relationWith,
    Map<String, String> controller,
    Map<String, String> controllerChild,
    Map<String, AnswerKuesioner> listAnswer,
  ) {
    final splitted = question.split('[SPLIT]');
    return Container(
      margin: EdgeInsets.only(bottom: 24.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                (!isChild)
                    ? Text(
                        index.toString() + ". ",
                        style: TextStyle(
                            color: neutral80,
                            fontSize: 16.sp,
                            letterSpacing: 0.5,
                            fontWeight: FontWeight.w500),
                      )
                    : SizedBox(),
                Container(
                  constraints: BoxConstraints(maxWidth: 296.w),
                  child: RichText(
                    text: TextSpan(
                      children: [
                        WidgetSpan(
                            child: Text(
                          splitted.first,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: neutral80,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500),
                        )),
                        isRequired
                            ? TextSpan(
                                text: '*',
                                style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 16.sp,
                                    letterSpacing: 0.5,
                                    fontWeight: FontWeight.w500),
                              )
                            : TextSpan(text: '')
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 14.h,
          ),
          _formTypeNumber(
            answertype,
            'Masukkan Jawaban',
            index,
            questionId,
            1,
            isChild,
            false,
            controller,
            controllerChild,
            mapTextEditingController,
            listAnswer,
          ),
          SizedBox(
            height: 8.h,
          ),
          (splitted.length > 1) ? Text(splitted[1]) : SizedBox(),
          (hasChild)
              ? Container(
                  child: Column(
                    children: [
                      for (int i = 0; i < childList!.length; i++)
                        _kuesionerInputText(
                          childList[i].answerType.answerTypeId,
                          childList[i].order,
                          childList[i].questionId,
                          1,
                          childList[i].question,
                          childList[i].isRequired,
                          childList[i].isChild,
                          childList[i].hasChild,
                          childList[i].relationWith,
                          controller,
                          controllerChild,
                          listAnswer,
                        )
                    ],
                  ),
                )
              : SizedBox()
        ],
      ),
    );
  }

  Widget _dropDown(
    int questionId,
    Map<String, String> controller,
    Map<String, AnswerKuesioner> listAnswer,
  ) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.r),
        border: Border.all(color: abu6, width: 1),
      ),
      width: MediaQuery.of(context).size.width,
      height: 60.h,
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
            isExpanded: true,
            iconSize: 20.w,
            style: TextStyle(
              fontSize: 14.sp,
              color: neutral60,
              fontWeight: FontWeight.w400,
            ),
            value: controller[questionId.toString()].toString(),
            items: itemsDropDown[questionId.toString()]!.map((String e) {
              return DropdownMenuItem(
                child: Text(e),
                value: e,
              );
            }).toList(),
            onChanged: (String? value) {
              setState(() {
                controller[questionId.toString()] = value!;
                if (value != 'Silahkan Pilih') {
                  listAnswer[questionId.toString()] = AnswerKuesioner(
                      alumniId: widget.alumniId,
                      answer: valueDropDown[value],
                      questionId: questionId.toString());
                }
                print(listAnswer[questionId.toString()]?.toJson());
              });
            }),
      ),
    );
  }

  Widget _formTypeString(
    int answeType,
    int? relationWith,
    String hintText,
    String type,
    int index,
    int questionId,
    int answerId,
    bool isChild,
    bool isExtraAnswer,
    Map<String, String> controller,
    Map<String, String> controllerChild,
    Map<String, TextEditingController> _textEditingController,
    Map<String, AnswerKuesioner> listAnswer,
  ) {
    if (type == 'provinsi') {
      return GestureDetector(
        onTap: () {
          showModalBottomSheet(
            isScrollControlled: true,
            isDismissible: true,
            backgroundColor: Colors.transparent,
            context: widget.kuisionerPageContext,
            builder: (context) {
              return BlocProvider(
                  create: (context) => di.locator<BtsTracerProvinsiBloc>(),
                  child: BottomSheetProvinsi(
                    kuesionerPageContext: widget.kuisionerPageContext,
                    listAllProvinsi: widget.listAllProvinsi,
                    selectedProvinsiObject: selectedProvinsiObject,
                    textEditingControllerProvinsi:
                        textEditingControllerProvinsi,
                    listAnswer: listAnswer,
                    alumniId: widget.alumniId,
                    questionId: questionId.toString(),
                  ));
            },
          );
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.r),
            color: white,
          ),
          child: TextFormField(
            style: TextStyle(
              fontSize: 14.sp,
              color: neutral60,
              fontWeight: FontWeight.w400,
            ),
            controller: textEditingControllerProvinsi,
            decoration: styleBorder("--Provinsi--"),
            enabled: false,
          ),
        ),
      );
    } else if (type == 'kabupaten') {
      return BlocBuilder<PencarianKabupatenTracerBloc,
          PencarianKabupatenTracerState>(
        builder: (context, state) {
          hasilKabupaten =
              BlocProvider.of<PencarianKabupatenTracerBloc>(context)
                  .hasilKabupaten;
          if (state is PencarianKabupatenTracerLoadedState) {
            return GestureDetector(
              onTap: () {
                if (relationWith == null) {
                  YYDialogWarningFieldEmpty(context, 'Provinsi');
                } else {
                  if (listAnswer[relationWith.toString()] != null) {
                    showModalBottomSheet(
                      isScrollControlled: true,
                      isDismissible: true,
                      backgroundColor: Colors.transparent,
                      context: widget.kuisionerPageContext,
                      builder: (context) {
                        return BlocProvider(
                            create: (context) =>
                                di.locator<BtsTracerKabupatenBloc>(),
                            child: BottomSheetKabupaten(
                              kuesionerPageContext: widget.kuisionerPageContext,
                              listAllKabupaten: hasilKabupaten,
                              selectedKabupatenObject: selectedKabupatenObject,
                              textEditingControllerKabupaten:
                                  textEditingControllerKabupaten,
                              alumniId: widget.alumniId,
                              listAnswer: listAnswer,
                              questionId: questionId.toString(),
                            ));
                      },
                    );
                  } else {
                    YYDialogWarningFieldEmpty(context, 'Provinsi');
                  }
                }
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.r),
                  color: textEditingControllerKabupaten.value == null
                      ? neutral10
                      : white,
                ),
                child: TextFormField(
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: neutral60,
                    fontWeight: FontWeight.w400,
                  ),
                  controller: textEditingControllerKabupaten,
                  decoration: styleBorder("--Kabupaten--"),
                  enabled: false,
                ),
              ),
            );
          } else {
            return GestureDetector(
              onTap: () {
                YYDialogWarningFieldEmpty(context, 'Provinsi');
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.r),
                  color: neutral10,
                ),
                child: TextFormField(
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: neutral60,
                    fontWeight: FontWeight.w400,
                  ),
                  controller: textEditingControllerKabupaten,
                  decoration: styleBorder("--Kabupaten--"),
                  enabled: false,
                ),
              ),
            );
          }
        },
      );
    } else if (type == 'pt') {
      return GestureDetector(
        onTap: () {
          showModalBottomSheet(
            isScrollControlled: true,
            isDismissible: true,
            backgroundColor: Colors.transparent,
            context: widget.kuisionerPageContext,
            builder: (context) {
              return BlocProvider(
                  create: (context) => di.locator<PencarianPtTracerBloc>(),
                  child: BottomSheetPTTracer(
                      kuesionerPageContext: widget.kuisionerPageContext,
                      alumniId: widget.alumniId,
                      questionId: questionId.toString(),
                      selectedPTObject: selectedPTObject,
                      listAnswer: listAnswer,
                      textEditingControllerPT: textEditingControllerPT));
            },
          );
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.r),
            color: white,
          ),
          child: TextFormField(
            style: TextStyle(
              fontSize: 14.sp,
              color: neutral60,
              fontWeight: FontWeight.w400,
            ),
            controller: textEditingControllerPT,
            decoration: styleBorder("--Perguruan Tinggi--"),
            enabled: false,
          ),
        ),
      );
    } else if (type == 'prodi') {
      return GestureDetector(
        onTap: () {
          if (relationWith != null) {
            if (listAnswer[relationWith.toString()] != null) {
              showModalBottomSheet(
                isScrollControlled: true,
                isDismissible: true,
                backgroundColor: Colors.transparent,
                context: widget.kuisionerPageContext,
                builder: (context) {
                  return BlocProvider(
                    create: (context) => di.locator<PencarianProdiTracerBloc>(),
                    child: BottomSheetProdiTracer(
                        kuesionerPageContext: widget.kuisionerPageContext,
                        alumniId: widget.alumniId,
                        questionId: questionId.toString(),
                        kodePT: listAnswer[relationWith.toString()]!.answer!,
                        selectedProdiObject: selectedProdiObject,
                        listAnswer: listAnswer,
                        textEditingControllerProdi: textEditingControllerProdi),
                  );
                },
              );
            } else {
              YYDialogWarningFieldEmpty(context, 'Perguruan Tinggi');
            }
          } else {
            YYDialogWarningFieldEmpty(context, 'Perguruan Tinggi');
          }
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.r),
            color: textEditingControllerPT.value.text == '' ? neutral10 : white,
          ),
          child: TextFormField(
            style: TextStyle(
              fontSize: 14.sp,
              color: neutral60,
              fontWeight: FontWeight.w400,
            ),
            controller: textEditingControllerProdi,
            decoration: styleBorder("--Perogram Studi--"),
            enabled: false,
          ),
        ),
      );
    } else if (type == 'text') {
      return Container(
          decoration: BoxDecoration(
              color: white, borderRadius: BorderRadius.circular(5.r)),
          child: TextFormField(
            style: hintTextStyle.copyWith(color: neutral90),
            controller: _textEditingController[questionId],
            decoration: inputDecorationTextInput(
              color: white,
              hintText: hintText,
            ),
            onChanged: (v) {
              setState(() {
                _textEditingController[questionId]?.text = v;
                if (isExtraAnswer) {
                  listAnswer[questionId.toString()] = AnswerKuesioner(
                    alumniId: widget.alumniId,
                    answer: listAnswer[questionId.toString()]!.answer,
                    extraAnswer: v,
                    questionId: questionId.toString(),
                  );
                } else {
                  listAnswer[questionId.toString()] = AnswerKuesioner(
                    alumniId: widget.alumniId,
                    answer: v,
                    questionId: questionId.toString(),
                  );
                }
              });
            },
          ));
    }
    return SizedBox();
  }

  Widget _formTypeDate(
    String hintText,
    int questionId,
    Map<String, AnswerKuesioner> listAnswer,
  ) {
    return Container(
        decoration: BoxDecoration(
            color: white, borderRadius: BorderRadius.circular(5.r)),
        child: GestureDetector(
          onTap: () {
            setState(() {
              _selectDate(context, questionId, listAnswer);
            });
          },
          child: Container(
            color: white,
            child: IgnorePointer(
              child: TextFormField(
                readOnly: true,
                style: hintTextStyle.copyWith(color: neutral80),
                controller: dateTextController,
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
        ));
  }

  Widget _formTypeNumber(
    int answeType,
    String hintText,
    int index,
    int questionId,
    int answerId,
    bool isChild,
    bool isExtraAnswer,
    Map<String, String> controller,
    Map<String, String> controllerChild,
    Map<String, TextEditingController> _textEditingController,
    Map<String, AnswerKuesioner> listAnswer,
  ) {
    return Container(
      decoration:
          BoxDecoration(color: white, borderRadius: BorderRadius.circular(5.r)),
      child: TextFormField(
        keyboardType: TextInputType.number,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly
        ],
        style: hintTextStyle.copyWith(color: neutral90),
        controller: _textEditingController[questionId],
        decoration: inputDecorationTextInput(
          color: white,
          hintText: hintText,
        ),
        onChanged: (v) {
          setState(() {
            _textEditingController[questionId]?.text = v;
            if (isExtraAnswer) {
              listAnswer[questionId.toString()] = AnswerKuesioner(
                alumniId: widget.alumniId,
                answer: listAnswer[questionId.toString()]!.answer,
                extraAnswer: v,
                questionId: questionId.toString(),
              );
            } else {
              listAnswer[questionId.toString()] = AnswerKuesioner(
                alumniId: widget.alumniId,
                answer: v,
                questionId: questionId.toString(),
              );
            }
          });
        },
      ),
    );
  }

  Widget _radioButtonVerticalType(
    int answerType,
    int index,
    int questionId,
    int answerId,
    String answerLabel,
    bool hasExtraAnswer,
    bool isChild,
    String? extraAnswerType,
    Map<String, String> controller,
    Map<String, String> controllerChild,
    Map<String, AnswerKuesioner> listAnswer,
  ) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            contentPadding: EdgeInsets.zero,
            visualDensity: VisualDensity(horizontal: 0, vertical: -3),
            horizontalTitleGap: 0.w,
            title: Text(
              answerLabel,
              style: TextStyle(
                color: neutral80,
                fontSize: 16.sp,
                letterSpacing: 0.5,
                fontWeight: FontWeight.w500,
              ),
            ),
            leading: Radio(
              value: answerLabel,
              groupValue: controller[questionId.toString()],
              onChanged: (value) {
                setState(() {
                  mapSingleChoiceController.clear();
                  mapSingleChoiceController[answerId.toString()] = true;
                  controller[questionId.toString()] = value.toString();
                  listAnswer[questionId.toString()] = AnswerKuesioner(
                    alumniId: widget.alumniId,
                    answer: answerId.toString(),
                    extraAnswer: '',
                    questionId: questionId.toString(),
                  );
                  (hasExtraAnswer)
                      ? showExtraAnswer = true
                      : showExtraAnswer = false;
                });
              },
            ),
          ),
          (showExtraAnswer &&
                  mapSingleChoiceController[answerId.toString()] == true)
              ? Container(
                  padding: EdgeInsets.only(left: 40.w, right: 16.w),
                  child: (extraAnswerType == "string")
                      ? _formTypeString(
                          answerType,
                          null,
                          "Masukkan Jawaban",
                          'text',
                          index,
                          questionId,
                          answerId,
                          isChild,
                          hasExtraAnswer,
                          controller,
                          controllerChild,
                          mapTextEditingController,
                          listAnswer,
                        )
                      : (extraAnswerType == "integer")
                          ? _formTypeNumber(
                              answerType,
                              "Masukkan Jawaban",
                              index,
                              questionId,
                              answerId,
                              isChild,
                              hasExtraAnswer,
                              controller,
                              controllerChild,
                              mapTextEditingController,
                              listAnswer,
                            )
                          : SizedBox())
              : SizedBox()
        ],
      ),
    );
  }

  Widget _radioButtonHorizontalType(
    int index,
    int questionId,
    String question,
    bool isChild,
    Map<String, String> controller,
    Map<String, String> controllerChild,
    Map<String, AnswerKuesioner> listAnswer,
  ) {
    return Container(
      constraints: BoxConstraints(maxWidth: 20.w),
      margin: EdgeInsets.only(right: 36.w),
      child: Center(
        child: Column(
          children: [
            Text(index.toString()),
            Radio(
                value: index.toString(),
                groupValue: controller[questionId.toString()],
                onChanged: (value) {
                  setState(() {
                    controller[questionId.toString()] = value.toString();
                    listAnswer[questionId.toString()] = AnswerKuesioner(
                      alumniId: widget.alumniId,
                      questionId: questionId.toString(),
                      answer: value.toString(),
                    );
                  });
                }),
          ],
        ),
      ),
    );
  }

  Widget _checkBoxType(
    int answerType,
    int index,
    int questionId,
    String answerLabel,
    bool hasExtraAnswer,
    Map<String, bool> isActive,
    bool isChild,
    String? extraAnswerType,
    Map<String, String> controller,
    Map<String, String> controllerChild,
    Map<String, AnswerKuesioner> listAnswer,
  ) {
    return Container(
      child: Column(
        children: [
          CheckboxListTile(
              controlAffinity: ListTileControlAffinity.leading,
              title: Text(answerLabel),
              value: isActive[index.toString()] ?? false,
              onChanged: (value) {
                if (listAnswerCheckBox[questionId.toString()] == null) {
                  listAnswerCheckBox[questionId.toString()] =
                      List.empty(growable: true);
                }
                setState(() {
                  isActive[index.toString()] = value!;
                  if (value) {
                    listAnswerCheckBox[questionId.toString()]!
                        .add(index.toString());
                    controller[questionId.toString()] =
                        listAnswerCheckBox[questionId.toString()]!
                            .join(',')
                            .toString();
                  } else {
                    listAnswerCheckBox[questionId.toString()]!
                        .remove(index.toString());
                    controller[questionId.toString()] =
                        listAnswerCheckBox[questionId.toString()]!
                            .join(',')
                            .toString();
                  }
                  listAnswer[questionId.toString()] = AnswerKuesioner(
                    alumniId: widget.alumniId,
                    questionId: questionId.toString(),
                    answer: controller[questionId.toString()],
                  );
                  (hasExtraAnswer && isActive[index.toString()] == true)
                      ? showExtraAnswer = true
                      : showExtraAnswer = false;
                });
              }),
          (hasExtraAnswer && isActive[index.toString()] == true)
              ? Container(
                  padding: EdgeInsets.only(left: 40.w, right: 16.w),
                  child: (extraAnswerType == "string")
                      ? Container(
                          decoration: BoxDecoration(
                              color: white,
                              borderRadius: BorderRadius.circular(5.r)),
                          child: TextFormField(
                            style: hintTextStyle.copyWith(color: neutral90),
                            controller:
                                mapTextEditingController[index.toString()],
                            decoration: inputDecorationTextInput(
                              color: white,
                              hintText: "Masukkan Jawaban",
                            ),
                            onChanged: (v) {
                              setState(() {
                                listAnswer[questionId.toString()] =
                                    AnswerKuesioner(
                                        alumniId: widget.alumniId,
                                        questionId: questionId.toString(),
                                        answer:
                                            controller[questionId.toString()],
                                        extraAnswer: v);
                              });
                            },
                          ),
                        )
                      : (extraAnswerType == "integer")
                          ? Container(
                              decoration: BoxDecoration(
                                  color: white,
                                  borderRadius: BorderRadius.circular(5.r)),
                              child: TextFormField(
                                style: hintTextStyle.copyWith(color: neutral90),
                                keyboardType: TextInputType.number,
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                controller:
                                    mapTextEditingController[index.toString()],
                                decoration: inputDecorationTextInput(
                                  color: white,
                                  hintText: "Masukkan Jawaban",
                                ),
                                onChanged: (v) {
                                  setState(() {
                                    listAnswer[questionId.toString()] =
                                        AnswerKuesioner(
                                            alumniId: widget.alumniId,
                                            questionId: questionId.toString(),
                                            answer: controller[
                                                questionId.toString()],
                                            extraAnswer: v);
                                  });
                                },
                              ),
                            )
                          : SizedBox())
              : SizedBox()
        ],
      ),
    );
  }
}
