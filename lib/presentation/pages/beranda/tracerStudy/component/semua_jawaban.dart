import 'package:app/presentation/component/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SemuaJawabanTracer extends StatefulWidget {
  const SemuaJawabanTracer({Key? key}) : super(key: key);

  @override
  State<SemuaJawabanTracer> createState() => _SemuaJawabanTracerState();
}

Map<String, String> _controller = {'a': 'b'};

class _SemuaJawabanTracerState extends State<SemuaJawabanTracer> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        margin: EdgeInsets.only(bottom: 24.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // (!isChild)
                  Text(
                    // index.toString() + ". ",
                    "cek ini teks ",
                    style: TextStyle(
                        color: neutral80,
                        fontSize: 16.sp,
                        letterSpacing: 0.5,
                        fontWeight: FontWeight.w500),
                  ),
                  // : SizedBox(),
                  Container(
                    constraints: BoxConstraints(maxWidth: 296.w),
                    child: RichText(
                      text: TextSpan(
                        children: [
                          WidgetSpan(
                              child: Text(
                            "question",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                color: neutral80,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w500),
                          )),
                          // isRequired
                          //     ? TextSpan(
                          //         text: '*',
                          //         style: TextStyle(
                          //             color: Colors.red,
                          //             fontSize: 16.sp,
                          //             letterSpacing: 0.5,
                          //             fontWeight: FontWeight.w500),
                          //       )
                          //     : TextSpan(text: '')
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // (answerList != null)
            // ?
            Padding(
              padding: EdgeInsets.only(left: 8.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _radioButtonVerticalType(),

                  // for (int i = 0; i < answerList.length; i++)
                  //   _radioButtonVerticalType(
                  //     answertype,
                  //     index,
                  //     questionId,
                  //     answerList[i].answerListId,
                  //     answerList[i].answerLabel,
                  //     answerList[i].extraAnswer,
                  //     isChild,
                  //     answerList[i].extraAnswerType,
                  //     controller,
                  //     controllerChild,
                  //     listAnswer,
                  //   )
                ],
              ),
            ),

            //     : SizedBox(),
            // (hasChild)
            //     ? Container(
            //         margin: EdgeInsets.only(top: 16.h),
            //         child: Column(
            //           children: [
            //             for (int i = 0; i < childList!.length; i++)
            //               (childList[i].answerType.answerTypeId == 12)
            //                   ? _kuesionerInputNumber(
            //                       childList[i].answerType.answerTypeId,
            //                       childList[i].order,
            //                       childList[i].questionId,
            //                       childList[i].question,
            //                       childList[i].isRequired,
            //                       childList[i].hasChild,
            //                       childList[i].isChild,
            //                       childList[i].child,
            //                       childList[i].relationWith,
            //                       controller,
            //                       controllerChild,
            //                       listAnswer)
            //                   : (answertype == 4)
            //                       ? _kuesionerInputText(
            //                           childList[i].answerType.answerTypeId,
            //                           childList[i].order,
            //                           childList[i].questionId,
            //                           1,
            //                           childList[i].question,
            //                           childList[i].isRequired,
            //                           childList[i].isChild,
            //                           childList[i].hasChild,
            //                           childList[i].relationWith,
            //                           controller,
            //                           controllerChild,
            //                           listAnswer)
            //                       : SizedBox()
            //           ],
            //         ),
            //       )
            //     : SizedBox()
          ],
        ),
      ),
    );
  }
}

