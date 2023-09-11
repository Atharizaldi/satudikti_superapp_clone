import 'package:app/injection.dart' as di;
import 'package:app/presentation/component/constant.dart';
import 'package:app/presentation/pages/beranda/ijazahln/bloc/bloc/bts_pt_ijazah_bloc.dart';
import 'package:app/presentation/pages/beranda/ijazahln/bloc/bts_negara_bloc/bts_negara_bloc.dart';
import 'package:app/presentation/pages/beranda/ijazahln/bloc/cubit/selectedijazah_cubit.dart';
import 'package:app/presentation/pages/beranda/ijazahln/bloc/ijazahln/verifikasisk/negarapt/negara_bloc.dart';
import 'package:app/presentation/pages/beranda/ijazahln/component/bottom_sheet_negara.dart';
import 'package:app/presentation/pages/beranda/ijazahln/component/bottom_sheet_pt_ijazah.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget textFieldNegaraIjazah(
    BuildContext ijazahPTContext, TextEditingController textEditingController) {
  return GestureDetector(
    onTap: () {
      showModalBottomSheet(
        isScrollControlled: true,
        isDismissible: true,
        backgroundColor: Colors.transparent,
        context: ijazahPTContext,
        builder: (context) {
          return BlocProvider(
            create: (context) =>
                di.locator<BtsNegaraBlocBloc>()..add(BtsInitialNegaraEvent()),
            child: BottomSheetNegara(
              ijazahPageContext: ijazahPTContext,
            ),
          );
        },
      );
    },
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.r),
        color: white,
      ),
      child: BlocBuilder<NegaraBloc, NegaraState>(
        builder: (context, state) {
          if (state is NegaraInitialState) {
            textEditingController.value =
                textEditingController.value.copyWith(text: state.namaNegara);
          }
          return TextFormField(
            style: TextStyle(
              fontSize: 14.sp,
              color: neutral60,
              fontWeight: FontWeight.w400,
            ),
            controller: textEditingController,
            decoration: styleBorderWithDropdown(
                "Tuliskan Asal Negara Perguruan Tinggi"),
            enabled: false,
          );
        },
      ),
    ),
  );
}

Widget textFieldPTIjazah(BuildContext sivilMainPageContext,
    TextEditingController textEditingController) {
  String kodeNegaraParams;
  return BlocBuilder<NegaraBloc, NegaraState>(
    builder: (context, state) {
      if (state is NegaraInitialState) {
        kodeNegaraParams = state.kodeNegara.toString();
        if (state.pt?.ptId != null && state.pt?.ptName != null) {
          textEditingController.value =
              textEditingController.value.copyWith(text: "${state.pt?.ptName}");
        } else {
          textEditingController.clear();
        }

        return GestureDetector(
          onTap: () {
            if (state.kodeNegara != null) {
              showModalBottomSheet(
                isScrollControlled: true,
                isDismissible: true,
                backgroundColor: Colors.transparent,
                context: sivilMainPageContext,
                builder: (context) {
                  return BlocProvider(
                    create: (context) => di.locator<BtsPtIjazahBloc>(),
                    child: BottomSheetPTIjazah(
                      kodeNegaraParams: kodeNegaraParams,
                      sivilPageContext: sivilMainPageContext,
                    ),
                  );
                },
              );
            } else {
              SnackBar isiPt = SnackBar(
                content: Text(
                  'Harap isi Negara terlebih dahulu',
                  style: TextStyle(fontSize: 12.sp),
                ),
              );
              ScaffoldMessenger.of(sivilMainPageContext).showSnackBar(isiPt);
            }
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
              controller: textEditingController,
              decoration:
                  styleBorderWithDropdown("Tuliskan Nama Perguruan Tinggi"),
              enabled: false,
            ),
          ),
        );
      }
      return SizedBox();
    },
  );
}

