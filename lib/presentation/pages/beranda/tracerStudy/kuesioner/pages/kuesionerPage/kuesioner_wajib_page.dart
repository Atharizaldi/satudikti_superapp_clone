import 'package:app/data/source/remote/model/tracer/AnswerKuesioner.dart';
import 'package:app/injection.dart' as di;
import 'package:app/presentation/component/constant.dart';
import 'package:app/presentation/component/customAppBar.dart';
import 'package:app/presentation/component/noInternet.dart';
import 'package:app/presentation/component/server_problem.dart';
import 'package:app/presentation/pages/beranda/sivil/bloc/sivil_bloc.dart';
import 'package:app/presentation/pages/beranda/tracerStudy/bloc/bottom_sheet_form/bottom_sheet_form_bloc.dart';
import 'package:app/presentation/pages/beranda/tracerStudy/bloc/pencarian_bloc/pencarian_kabupaten_bloc/pencarian_kabupaten_bloc.dart';
import 'package:app/presentation/pages/beranda/tracerStudy/bloc/pencarian_bloc/pencarian_prodi_bloc/pencarian_prodi_bloc.dart';
import 'package:app/presentation/pages/beranda/tracerStudy/bloc/pencarian_bloc/pencarian_pt_bloc/pencarian_pt_bloc.dart';
import 'package:app/presentation/pages/beranda/tracerStudy/bloc/pencarian_spesifik_bloc/pencarian_spesifik_bloc.dart';
import 'package:app/presentation/pages/beranda/tracerStudy/bloc/post_store_bloc/post_store_bloc.dart';
import 'package:app/presentation/pages/beranda/tracerStudy/bloc/post_store_bloc/post_store_event.dart';
import 'package:app/presentation/pages/beranda/tracerStudy/bloc/post_store_bloc/post_store_state.dart';
import 'package:app/presentation/pages/beranda/tracerStudy/component/buttom_sheet_form/bottom_sheet_provinsi/bloc/bts_provinsi_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logger/logger.dart';

import '../../../../../../component/customSliverBarKuesioner.dart';
import '../../../../kompetensiDosen/reusableWidgets/reusableWidgetsCard.dart';
import '../../../bloc/kuesioner/kuesioner_bloc.dart';
import '../../../bloc/kuesioner/kuesioner_event.dart';
import '../../../bloc/kuesioner/kuesioner_state.dart';
import '../../../component/card_component.dart';
import '../../../component/dialog_component.dart';
import '../../../component/pertanyaan_kuisioner_component.dart';

class KuesionerWajibPage extends StatefulWidget {
  final String alumniId;
  final Map<String, AnswerKuesioner>? answer;

  const KuesionerWajibPage({
    Key? key,
    required this.alumniId,
    required this.answer,
  }) : super(key: key);

  @override
  State<KuesionerWajibPage> createState() => _KuesionerWajibPageState();
}

class _KuesionerWajibPageState extends State<KuesionerWajibPage> {
  late KuesionerTracerBloc _kuesionerTracerBloc;

  Map<String, String> selectedPTObject = {"kodePT": ""};
  Map<String, String> selectedProdiObject = {"kodeProdi": ""};
  Map<String, String> selectedProvinsiObject = {"kodeProvinsi": ""};
  Map<String, String> selectedKabupatenObject = {"kodeKabupaten": ""};

  Map<String, String> hasilProvinsi = {'a': 'b'};

  Map<String, AnswerKuesioner> answerKuesioner = {};

  void getPreviousAnswer() {
    if (widget.answer != null) {
      setState(() {
        answerKuesioner = widget.answer!;
      });
    }
  }

