import 'dart:async';

import 'package:app/presentation/component/constant.dart';
import 'package:app/presentation/pages/beranda/sivil/bloc/sivil_bloc.dart';
import 'package:app/presentation/pages/beranda/sivil/component/text_field_sivil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BottomSheetNoIjazah extends StatefulWidget {
  final BuildContext sivilPageContext;

  BottomSheetNoIjazah({required this.sivilPageContext}) : super();

  @override
  State<BottomSheetNoIjazah> createState() => _BottomSheetNoIjazahState();
}

class _BottomSheetNoIjazahState extends State<BottomSheetNoIjazah> {
  TextEditingController textEditingController = TextEditingController();
  Timer? _debounce;
  List<String> historyList = [];

  TextStyle textStyle = TextStyle(
      color: neutral30,
      fontWeight: FontWeight.w400,
      fontSize: 14.sp,
      letterSpacing: 0.5);
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDataHistory();
  }

  static Future<SharedPreferences> getPrefs() async {
    final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    return await _prefs;
  }

  void getDataHistory() async {
    SharedPreferences prefs = await getPrefs();
    setState(() {
      if(prefs.getStringList("noIjazah")!.isNotEmpty){
        historyList = prefs.getStringList("noIjazah")!;
      }
    });
  }

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
          child: buildHistoryList(historyList, textEditingController),
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
        style: textStyle.copyWith(color: neutral80),
        controller: textEditingController,
        autofocus: true,
        decoration: styleWithSearchPrefix("Tuliskan Nomor Ijazah"),
        onChanged: (value) {
          BlocProvider.of<SivilBloc>(widget.sivilPageContext)
                .add(UpdateNoIjazahEvent(noIjazah: value));
        },
        onEditingComplete: ()async{
          SharedPreferences prefs = await getPrefs();
          if(textEditingController.text.isNotEmpty){
            setState(() {
              historyList.add(textEditingController.text);
            });
            if(historyList.length > 3){
              historyList.removeAt(0);
            }
            prefs.remove("noIjazah");
            prefs.setStringList("noIjazah", historyList.toList(growable: false));
          }
          Navigator.pop(context);
        },
      ),
    );
  }

  Widget buildHistoryList(List<String> listStringHistory, TextEditingController textEditingController) {
    return ListView.builder(
      itemCount: listStringHistory.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            textEditingController.text = listStringHistory[index];
            BlocProvider.of<SivilBloc>(widget.sivilPageContext)
                .add(UpdateNoIjazahEvent(noIjazah: textEditingController.text));
            FocusManager.instance.primaryFocus?.unfocus();
            Navigator.pop(context);
          },
          child: Container(
            child: ListTile(
              horizontalTitleGap: 1,
              leading: Icon(
                Icons.refresh
              ),
              title: Text(
                "${listStringHistory[index]}",
                style: textStyle.copyWith(color: neutral60),
              ),
              trailing: GestureDetector(
                onTap: ()async{
                  SharedPreferences prefs = await getPrefs();
                  setState(() {
                    historyList.removeAt(index);
                    prefs.remove("noIjazah");
                    prefs.setStringList("noIjazah", historyList.toList(growable: false));
                  });
                },
                child: Icon(
                  Icons.close
                ),
              )
            )
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
