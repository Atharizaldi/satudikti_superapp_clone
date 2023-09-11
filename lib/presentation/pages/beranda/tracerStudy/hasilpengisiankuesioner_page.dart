import 'package:app/data/source/remote/model/tracer/getAllAnswer.dart';
import 'package:app/presentation/component/SkeletonLoading.dart';
import 'package:app/presentation/component/constant.dart';
import 'package:app/presentation/component/customAppBar.dart';
import 'package:app/presentation/component/server_problem.dart';
import 'package:app/presentation/pages/beranda/tracerStudy/bloc/kuesioner/kuesioner_bloc.dart';
import 'package:app/presentation/pages/beranda/tracerStudy/bloc/kuesioner/kuesioner_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'component/alertinfo_card.dart';

class HasilPengisianKuesionerPage extends StatefulWidget {
  HasilPengisianKuesionerPage();

  @override
  State<HasilPengisianKuesionerPage> createState() =>
      _HasilPengisianKuesionerPageState();
}

class _HasilPengisianKuesionerPageState
    extends State<HasilPengisianKuesionerPage> {
  List<String> singleChoiceAnswer = [];
  List<String> questions = [];
  List<Questions> allQuestions = [];
  List<Questions> khususTipe7 = [];
  List<Answer> allAnswers = [];
  List<Answer> dummyAllAnswers = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<String> controllerInt = ["1", "2", "3", "4", "5"];
    return Scaffold(
      backgroundColor: whiteBgPage,
      appBar: CustomAppBar(
        title: 'Hasil Pengisian Kuesioner',
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: BlocBuilder<KuesionerTracerBloc, KuesionerTracerState>(
          builder: (context, state) {
            if (state is GetAllAnswersLoadedState) {
              print("KESINI ${allQuestions.length}");
              for (var i = 0; i < allQuestions.length; i++)
                if (allAnswers[i].answerType == 1) {
                  print("INI TIPE 1 $i");
                }

              print(
                  "DEBUGGGGGGGGGGGG ${state.data.data!.questions![15].question.toString()}");

              for (var i = 0; i < state.data.data!.questions!.length; i++) {
                print("KESINI LAGI LOG $i");

                allQuestions.add(state.data.data!.questions![i]);
                if (state.data.data!.questions![i].hasChild == true) {
                  print("LAH KESINI $i");
                  for (var j = 0;
                      j < state.data.data!.questions![i].child!.length;
                      j++) {
                    var newQuestion = Questions(
                      child: [state.data.data!.questions![i].child![j]],
                    );
                    allQuestions.add(newQuestion);
                  }
                }
              }
              for (var i = 0; i < state.data.data!.answer!.length; i++) {
                allAnswers.add(state.data.data!.answer![i]);
              }

              print(
                  "SEMOGA BISAA ${allQuestions.length} ini allanswer ${allAnswers.length}");
              print(
                  "APAKAH SAMA ${allAnswers.length} dengan ${allQuestions.length} Plus ${khususTipe7.length}");

              for (var i = 0; i < allQuestions.length; i++) {
                print(
                    "$i ISINYA APAKAH SAMAdengan ${allQuestions[i].answerType?.answerTypeId} dan juga ${allAnswers[i].answerType}");
              }

              return _body(context, controllerInt, allQuestions, allAnswers);
            } else if (state is KuesionerTracerLoadingState) {
              return _skeletonHasilPengisianKuesioner();
            } else {
              return ServerProblem(onPressed: () {}, buttonHide: true);
            }
          },
        ),
      ),
    );
  }
}

Widget _skeletonHasilPengisianKuesioner() {
  return Container(
    padding: EdgeInsets.all(25.w),
    child: ListView(
      children: [
        Center(
            child: SkeletonLoading(
          width: double.infinity,
          height: 70.h,
          cornerRadius: 8.r,
        )),
        SizedBox(height: 15.h),
        ListView.separated(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            separatorBuilder: (BuildContext context, int index) {
              return SizedBox(height: 15.h);
            },
            itemCount: 15,
            itemBuilder: (context, index) {
              return SkeletonLoading(
                width: 360.w,
                height: 30.w,
                cornerRadius: 8.r,
              );
            }),
      ],
    ),
  );
}