  @override
  void initState() {
    getPreviousAnswer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _kuesionerTracerBloc = BlocProvider.of<KuesionerTracerBloc>(context);
    return BlocConsumer<PencarianSpesifikTracerBloc, PencarianSpesifikState>(
      listener: (context, state) {
        if (state is PencarianSpesifikLoadedState) {
          hasilProvinsi = BlocProvider.of<PencarianSpesifikTracerBloc>(context)
              .hasilProvinsi;
        } else {
          hasilProvinsi = {};
        }
      },
      builder: (context, state) {
        if (state is PencarianSpesifikNoInternetState) {
          return Column(
            children: [noInternetWithContainer(), SizedBox(height: 400.h)],
          );
        } else {
          return BlocBuilder<KuesionerTracerBloc, KuesionerTracerState>(
              builder: ((context, state) {
            if (state is KuesionerTracerLoadedState) {
              return BlocListener<PostStoreAnswerTracerBloc,
                  PostStoreAnswerTracerState>(
                listener: (contextListener, state) {
                  if (state is PostStoreAnswerLoadingState) {
                    YYDialogLoading(context);
                  } else if (state is PostStoreAnswerSuccessState) {
                    Navigator.pop(context);
                    // Text("ASD");
                    YYDialogFinishKuesioner(context, widget.alumniId);
                  } else if (state is PostStoreAnswerFailedState) {
                    Navigator.pop(context);
                    YYDialogValidasiFailed(context, "Kuesioner Tidak Valid",
                        "Harap perhatikan kembali jawaban anda. Pastikan tidak ada kuesioner yang terlewat.");
                  } else {
                    Navigator.pop(context);
                    YYDialogValidasiFailed(context, "Kuesioner Tidak Valid",
                        "Harap perhatikan kembali jawaban anda. Pastikan tidak ada kuesioner yang terlewat.");
                  }
                },
                child: Container(
                  decoration: BoxDecoration(gradient: sliverBgGradient),
                  child: Scaffold(
                    backgroundColor: Colors.transparent,
                    body: CustomSliverBarKuesioner(
                        appBarTitle: "Kuesioner",
                        child: Container(
                          color: whiteBgPage,
                          padding: EdgeInsets.symmetric(
                              horizontal: 16.w, vertical: 32.h),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              bannerSubJudulTracer("Kuesioner Wajib"),
                              PertanyaanKuesioner(
                                alumniId: widget.alumniId,
                                kuisionerPageContext: context,
                                kuesioner: state.listQuestions,
                                selectedPTObject: selectedPTObject,
                                selectedProdiObject: selectedProdiObject,
                                selectedProvinsiObject: selectedProvinsiObject,
                                selectedKabupatenObject:
                                    selectedKabupatenObject,
                                listAllProvinsi: hasilProvinsi,
                                answerKuesioner: answerKuesioner,
                              ),
                              SizedBox(
                                height: 24.h,
                              ),
                              //TODO: Max page is still hardcoded
                              (state.page == 1)
                                  ? _buttonNext(state.page)
                                  : (state.page > 1 && state.page < 8)
                                      ? _buttonNextWithPrevious(
                                          'Selanjutnya', state.page)
                                      : (state.page == 8)
                                          ? Container(
                                              margin:
                                                  EdgeInsets.only(top: 380.h),
                                              child: _buttonNextWithPrevious(
                                                  "Selesai", state.page),
                                            )
                                          : SizedBox()
                            ],
                          ),
                        )),
                  ),
                ),
              );
            } else if (state is KuesionerTracerLoadingState) {
              return Scaffold(
                appBar: CustomAppBar(
                  title: "Kuesioner",
                ),
                body: Container(
                    child: Center(
                        child: CircularProgressIndicator(color: blueLinear1))),
              );
            } else if (state is KuesionerTracerNoInternetState) {
              return Scaffold(
                  appBar: CustomAppBar(
                    title: "Kuesioner",
                  ),
                  body: Container(
                      child: NoInternet(
                    onPressed: () {},
                    buttonHide: true,
                  )));
            } else {
              return Scaffold(
                  appBar: CustomAppBar(
                    title: "Kuesioner",
                  ),
                  body: Container(
                      child: ServerProblem(
                    onPressed: () {},
                    buttonHide: true,
                  )));
            }
          }));
        }
      },
    );
  }

  Widget _buttonNext(int currentPage) {
    return GestureDetector(
      onTap: () {
        // setState(() {
        //   _pages++;
        // });
        // TO DO NEXT PAGE
        Logger().i("Nggak Kosong");

        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => MultiBlocProvider(
                      providers: [
                        BlocProvider(
                          create: (context) => di.locator<KuesionerTracerBloc>()
                            ..add(GetKuesionerTracerEvent(currentPage + 1)),
                        ),
                        BlocProvider(
                            create: (context) =>
                                di.locator<PostStoreAnswerTracerBloc>()),
                        BlocProvider(
                            create: (context) =>
                                di.locator<PencarianKabupatenTracerBloc>()),
                        BlocProvider(
                            create: (context) =>
                                di.locator<PencarianPtTracerBloc>()),
                        BlocProvider(
                            create: (context) =>
                                di.locator<PencarianProdiTracerBloc>()),
                        BlocProvider(
                            create: (context) =>
                                di.locator<PencarianSpesifikTracerBloc>()
                                  ..add(InitPencarianSpesifikEvent())),
                        BlocProvider(
                          create: (context) =>
                              di.locator<BottomSheetFormTracerBloc>()
                                ..add(ClearTracerEvent()),
                        ),
                        BlocProvider(
                          create: (context) =>
                              di.locator<BtsTracerProvinsiBloc>(),
                        ),
                        BlocProvider(
                          create: (context) =>
                              di.locator<SivilBloc>()..add(ClearEvent()),
                        ),
                      ],
                      child: KuesionerWajibPage(
                        answer: answerKuesioner,
                        alumniId: widget.alumniId,
                      ))),
        );

        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: (context) => KuesionerWajibPage(
        //               kuesioner: nextKuesioner!,
        //               maxPage: widget.maxPage,
        //               page: _pages,
        //             )));
      },
      child: Align(
        alignment: Alignment.centerRight,
        child: Container(
          height: 50.h,
          width: 358.w,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: biruMuda2, borderRadius: BorderRadius.circular(5.r)),
          child: Center(
            child: Text(
              'Selanjutnya',
              style: TextStyle(
                color: white,
                fontSize: 18.sp,
                letterSpacing: 1,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buttonNextWithPrevious(String hintText, int currentPage) {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            // setState(() {
            //   _pages--;
            // });
            Navigator.pop(context);
          },
          child: Container(
            height: 50.h,
            width: 173.w,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(5.r),
                border: Border.all(width: 2.sp, color: biruMuda2)),
            child: Center(
              child: Text(
                'Sebelumnya',
                style: TextStyle(
                  color: biruMuda2,
                  fontSize: 18.sp,
                  letterSpacing: 1,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          width: 12.w,
        ),
        GestureDetector(
          onTap: () {
            // setState(() {
            //   _pages++;
            // });
            //TODO: Max page is still hardcoded
            // print("INI ANSWERSS VALUEEE ${answerKuesioner[9]?.extraAnswer}");
            if (currentPage > 0 && currentPage <= 8) {
              List<AnswerKuesioner> maps = answerKuesioner.values.toList();
              for (var i = 0; i < maps.length; i++) {
                print(
                    "INI RESULT DARI BLOC index ARASASS $i ${maps[i].questionId} + ${maps[i].answer} '+'  ${maps[i].extraAnswer}");
              }
              if (currentPage == 8) {
                BlocProvider.of<PostStoreAnswerTracerBloc>(context).add(
                    PostStoreAnswerEvent(
                        listAnswer: answerKuesioner.values.toList()));
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MultiBlocProvider(
                              providers: [
                                BlocProvider(
                                  create: (context) =>
                                      di.locator<KuesionerTracerBloc>()
                                        ..add(GetKuesionerTracerEvent(
                                            currentPage + 1)),
                                ),
                                BlocProvider(
                                    create: (context) => di
                                        .locator<PostStoreAnswerTracerBloc>()),
                                BlocProvider(
                                    create: (context) => di.locator<
                                        PencarianKabupatenTracerBloc>()),
                                BlocProvider(
                                    create: (context) =>
                                        di.locator<PencarianPtTracerBloc>()),
                                BlocProvider(
                                    create: (context) =>
                                        di.locator<PencarianProdiTracerBloc>()),
                                BlocProvider(
                                    create: (context) => di
                                        .locator<PencarianSpesifikTracerBloc>()
                                      ..add(InitPencarianSpesifikEvent())),
                                BlocProvider(
                                  create: (context) =>
                                      di.locator<BottomSheetFormTracerBloc>()
                                        ..add(ClearTracerEvent()),
                                ),
                                BlocProvider(
                                  create: (context) =>
                                      di.locator<BtsTracerProvinsiBloc>(),
                                ),
                                BlocProvider(
                                  create: (context) => di.locator<SivilBloc>()
                                    ..add(ClearEvent()),
                                ),
                              ],
                              child: KuesionerWajibPage(
                                answer: answerKuesioner,
                                alumniId: widget.alumniId,
                              ))),
                );
              }
            } else {
              Logger().e('Data Error');
            }
          },
          child: Container(
            height: 50.h,
            width: 173.w,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: biruMuda2, borderRadius: BorderRadius.circular(5.r)),
            child: Center(
              child: Text(
                hintText,
                style: TextStyle(
                  color: white,
                  fontSize: 18.sp,
                  letterSpacing: 1,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
