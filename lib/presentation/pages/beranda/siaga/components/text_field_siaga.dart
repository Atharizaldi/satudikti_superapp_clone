import 'package:app/injection.dart' as di;
import 'package:app/presentation/component/constant.dart';
import 'package:app/presentation/pages/beranda/siaga/bloc/siaga_bloc.dart';
import 'package:app/presentation/pages/beranda/siaga/bottom_sheet_pt/bloc/pt_bloc.dart';
import 'package:app/presentation/pages/beranda/siaga/bottom_sheet_pt/bottom_sheet_pt_siaga.dart';
import 'package:app/presentation/pages/beranda/siaga/bottom_sheet_tiket/bottom_sheet_tiket.dart';
import 'package:app/presentation/pages/beranda/sivil/component/text_field_sivil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget textFieldPTSiaga(BuildContext siagaMainPageContext,
    TextEditingController textEditingController) {
  return GestureDetector(
    onTap: () {
      showModalBottomSheet(
        isScrollControlled: true,
        isDismissible: true,
        backgroundColor: Colors.transparent,
        context: siagaMainPageContext,
        builder: (context) {
          return BlocProvider(
            create: (context) => di.locator<PtBloc>(),
            child: BottomSheetPTSiaga(
              siagaPageContext: siagaMainPageContext,
            ),
          );
        },
      );
    },
    child: Container(
      height: 50.h,
      width: 358.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.r),
        color: white,
      ),
      alignment: Alignment.center,
      child: BlocBuilder<SiagaBloc, SiagaState>(
        builder: (context, state) {
          if (state is SiagaInitialState) {
            textEditingController.value =
                textEditingController.value.copyWith(text: state.pt?.label);
          }
          return TextFormField(
            style: TextStyle(
              fontSize: 14.sp,
              color: neutral70,
              fontWeight: FontWeight.w400,
            ),
            controller: textEditingController,
            decoration:
                styleBorderWithDropdown("Masukkan Nama Perguruan Tinggi"),
            enabled: false,
          );
        },
      ),
    ),
  );
}

Widget textFieldTicket(BuildContext siagaMainPageContext,
    TextEditingController textEditingController) {
  return GestureDetector(
    onTap: () {
      textEditingController.clear();
      showModalBottomSheet(
        isScrollControlled: true,
        isDismissible: true,
        backgroundColor: Colors.transparent,
        context: siagaMainPageContext,
        builder: (context) {
          return BottomSheetTiket(
              siagaPageContext: context,
              textEditingController: textEditingController,
            );
        },
      );
    },
    child: Container(
      height: 50.h,
      width: 358.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.r),
        color: white,
      ),
      alignment: Alignment.center,
      child: BlocBuilder<SiagaBloc, SiagaState>(
        builder: (context, state) {
          if (state is SiagaInitialState) {
            textEditingController.value =
                textEditingController.value.copyWith(text: state.pt?.label);
          }
          return TextFormField(
            style: TextStyle(
              fontSize: 14.sp,
              color: neutral70,
              fontWeight: FontWeight.w400,
            ),
            controller: textEditingController,
            decoration: styleBorder("Masukkan Nomor Tiket"),
            enabled: false,
          );
        },
      ),
    ),
  );
}

// Widget textFieldTicket(TextEditingController textEditingController) {
//   return Container(
//     decoration: BoxDecoration(
//       borderRadius: BorderRadius.circular(5.r),
//       color: white,
//     ),
//     child: TextFormField(
//       style: TextStyle(
//         fontSize: 14.sp,
//         color: neutral60,
//         fontWeight: FontWeight.w400,
//       ),
//       controller: textEditingController,
//       decoration: styleBorder("Masukkan Nomor Tiket"),
//       enabled: true,
//     ),
//   );
// }

InputDecoration styleBorderWithDropdown(String hint) {
  return InputDecoration(
    contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10.w),
    isDense: true,
    suffixIcon: Image.asset('assets/siaga/icon_dropdown.png'),
    border: OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.circular(5.r),
    ),
    hintText: hint,
    hintStyle: TextStyle(
      fontSize: 14.sp,
      color: neutral30,
      fontWeight: FontWeight.w400,
    ),
  );
}
