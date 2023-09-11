import 'package:app/data/source/remote/model/IjazahLN/verifikasi/negaraIjazahLNList.dart';
import 'package:app/presentation/component/constant.dart';
import 'package:app/presentation/pages/beranda/ijazahln/bloc/bts_negara_bloc/bts_negara_bloc.dart';
import 'package:app/presentation/pages/beranda/ijazahln/bloc/ijazahln/verifikasisk/negarapt/negara_bloc.dart';
import 'package:app/presentation/pages/beranda/sivil/component/bts_component.dart';
import 'package:app/presentation/pages/beranda/sivil/component/text_field_sivil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BottomSheetNegara extends StatefulWidget {
  final BuildContext ijazahPageContext;

  BottomSheetNegara({required this.ijazahPageContext}) : super();

  @override
  State<BottomSheetNegara> createState() => _BottomSheetNegaraState();
}

class _BottomSheetNegaraState extends State<BottomSheetNegara> {
  TextEditingController textEditingController = TextEditingController();

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
          child: BlocBuilder<BtsNegaraBlocBloc, BtsNegaraBlocState>(
            builder: (context, state) {
              if (state is BtsNegaraNoInternetState) {
                return btsNoInternet();
              } else if (state is BtsNegaraNotFoundState) {
                return btsNotFound("Negara Tidak Ditemukan");
              } else if (state is BtsNegaraLoadedState) {
                return buildNegaraList(
                  state.listNegaraTemp,
                );
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
        decoration: styleWithSearchPrefix("Cari Asal Negara"),
        onChanged: (value) {
          print("INI VALUENYA $value");
          BlocProvider.of<BtsNegaraBlocBloc>(context)
              .add(BtsSearchNegaraEvent(query: value));
        },
      ),
    );
  }

  Widget buildNegaraList(
    List<Negara> listNegara,
  ) {
    return ListView.builder(
      itemCount: listNegara.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            BlocProvider.of<NegaraBloc>(widget.ijazahPageContext).add(
                UpdateNegaraEvent(
                    kodeNegara: listNegara[index].negaraId,
                    namaNegara: listNegara[index].negaraName));
            FocusManager.instance.primaryFocus?.unfocus();
            Navigator.pop(context);
          },
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
            child: Text(
              "${listNegara[index].negaraName}",
              style: textStyle.copyWith(color: neutral60),
            ),
          ),
        );
      },
    );
  }

  // @override
  // void dispose() {
  //   textEditingController.dispose();
  //   super.dispose();
  // }
}
