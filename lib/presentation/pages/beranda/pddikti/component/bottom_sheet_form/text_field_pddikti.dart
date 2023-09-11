import 'package:app/injection.dart' as di;
import 'package:app/presentation/component/constant.dart';
import 'package:app/presentation/pages/beranda/pddikti/bloc/bottom_sheet_form/bottom_sheet_form_bloc.dart';
import 'package:app/presentation/pages/beranda/pddikti/component/bottom_sheet_form/bottom_sheet_provinsi/bloc/bts_provinsi_bloc.dart';
import 'package:app/presentation/pages/beranda/pddikti/component/bottom_sheet_form/bottom_sheet_provinsi/bottom_sheet_provinsi.dart';
import 'package:app/presentation/pages/beranda/sivil/bloc/sivil_bloc.dart';
import 'package:app/presentation/pages/beranda/sivil/bottom_sheet_prodi/bloc/bts_prodi_bloc.dart';
import 'package:app/presentation/pages/beranda/sivil/bottom_sheet_prodi/bottom_sheet_prodi.dart';
import 'package:app/presentation/pages/beranda/sivil/bottom_sheet_pt/bloc/bts_pt_bloc.dart';
import 'package:app/presentation/pages/beranda/sivil/bottom_sheet_pt/bottom_sheet_pt.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logger/logger.dart';

Widget textFieldPTPDDikti(BuildContext sivilMainPageContext,
    TextEditingController textEditingController, Map<String, String> ptObject) {
  return GestureDetector(
    onTap: () {
      showModalBottomSheet(
        isScrollControlled: true,
        isDismissible: true,
        backgroundColor: Colors.transparent,
        context: sivilMainPageContext,
        builder: (context) {
          return BlocProvider(
            create: (context) => di.locator<BtsPtBloc>(),
            child: BottomSheetPT(
              sivilPageContext: sivilMainPageContext,
            ),
          );
        },
      );
    },
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.r),
        border: Border.all(color: abu6, width: 1),
      ),
      child: BlocBuilder<SivilBloc, SivilState>(
        builder: (context, state) {
          if (state is SivilInitialState) {
            Logger().i("TextFieldPt state : ${state.pt?.nama}");
            textEditingController.value =
                textEditingController.value.copyWith(text: state.pt?.nama);
            if (state.pt != null) {
              ptObject["kodePT"] = state.pt!.kode;
            }
          }
          return TextFormField(
            style: TextStyle(
              fontSize: 14.sp,
              color: neutral60,
              fontWeight: FontWeight.w400,
            ),
            controller: textEditingController,
            decoration: styleBorderWithDropdown("--Perguruan Tinggi--"),
            enabled: false,
          );
        },
      ),
    ),
  );
}

Widget textFieldProdiPDDikti(
    BuildContext sivilMainPageContext,
    TextEditingController textEditingController,
    Map<String, String> selectedProdiObject) {
  return BlocBuilder<SivilBloc, SivilState>(
    builder: (context, state) {
      if (state is SivilInitialState) {
        Logger().i("TextFieldProdi state : ${state.prodi?.nama}");
        if (state.prodi?.jenjangDidik.nama != null &&
            state.prodi?.nama != null) {
          textEditingController.value = textEditingController.value.copyWith(
              text: "${state.prodi?.jenjangDidik.nama} ${state.prodi?.nama}");
          if (state.prodi != null) {
            print("state.pt != null");
            selectedProdiObject["kodeProdi"] = state.prodi!.kode;
          }
        } else {
          textEditingController.clear();
        }

        return GestureDetector(
          onTap: () {
            if (state.pt?.id != null) {
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
              border: Border.all(color: abu6, width: 1),
              // color: white,
            ),
            child: TextFormField(
              style: TextStyle(
                fontSize: 14.sp,
                color: neutral60,
                fontWeight: FontWeight.w400,
              ),
              controller: textEditingController,
              decoration: styleBorderWithDropdown("Program Studi"),
              enabled: false,
            ),
          ),
        );
      }
      return SizedBox();
    },
  );
}

Widget textFieldProvinsi(
    BuildContext sivilMainPageContext,
    TextEditingController textEditingController,
    Map<String, String> listAllProvinsi,
    Map<String, String> selectedProvinsiObject) {
  return BlocBuilder<BottomSheetFormBloc, BottomSheetFormState>(
    builder: (context, state) {
      if (state is BottomSheetFormInitialState) {
        Logger().i("TextFieldProvinsi state : ${state.namaProvinsi}");
        if (state.namaProvinsi != null && state.namaProvinsi != null) {
          textEditingController.value =
              textEditingController.value.copyWith(text: state.namaProvinsi);
          if (state.kodeProvinsi != null) {
            selectedProvinsiObject["kodeProvinsi"] = state.kodeProvinsi!.trim();
          }
        } else {
          textEditingController.clear();
        }

        return GestureDetector(
          onTap: () {
            showModalBottomSheet(
              isScrollControlled: true,
              isDismissible: true,
              backgroundColor: Colors.transparent,
              context: sivilMainPageContext,
              builder: (context) {
                return BlocProvider(
                  create: (context) => di.locator<BtsProvinsiBloc>(),
                  child: BottomSheetProvinsi(
                    sivilPageContext: sivilMainPageContext,
                    listAllProvinsi: listAllProvinsi,
                  ),
                );
              },
            );
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.r),
              border: Border.all(color: abu6, width: 1),
            ),
            child: TextFormField(
              style: TextStyle(
                fontSize: 14.sp,
                color: neutral60,
                fontWeight: FontWeight.w400,
              ),
              controller: textEditingController,
              decoration: styleBorderWithDropdown("Tuliskan Nama Provinsi"),
              enabled: false,
            ),
          ),
        );
      }
      return SizedBox();
    },
  );
}

InputDecoration styleBorderWithDropdown(String hint) {
  return InputDecoration(
    isDense: true,
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
