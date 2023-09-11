import 'dart:async';

import 'package:app/presentation/component/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../ijazahln/component/type_field_pt.dart';

class BottomSheetFormField extends StatefulWidget {
  final BuildContext kuesionerPageContext;
  final TextEditingController textEditingController;
  final String hintText;

  BottomSheetFormField({
    required this.kuesionerPageContext, 
    required this.textEditingController, 
    required this.hintText
    }) : super();

  @override
  State<BottomSheetFormField> createState() => _BottomSheetFormFieldState();
}

class _BottomSheetFormFieldState extends State<BottomSheetFormField> {
  Timer? _debounce;
  List<String> historyList = [];
  late String textField;

  TextStyle textStyle = TextStyle(
      color: neutral30,
      fontWeight: FontWeight.w400,
      fontSize: 14.sp,
      letterSpacing: 0.5);
  
  @override
  void initState() {
    super.initState();
    setTextField();
    getDataHistory();
  }

  static Future<SharedPreferences> getPrefs() async {
    final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    return await _prefs;
  }

  void getDataHistory() async {
    SharedPreferences prefs = await getPrefs();
    setState(() {
      if(prefs.getStringList(textField)!.isNotEmpty){
        historyList = prefs.getStringList(textField)!;
      }
    });
  }

  void setTextField(){
    if(widget.hintText == 'Nama Ibu Kandung'){
      textField = 'Text1';
    } else{
      textField = 'Text2';
    }
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
              child: content(widget.textEditingController),
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
        autofocus: true,
        style: textStyle.copyWith(color: neutral80),
        controller: widget.textEditingController,
        decoration: styleWithSearchPrefix(widget.hintText),
        onEditingComplete: ()async{
          SharedPreferences prefs = await getPrefs();
          if(textEditingController.text.isNotEmpty){
            setState(() {
              historyList.add(textEditingController.text);
            });
            if(historyList.length > 3){
              historyList.removeAt(0);
            }
            prefs.remove(textField);
            prefs.setStringList(textField, historyList.toList(growable: false));
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
            widget.textEditingController.text = listStringHistory[index];
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
                    prefs.remove(textField);
                    prefs.setStringList(textField, historyList.toList(growable: false));
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
    _debounce?.cancel();
    super.dispose();
  }
}
