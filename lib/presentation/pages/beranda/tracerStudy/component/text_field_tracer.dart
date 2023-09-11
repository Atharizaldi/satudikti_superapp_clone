import 'package:app/injection.dart' as di;
import 'package:app/presentation/component/constant.dart';
import 'package:app/presentation/pages/beranda/sivil/bloc/sivil_bloc.dart';
import 'package:app/presentation/pages/beranda/sivil/bottom_sheet_noIjazah/bottom_sheet_noIjazah.dart';
import 'package:app/presentation/pages/beranda/sivil/bottom_sheet_prodi/bloc/bts_prodi_bloc.dart';
import 'package:app/presentation/pages/beranda/sivil/bottom_sheet_prodi/bottom_sheet_prodi.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logger/logger.dart';

Widget textFieldProdi(BuildContext sivilMainPageContext,
    TextEditingController textEditingController) {
  bool? isPtNull;
  return BlocConsumer<SivilBloc, SivilState>(
    listener: (context, state) {
      if(state is SivilInitialState) {
        isPtNull = state.pt?.id != null;
      }
    },
    builder: (context, state) {
      if(state is SivilInitialState) {
          Logger().i("TextFieldProdi state : ${state.prodi?.nama}");
        if(state.prodi?.jenjangDidik.nama != null && state.prodi?.nama != null) {
          textEditingController.value =
              textEditingController.value.copyWith(text: "${state.prodi?.jenjangDidik.nama} ${state.prodi?.nama}");
        } else {
          textEditingController.clear();
        }

        return GestureDetector(
          onTap: () {
            if (isPtNull != null) {
              showModalBottomSheet(
                isScrollControlled: true,
                isDismissible: true,
                backgroundColor: Colors.transparent,
                context: sivilMainPageContext,
                builder: (context) {
                  return BlocProvider(
                    create: (context) => di.locator<BtsProdiBloc>(),
                    child: BottomSheetProdi(
                      sivilPageContext: sivilMainPageContext,
                      idPt: state.pt?.id ?? '',
                    ),
                  );
                },
              );
            } else {
              SnackBar isiPt = SnackBar(
                content: Text(
                  'Harap isi Perguruan Tinggi terlebih dahulu',
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
              decoration: styleBorderWithDropdown("Tuliskan Nama Program Studi"),
              enabled: false,
            ),
          ),
        );
      }
      return SizedBox();
    },
  );
}

Widget textFieldNoIjazah(BuildContext sivilMainPageContext, 
TextEditingController textEditingController) {
  return GestureDetector(
    onTap: () {
      textEditingController.clear();
      showModalBottomSheet(
        isScrollControlled: true,
        isDismissible: true,
        backgroundColor: Colors.transparent,
        context: sivilMainPageContext,
        builder: (context) {
          return BottomSheetNoIjazah(
              sivilPageContext: sivilMainPageContext,
            );
        },
      );
    },
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.r),
        color: white,
      ),
      child: BlocBuilder<SivilBloc, SivilState>(
        builder: (context, state) {
          if (state is SivilInitialState) {
            Logger().i("TextFieldPt state : ${state.noIjazah}");
            textEditingController.value =
                textEditingController.value.copyWith(text: state.noIjazah);
          }
          return TextFormField(
            style: TextStyle(
              fontSize: 14.sp,
              color: neutral60,
              fontWeight: FontWeight.w400,
            ),
            controller: textEditingController,
            decoration:
                styleBorder("Tuliskan nomor ijazah"),
            enabled: false,
          );
        },
      ),
    ),
  );
}

// Widget textFieldNoIjazah(BuildContext sivilMainPageContext, TextEditingController textEditingController, void Function(String)? onChanged) {
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
//       decoration: styleBorder("Tuliskan nomor ijazah"),
//       enabled: true,
//       onChanged: onChanged,
//     ),
//   );
// }

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