ListView _body(BuildContext context, List<String> controllerInt,
    List<Questions> allQuestions, List<Answer> allAnswers) {
  return ListView(
    children: [
      Container(
        child: AlertInfoCard(
          textinfo: 'Terima Kasih Telah Mengisi Kuesioner',
          textdescription: 'Berikut adalah tanggapan yang diterima.',
        ),
      ),
      SizedBox(
        height: 12.h,
      ),
      Text(
        'Kuesioner Wajib',
        style: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 20.sp,
          color: blue2,
        ),
      ),
      SizedBox(
        height: 16.h,
      ),
      for (var i = 0; i < allQuestions.length; i++)
        if (allAnswers[i].answerType == 1)
          _singleChoice(
              context,
              allQuestions[i].question.toString(),
              allQuestions[i].answerLists!,
              allAnswers[i].answer!,
              allQuestions[i].order.toString())
        else if (allAnswers[i].answerType == 2)
          _multipleChoice(
              context,
              allQuestions[i].answerLists!,
              allQuestions[i].question.toString(),
              allAnswers[i].answer!,
              allQuestions[i].order.toString())
        else if (allAnswers[i].answerType == 4 ||
            allAnswers[i].answerType == 6 ||
            allAnswers[i].answerType == 8 ||
            allAnswers[i].answerType == 9 ||
            allAnswers[i].answerType == 10 ||
            allAnswers[i].answerType == 11 ||
            allAnswers[i].answerType == 12)
          if (allQuestions[i].question.toString() == "null")
            _inputText(
                context,
                allAnswers[i].answer.toString(),
                allQuestions[i].child![0].question.toString(),
                allQuestions[i].order.toString())
          else
            _inputText(
                context,
                allAnswers[i].answer.toString(),
                allQuestions[i].question.toString(),
                allQuestions[i].order.toString())
        else if (allAnswers[i].answerType == 3)
          if (allQuestions[i].question.toString() == "null")
            _inputText(
                context,
                allAnswers[i].realAnswer.toString(),
                allQuestions[i].child![0].question.toString(),
                allQuestions[i].order.toString())
          else
            _inputText(
                context,
                allAnswers[i].realAnswer.toString(),
                allQuestions[i].question.toString(),
                allQuestions[i].order.toString())
        else if (allAnswers[i].answerType == 5)
          _range(
              context,
              controllerInt,
              allQuestions[i].child![0].rangeLabel![0].toString(),
              allQuestions[i].child![0].rangeLabel![1].toString(),
              allQuestions[i].child![0].question.toString(),
              int.parse(
                allAnswers[i].answer.toString(),
              ),
              allQuestions[i].order.toString())
        else
          Padding(
            padding: EdgeInsets.all(10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${allQuestions[i].order.toString()}. ",
                  style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      color: neutral70),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${allAnswers[i].question}*",
                        style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                            color: neutral70),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
    ],
  );
}

Widget _range(
    BuildContext context,
    List<String> controllerInt,
    String labelLeft,
    String labelRight,
    String label,
    int answer,
    String nomor) {
  if (nomor == "null") {
    nomor = "";
  } else {
    nomor = "$nomor . ";
  }

  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 34.w),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "$nomor$label",
          style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
              fontFamily: "Plus Jakarta Sans",
              color: neutral70),
        ),
        SizedBox(
          height: 10.h,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            for (var i = 0; i < 5; i++)
              Column(
                children: [
                  Text(
                    (i + 1).toString(),
                    style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Plus Jakarta Sans',
                        color: answer == i + 1 ? neutral70 : neutral40),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Radio(
                      activeColor: blue2,
                      fillColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                          if (states.contains(MaterialState.selected)) {
                            return blue2; // Selected color
                          } else {
                            return neutral40; // Unselected color
                          }
                        },
                      ),
                      value: i + 1,
                      groupValue: answer,
                      onChanged: (value) {}),
                ],
              )
          ],
        ),
        Padding(
          padding: EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "$labelLeft".replaceAll(' ', '\n'),
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Plus Jakarta Sans',
                    color: Color.fromRGBO(77, 77, 77, 1)),
              ),
              Text(
                "$labelRight".replaceAll(' ', '\n'),
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Plus Jakarta Sans',
                    color: Color.fromRGBO(77, 77, 77, 1)),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 24.h,
        ),
        Divider(
          thickness: 1,
          indent: 20,
          endIndent: 20,
        ),
        SizedBox(
          height: 8.h,
        ),
      ],
    ),
  );
}