// ignore: must_be_immutable
class TextFieldPTIjazahLuarNegeri extends StatefulWidget {
  BuildContext ijazahPencarianLuarNegeri;
  TextEditingController textEditingController;
  bool isChecked;
  String kodeNegaraParams;
  TextFieldPTIjazahLuarNegeri(
      {Key? key,
      required this.ijazahPencarianLuarNegeri,
      required this.textEditingController,
      required this.isChecked,
      required this.kodeNegaraParams})
      : super(key: key);

  @override
  State<TextFieldPTIjazahLuarNegeri> createState() =>
      _TextFieldPTIjazahLuarNegeriState();
}

class _TextFieldPTIjazahLuarNegeriState
    extends State<TextFieldPTIjazahLuarNegeri> {
  bool? isPtNull;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NegaraBloc, NegaraState>(
      listener: (context, state) {
        if (state is NegaraInitialState) {
          isPtNull = state.pt?.negaraId != null;
        }
      },
      builder: (context, state) {
        if (state is NegaraInitialState) {
          if (state.pt?.ptId != null && state.pt?.ptName != null) {
            widget.textEditingController.value = widget
                .textEditingController.value
                .copyWith(text: "${state.pt?.ptName}");
          } else {
            widget.textEditingController.clear();
          }

          return GestureDetector(
            onTap: () {
              if (isPtNull != null || widget.isChecked) {
                showModalBottomSheet(
                  isScrollControlled: true,
                  isDismissible: true,
                  backgroundColor: Colors.transparent,
                  context: widget.ijazahPencarianLuarNegeri,
                  builder: (context) {
                    return BlocProvider(
                      create: (context) => di.locator<BtsPtIjazahBloc>(),
                      child: BottomSheetPTIjazahLuarNegeri(
                        kodeNegaraParams: widget.kodeNegaraParams,
                        sivilPageContext: widget.ijazahPencarianLuarNegeri,
                      ),
                    );
                  },
                ).whenComplete(() => {
                      BlocProvider.of<SelectedijazahCubit>(context)
                          .isIjazahSelected()
                    });
              } else {
                SnackBar isiPt = SnackBar(
                  content: Text(
                    'Harap isi Negara terlebih dahulu',
                    style: TextStyle(fontSize: 12.sp),
                  ),
                );
                ScaffoldMessenger.of(widget.ijazahPencarianLuarNegeri)
                    .showSnackBar(isiPt);
              }
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
                controller: widget.textEditingController,
                decoration:
                    styleBorderWithDropdown("Tuliskan Nama Perguruan Tinggi"),
                enabled: false,
              ),
            ),
          );
        }
        return SizedBox();
      },
    );
  }
}

InputDecoration styleBorderWithDropdown(String hint) {
  return InputDecoration(
    suffixIcon: Icon(
      Icons.arrow_drop_down,
      color: neutralCaption,
    ),
    border: OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.circular(5.r),
    ),
    hintText: hint,
    hintStyle: TextStyle(
      fontSize: 14.sp,
      color: neutral20,
      fontWeight: FontWeight.w400,
    ),
  );
}

InputDecoration styleBorder(String hint) {
  return InputDecoration(
    border: OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.circular(5.r),
    ),
    hintText: hint,
    hintStyle: TextStyle(
      fontSize: 14.sp,
      color: neutral20,
      fontWeight: FontWeight.w400,
    ),
  );
}

InputDecoration styleWithSearchPrefix(String hint) {
  return InputDecoration(
    prefixIcon: Container(
      margin: EdgeInsets.only(left: 20.w, right: 12.w),
      child: Image.asset(
        'assets/icons/search_active.png',
        width: 18.w,
        height: 15.w,
        color: abu6,
      ),
    ),
    border: OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.circular(10.r),
    ),
    hintText: hint,
    hintStyle: TextStyle(
      fontSize: 14.sp,
      color: neutral20,
      fontWeight: FontWeight.w400,
    ),
  );
}
