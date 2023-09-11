import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DropDownSister extends StatefulWidget {
  final List<String> items;
  String value;
  final void Function(Object?) onChanged;

  DropDownSister({
    Key? key,
    required this.onChanged,
    required this.value,
    required this.items,
  }) : super(key: key);

  @override
  State<DropDownSister> createState() => _DropDownSisterState();
}

class _DropDownSisterState extends State<DropDownSister> {
  // final List<String> itemsa = [
  //   'Nama Diklat : A - Z',
  //   'Nama Diklat : Z - A',
  //   'Jenis Diklat: Formal',
  //   'Jenis Diklat: Unformal',
  //   'Tahun: Terkini',
  //   'Tahun: Terdahulu',
  //   'Jenis Diklat: Unformal',
  //   'Tahun: Terkini',
  //   'Tahun: Terdahulu',
  //   'Jenis Diklat: Unformal',
  //   'Tahun: Terkini',
  //   'Tahun: Terdahulu',
  // ];
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
            value: widget.value,
            // selectedValue,
            onChanged: widget.onChanged,
            //   (valuae) {
            // setState(() {
            //   widget.value = valuae as String;
            //   selectedValue = valuae as String;
            //   print(widget.value);
            // });
            // },
            buttonHeight: 41.w,
            buttonWidth: 216.w,
            buttonPadding:
                EdgeInsets.symmetric(vertical: 10.w, horizontal: 14.w),
            buttonDecoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(
                color: Color.fromRGBO(208, 213, 221, 1),
              ),
              color: Colors.white,
            ),
            dropdownDecoration:
                BoxDecoration(borderRadius: BorderRadius.circular(8.r)),
            icon: Icon(
              Icons.expand_more_rounded,
            ),
            iconSize: 20.sp,
            iconEnabledColor: Color.fromRGBO(102, 112, 133, 1),
            iconDisabledColor: Colors.grey,
            iconOnClick: Icon(Icons.expand_less_rounded)),
      ),
    );
  }
}
