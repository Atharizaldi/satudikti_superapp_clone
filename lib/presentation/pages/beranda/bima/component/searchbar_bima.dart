import 'package:app/presentation/component/constant.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum TypeSearchBarBima { regular, withClear, withDropdownFilter }

// ignore: must_be_immutable
class SearchBarBima extends StatefulWidget {
  SearchBarBima(
      {Key? key,
      this.margin,
      this.iconColor,
      this.controller,
      this.isSubmitted,
      this.onChanged,
      this.boxShadowList,
      required this.hintText,
      required this.searchType,
      required this.tappedPengumuman,
      required this.searchKeywordPengumuman,
      required this.items})
      : assert(
            (searchType == TypeSearchBarBima.regular) ||
                ((searchType == TypeSearchBarBima.withClear) &&
                    (controller != null)) ||
                ((searchType == TypeSearchBarBima.withDropdownFilter)),
            "\n\nBaca dulu ges\nPlease give either 'controller' or 'listOption' parameter \nbecause search bar '.withClear' requires 'controller' and \nsearch bar '.withFilter' requires 'listOption'"),
        super(key: key);

  /// [required] for the 'withClear' [searchType]
  final TextEditingController? controller;
  EdgeInsets? margin = EdgeInsets.zero;
  Color? iconColor = abu;
  bool? openKeyboard = false;
  final Function(String)? isSubmitted;
  final Function(String)? onChanged;
  final String hintText;
  final List<BoxShadow>? boxShadowList;
  bool tappedPengumuman;
  String searchKeywordPengumuman;
  final List<String> items;

  /// [required] for the 'listOption' [searchType]
  ///
  /// Example of 'listOption' object:
  /// List<OptionFilter> filterOptions = [
  ///  OptionFilter(name: "Umum"),
  ///  OptionFilter(name: "Mahasiswa"),
  ///  OptionFilter(name: "Dosen")
  /// ];

  /// Search bar with clear requires [controller]
  ///
  /// Search bar with filter requires [listOption]
  ///
  /// Regular search bar doesn't requires anything
  final TypeSearchBarBima searchType;

  @override
  State<SearchBarBima> createState() => _SearchBarBimaState();
}

int? idFilterPengumuman = 0;

class _SearchBarBimaState extends State<SearchBarBima> {
  String? selectedValue;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: widget.margin,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        boxShadow: widget.boxShadowList ??
            [
              BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.04),
                offset: Offset(0, 2),
                blurRadius: 6,
              )
            ],
      ),
      child: CupertinoTextField(
        style: TextStyle(
          fontSize: 14.sp,
        ),
        controller: widget.controller,
        autofocus: widget.openKeyboard ?? false,
        onSubmitted: widget.isSubmitted,
        onChanged: widget.onChanged,
        textInputAction: TextInputAction.search,
        textAlignVertical: TextAlignVertical.center,
        placeholder: widget.hintText,
        placeholderStyle: TextStyle(
            color: neutralCaption,
            fontSize: 14.sp,
            fontFamily: "Plus Jakarta Sans"),
        padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
        prefix: searchBarPrefix(widget.searchType),
        suffix: searchBarSuffix(widget.searchType),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.sp),
          color: white,
        ),
      ),
    );
  }

  Widget searchBarPrefix(TypeSearchBarBima searchType) {
    switch (searchType) {
      case TypeSearchBarBima.regular:
        return Container(
          margin: EdgeInsets.only(left: 20.sp),
          child: Image.asset(
            'assets/icons/search_active.png',
            width: 20.sp,
            color: widget.iconColor ?? abu6,
          ),
        );
      case TypeSearchBarBima.withDropdownFilter:
        return Container(
          margin: EdgeInsets.only(left: 20.sp),
          child: Image.asset(
            'assets/icons/search_active.png',
            width: 20.sp,
            color: widget.iconColor ?? abu6,
          ),
        );
      default:
        return SizedBox();
    }
  }

  Widget searchBarSuffix(TypeSearchBarBima searchType) {
    switch (searchType) {
      case TypeSearchBarBima.withClear:
        return Container(
          margin: EdgeInsets.only(right: 20.w),
          child: IconButton(
            padding: EdgeInsets.zero,
            constraints: BoxConstraints(),
            onPressed: () {
              (widget.controller)!.clear();
            },
            icon: Icon(
              Icons.clear,
              color: widget.iconColor ?? abu8,
              size: 20.sp,
            ),
          ),
        );

      case TypeSearchBarBima.withDropdownFilter:
        return Container(
            margin: EdgeInsets.only(right: 10.w),
            child: Container(
              child: DropdownButtonHideUnderline(
                child: DropdownButton2(
                  isExpanded: true,
                  hint: Row(
                    children: [
                      VerticalDivider(
                        thickness: 1,
                      ),
                      SizedBox(
                        width: 14.w,
                      ),
                      Expanded(
                        child: Text(
                          'Category',
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                            color: Color.fromRGBO(31, 41, 55, 1),
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
                  buttonPadding:
                      EdgeInsets.symmetric(vertical: 10.w, horizontal: 14.w),
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
                  ),
                ),
              ),
            ));
      default:
        return SizedBox();
    }
  }
}
