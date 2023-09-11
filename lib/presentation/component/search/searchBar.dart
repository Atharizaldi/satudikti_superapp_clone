import 'package:app/presentation/component/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OptionFilter {
  String name;
  bool isChecked;

  OptionFilter({required this.name, this.isChecked = true});
}

enum TypeSearchBar { regular, withClear, withFilter }

class SearchBar extends StatefulWidget {
  /// [required] for the 'withClear' [searchType]
  final TextEditingController? controller;
  final EdgeInsets? margin;
  final Color? iconColor;
  final bool? openKeyboard;
  final Function(String)? isSubmitted;
  final String hintText;
  final List<BoxShadow>? boxShadowList;

  /// [required] for the 'listOption' [searchType]
  ///
  /// Example of 'listOption' object:
  /// List<OptionFilter> filterOptions = [
  ///  OptionFilter(name: "Umum"),
  ///  OptionFilter(name: "Mahasiswa"),
  ///  OptionFilter(name: "Dosen")
  /// ];
  final List<OptionFilter>? listOption;

  /// Search bar with clear requires [controller]
  ///
  /// Search bar with filter requires [listOption]
  ///
  /// Regular search bar doesn't requires anything
  final TypeSearchBar searchType;

  SearchBar({
    Key? key,
    this.margin = EdgeInsets.zero,
    this.iconColor = abu,
    this.openKeyboard = false,
    this.controller,
    this.isSubmitted,
    this.boxShadowList,
    this.listOption,
    required this.hintText,
    required this.searchType,
  })  : assert(
            (searchType == TypeSearchBar.regular) ||
                ((searchType == TypeSearchBar.withClear) &&
                    (controller != null)) ||
                ((searchType == TypeSearchBar.withFilter) &&
                    (listOption != null)),
            "\n\nBaca dulu ges\nPlease give either 'controller' or 'listOption' parameter \nbecause search bar '.withClear' requires 'controller' and \nsearch bar '.withFilter' requires 'listOption'"),
        super(key: key);

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  bool isCheckedAll = false;

  List<OptionFilter> cloneList(
      List<OptionFilter> list, List<OptionFilter> targetList) {
    for (OptionFilter option in list) {
      targetList
          .add(OptionFilter(name: option.name, isChecked: option.isChecked));
    }
    return targetList;
  }

  void updateList(List<OptionFilter> list, List<OptionFilter> targetList) {
    for (int i = 0; i < list.length; i++) {
      if (targetList[i].name == list[i].name) {
        targetList[i].isChecked = list[i].isChecked;
      }
    }
  }

  bool allChecked(List<OptionFilter> options) {
    return options.where((option) => option.isChecked == true).length ==
        options.length;
  }

