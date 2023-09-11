import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DropDownBima extends StatefulWidget {
  final List<String> items;
  DropDownBima({Key? key, required this.items}) : super(key: key);

  @override
  State<DropDownBima> createState() => _DropDownBimaState();
}

class _DropDownBimaState extends State<DropDownBima> {
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return Container(
        child: DropdownButtonHideUnderline(
      child: DropdownButton2(
        isExpanded: true,
        hint: Row(
          children: [
            Expanded(
              child: Text(
                'Tampilkan berdasarkan',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: Color.fromRGBO(102, 112, 133, 1),
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        items: widget.items
            .map((item) => DropdownMenuItem<String>(
                  value: item,
                  child: Text(
                    item,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: Color.fromRGBO(16, 24, 40, 1),
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ))
            .toList(),
        value: selectedValue,
        onChanged: (value) {
          setState(() {
            selectedValue = value as String;
          });
        },
        dropdownDecoration:
            BoxDecoration(borderRadius: BorderRadius.circular(8.r)),
        buttonHeight: 41.w,
        buttonWidth: 216.w,
        buttonPadding: EdgeInsets.symmetric(vertical: 10.w, horizontal: 14.w),
        buttonDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(
            color: Color.fromRGBO(208, 213, 221, 1),
          ),
          color: Colors.white,
        ),
        icon: Icon(
          Icons.expand_more_rounded,
        ),
        iconSize: 20.sp,
        iconEnabledColor: Color.fromRGBO(102, 112, 133, 1),
        iconDisabledColor: Colors.grey,
        iconOnClick: Icon(
          Icons.expand_less_rounded,

          // dropdownStyleData: DropdownStyleData(
          //   direction: DropdownDirection.right,
          //   width: 250.w,
          //   // padding: EdgeInsets.only(bottom: 10.w),
          //   maxHeight: 320.w,
          //   decoration: BoxDecoration(
          //     borderRadius: BorderRadius.circular(8.r),
          //     color: Colors.white,
          //   ),
          //   elevation: 8,
          //   offset: const Offset(-20, 0),
          //   scrollbarTheme: ScrollbarThemeData(
          //     radius: Radius.circular(8.r),
          //     thickness: MaterialStateProperty.all<double>(8),
          //     thumbVisibility: MaterialStateProperty.all<bool>(true),
          //   ),
          // ),
          // menuItemStyleData: MenuItemStyleData(
          //   height: 35.w,
          //   padding: EdgeInsets.symmetric(horizontal: 18.w),
          // ),
        ),
      ),
    ));
  }
}