Widget _radioButtonVerticalType(
    // int answerType,
    // int index,
    // int questionId,
    // int answerId,
    // String answerLabel,
    // bool hasExtraAnswer,
    // bool isChild,
    // String? extraAnswerType,
    // Map<String, String> controller,
    // Map<String, String> controllerChild,
    // Map<String, AnswerKuesioner> listAnswer,
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
            "answerLabel",
            style: TextStyle(
              color: neutral80,
              fontSize: 16.sp,
              letterSpacing: 0.5,
              fontWeight: FontWeight.w500,
            ),
          ),
          leading: Radio(
            value: "answerLabel",
            groupValue: _controller[1.toString()],
            onChanged: (value) {},
            // onChanged: (value) {
            //   setState(() {
            //     mapSingleChoiceController.clear();
            //     mapSingleChoiceController[answerId.toString()] = true;
            //     controller[questionId.toString()] = value.toString();
            //     listAnswer[questionId.toString()] = AnswerKuesioner(
            //       alumniId: widget.alumniId,
            //       answer: answerId.toString(),
            //       extraAnswer: '',
            //       questionId: questionId.toString(),
            //     );
            //     (hasExtraAnswer)
            //         ? showExtraAnswer = true
            //         : showExtraAnswer = false;
            //   });
            // },
          ),
        ),

        // (showExtraAnswer &&
        //         mapSingleChoiceController[answerId.toString()] == true)
        //     ? Container(
        //         padding: EdgeInsets.only(left: 40.w, right: 16.w),
        //         child: (extraAnswerType == "string")
        //             ? _formTypeString(
        //                 answerType,
        //                 null,
        //                 "Masukkan Jawaban",
        //                 'text',
        //                 index,
        //                 questionId,
        //                 answerId,
        //                 isChild,
        //                 hasExtraAnswer,
        //                 controller,
        //                 controllerChild,
        //                 mapTextEditingController,
        //                 listAnswer,
        //               )
        //             : (extraAnswerType == "integer")
        //                 ? _formTypeNumber(
        //                     answerType,
        //                     "Masukkan Jawaban",
        //                     index,
        //                     questionId,
        //                     answerId,
        //                     isChild,
        //                     hasExtraAnswer,
        //                     controller,
        //                     controllerChild,
        //                     mapTextEditingController,
        //                     listAnswer,
        //                   )
        //                 : SizedBox())
        //     : SizedBox()
      ],
    ),
  );
}

// Widget _kuesionerInputText(
//     int answertype,
//     int index,
//     int questionId,
//     int answerId,
//     String question,
//     bool isRequired,
//     bool isChild,
//     bool hasChild,
//     int? relationWith,
//     Map<String, String> controller,
//     Map<String, String> controllerChild,
//     Map<String, AnswerKuesioner> listAnswer,
//   ) {
//     final splitted = question.split('[SPLIT]');
//     return Container(
//       margin: EdgeInsets.only(bottom: 24.h),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Container(
//             child: Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 (!isChild)
//                     ? Text(
//                         index.toString() + ". ",
//                         style: TextStyle(
//                             color: neutral80,
//                             fontSize: 16.sp,
//                             letterSpacing: 0.5,
//                             fontWeight: FontWeight.w500),
//                       )
//                     : SizedBox(),
//                 Container(
//                   constraints: BoxConstraints(maxWidth: 300.w),
//                   child: RichText(
//                     text: TextSpan(
//                       children: [
//                         WidgetSpan(
//                             child: Text(
//                           splitted.first,
//                           textAlign: TextAlign.left,
//                           style: TextStyle(
//                               color: neutral80,
//                               fontSize: 16.sp,
//                               fontWeight: FontWeight.w500),
//                         )),
//                         isRequired
//                             ? TextSpan(
//                                 text: '*',
//                                 style: TextStyle(
//                                     color: Colors.red,
//                                     fontSize: 16.sp,
//                                     letterSpacing: 0.5,
//                                     fontWeight: FontWeight.w500),
//                               )
//                             : TextSpan(text: '')
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           SizedBox(
//             height: 14.h,
//           ),
//           _formTypeString(
//             answertype,
//             relationWith,
//             "Masukkan Jawaban",
//             'text',
//             index,
//             questionId,
//             answerId,
//             isChild,
//             false,
//             controller,
//             controllerChild,
//             mapTextEditingController,
//             listAnswer,
//           ),
//           SizedBox(
//             height: 8.h,
//           ),
//           (splitted.length > 1) ? Text(splitted[1]) : SizedBox(),
//         ],
//       ),
//     );
//   }