Widget _inputText(
    BuildContext context, String controller, String label, String nomor) {
  if (nomor == "null") {
    nomor = "";
  } else {
    nomor = "$nomor . ";
  }
  final splitted = label.split('[SPLIT]');

  return Padding(
    padding: EdgeInsets.all(
      10,
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("$nomor ",
                style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    fontFamily: "Plus Jakarta Sans",
                    color: Color.fromRGBO(77, 77, 77, 1))),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${splitted.first}",
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      fontFamily: "Plus Jakarta Sans",
                      // color: Color.fromRGBO(77, 77, 77, 1),
                      color: Color.fromRGBO(77, 77, 77, 1),
                    ),
                  ),
                  SizedBox(
                    height: 14.h,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white, // Set the fill color to black
                      borderRadius: BorderRadius.circular(
                          5.r), // Set the desired border radius
                    ),
                    child: TextFormField(
                      readOnly: true,
                      decoration: InputDecoration(
                        hintText: controller,
                        hintStyle: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Plus Jakarta Sans',
                            color: Color.fromRGBO(77, 77, 77, 1)),
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 12.0, vertical: 16.0),
                        border: InputBorder.none,
                        isDense: true,
                      ),
                    ),
                  ),
                  splitted.length > 1
                      ? Text(
                          "${splitted[1]}",
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                            fontFamily: "Plus Jakarta Sans",
                            color: Color.fromRGBO(77, 77, 77, 1),
                          ),
                        )
                      : Container()
                ],
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget _multipleChoice(BuildContext context, List<AnswerLists> controller,
    String label, String answer, String nomor) {
  if (nomor == "null") {
    nomor = "";
  } else {
    nomor = "$nomor . ";
  }
  List<String> answerList = answer.trim().split(',');

  return Padding(
    padding: EdgeInsets.all(10.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "$nomor",
          style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
              fontFamily: "Plus Jakarta Sans",
              color: neutral70),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "$label",
                style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    fontFamily: "Plus Jakarta Sans",
                    color: neutral70),
              ),
              SizedBox(height: 10.h),
              ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: controller.length,
                itemBuilder: (context, index) {
                  // return Text(state.listBook[index].judul);
                  return IgnorePointer(
                    child: Theme(
                      data: ThemeData(
                        checkboxTheme: CheckboxThemeData(
                          side: BorderSide(
                            color: answerList.contains(
                                    controller[index].answerListId.toString())
                                ? blue2 // Selected border color
                                : neutral40, // Unselected border color
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                4.r), // Set the desired border radius
                          ),
                        ),
                      ),
                      child: CheckboxListTile(
                        activeColor: Color.fromRGBO(26, 104, 158, 1),
                        contentPadding: EdgeInsets.zero,
                        controlAffinity: ListTileControlAffinity.leading,
                        title: Text(
                          controller[index].answerLabel.toString(),
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Plus Jakarta Sans',
                            color: answerList.contains(
                                    controller[index].answerListId.toString())
                                ? neutral70
                                : neutral40,
                          ),
                        ),
                        value: answerList.contains(
                            controller[index].answerListId.toString()),

                        // controller[index].answerListId.toString() == answerList[i]
                        //     ? true
                        //     : false,
                        onChanged: (bool? value) {},
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _singleChoice(
  BuildContext context,
  String questionLabel,
  List<AnswerLists> answerList,
  String jawaban,
  String nomor,
) {
  if (nomor == "null") {
    nomor = "";
  } else {
    nomor = "$nomor . ";
  }
  return Padding(
    padding: EdgeInsets.all(10),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "$nomor",
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
            fontFamily: "Plus Jakarta Sans",
            color: neutral70,
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "$questionLabel",
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  fontFamily: "Plus Jakarta Sans",
                  color: neutral70,
                ),
              ),
              ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: answerList.length,
                itemBuilder: (context, index) {
                  // print("INI ANSWER ANSWER ${ans}");
                  // print("INI PANJANG ASNWER ${controller.length}");
                  // print("INI PANJANG QUESTION ${answer.length}");

                  // if (controller[index].answerListId.toString() ==
                  //     answer[index].answer.toString()) {
                  //   jawaban = [controller[index].answerLabel!];
                  //   print("INI JAWABANNUA $jawaban");
                  //   print("ANSWER ${index}");
                  // }
                  // return Text(state.listBook[index].judul);
                  return IgnorePointer(
                    child: RadioListTile(
                      title: Text(
                        answerList[index].answerLabel.toString(),
                        // answer[index].answer.toString(),
                        // controller[index].answerLabel.toString(),
                        style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Plus Jakarta Sans',
                            color: jawaban ==
                                    answerList[index].answerListId.toString()
                                ? neutral70 // Selected color
                                : neutral40),
                      ),
                      value: answerList[index].answerListId.toString(),
                      contentPadding: EdgeInsets.zero,
                      groupValue: jawaban,
                      activeColor: blue2,
                      onChanged: (value) {},
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