  @override
  Widget build(BuildContext context) {
    List<OptionFilter> cloneOptions = [];
    cloneList(widget.listOption ?? [], cloneOptions);

    return Container(
      width: double.infinity,
      margin: widget.margin,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        boxShadow: widget.boxShadowList ??
            [
              BoxShadow(
                  color: Color.fromRGBO(92, 94, 97, 0.06),
                  offset: Offset(0, 12),
                  blurRadius: 16,
                  spreadRadius: -4),
              BoxShadow(
                  color: Color.fromRGBO(92, 94, 97, 0.03),
                  offset: Offset(0, 4),
                  blurRadius: 6,
                  spreadRadius: -2)
            ],
      ),
      child: CupertinoTextField(
        style: TextStyle(
          fontSize: 14.sp,
        ),
        controller: widget.controller,
        autofocus: widget.openKeyboard ?? false,
        onSubmitted: widget.isSubmitted,
        textInputAction: TextInputAction.search,
        textAlignVertical: TextAlignVertical.center,
        placeholder: widget.hintText,
        placeholderStyle: TextStyle(
            color: neutralCaption,
            fontSize: 14.sp,
            fontFamily: "Plus Jakarta Sans"),
        padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
        prefix: searchBarPrefix(widget.searchType),
        suffix: searchBarSuffix(widget.searchType, cloneOptions),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.sp),
          color: white,
        ),
      ),
    );
  }

  Widget searchBarPrefix(TypeSearchBar searchType) {
    switch (searchType) {
      case TypeSearchBar.withClear:
        return Container(
          margin: EdgeInsets.only(left: 20.sp),
          child: Image.asset(
            'assets/icons/search_active.png',
            width: 20.sp,
            color: widget.iconColor ?? abu6,
          ),
        );
      case TypeSearchBar.regular:
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

  Widget searchBarSuffix(TypeSearchBar searchType, List<OptionFilter> options) {
    bool isOptionAllChecked = allChecked(options);
    switch (searchType) {
      case TypeSearchBar.withClear:
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
      case TypeSearchBar.withFilter:
        return Container(
          margin: EdgeInsets.only(right: 16.w),
          child: IconButton(
            padding: EdgeInsets.zero,
            constraints: BoxConstraints(),
            onPressed: () {
              showModalBottomSheet<void>(
                context: context,
                builder: (BuildContext context) {
                  return StatefulBuilder(
                    builder: (BuildContext context, StateSetter setState) {
                      var textStyle = TextStyle(fontSize: 14.sp);
                      return SingleChildScrollView(
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 16.h, vertical: 30.h),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              // mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Center(
                                    child: Text(
                                  'Filter Pencarian',
                                  style: TextStyle(fontSize: 18.sp),
                                )),
                                SizedBox(
                                  height: 20.h,
                                ),
                                CheckboxListTile(
                                    contentPadding: EdgeInsets.only(left: 4),
                                    controlAffinity:
                                        ListTileControlAffinity.leading,
                                    title: Text(
                                      "All",
                                      style: textStyle,
                                    ),
                                    value: isOptionAllChecked,
                                    onChanged: (val) {
                                      setState(() {
                                        var listNotCheckedOption =
                                            options.where((option) =>
                                                (!option.isChecked));

                                        isCheckedAll =
                                            listNotCheckedOption.length == 0;

                                        isOptionAllChecked =
                                            (isCheckedAll) ? false : true;

                                        for (OptionFilter option in options) {
                                          if (isCheckedAll) {
                                            option.isChecked = false;
                                          } else {
                                            option.isChecked = true;
                                          }
                                        }
                                      });
                                    }),
                                ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: options.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return CheckboxListTile(
                                        controlAffinity:
                                            ListTileControlAffinity.leading,
                                        title: Text(
                                          options[index].name,
                                          style: textStyle,
                                        ),
                                        value: options[index].isChecked,
                                        selected: options[index].isChecked,
                                        onChanged: (val) {
                                          setState(() {
                                            options[index].isChecked =
                                                !options[index].isChecked;

                                            if (!options[index].isChecked) {
                                              isOptionAllChecked = false;
                                            } else {
                                              if (allChecked(options)) {
                                                isOptionAllChecked = true;
                                              }
                                            }
                                          });
                                        });
                                  },
                                ),
                                SizedBox(
                                  height: 10.w,
                                ),
                                Center(
                                  child: Material(
                                    borderRadius: BorderRadius.circular(5.r),
                                    color: blue4,
                                    child: InkWell(
                                      splashColor: Colors.blue,
                                      onTap: () {
                                        updateList(options, widget.listOption!);
                                        Navigator.pop(context);
                                      },
                                      child: Container(
                                        height: 36.sp,
                                        width: 141.w,
                                        decoration: BoxDecoration(
                                            // color: blue4,
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        child: Center(
                                          child: Text(
                                            'Filter',
                                            style: TextStyle(
                                                color: white,
                                                fontSize: 14.sp,
                                                letterSpacing: 1,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ).whenComplete(() {
                setState(() {});
              });
            },
            icon: Image.asset(
              'assets/icons/icon_filter.png',
              width: 20.sp,
              color: widget.iconColor ?? neutral40,
            ),
          ),
        );
      default:
        return SizedBox();
    }
  }
}
