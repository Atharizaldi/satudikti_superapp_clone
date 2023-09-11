import 'package:app/presentation/component/constant.dart';
import 'package:app/presentation/component/customSliverBar.dart';
import 'package:app/presentation/pages/beranda/beasiswa/search_beasiswa_bloc/search_beasiswa_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum TypeSearchBarBeasiswa { regular, withClear, withFilter }

// ignore: must_be_immutable
class NewSearchBarBeasiswa extends StatefulWidget {
  /// [required] for the 'withClear' [searchType]
  final TextEditingController? controller;
  EdgeInsets? margin = EdgeInsets.zero;
  Color? iconColor = abu;
  bool? openKeyboard = false;
  final Function(String)? isSubmitted;
  final Function(String)? onChanged;

  final String hintText;
  final List<BoxShadow>? boxShadowList;
  bool tappedBeasiswa;
  String searchKeywordBeasiswa;

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
  final TypeSearchBarBeasiswa searchType;

  NewSearchBarBeasiswa(
      {Key? key,
      this.margin,
      this.iconColor,
      this.openKeyboard,
      this.controller,
      this.isSubmitted,
      this.onChanged,
      this.boxShadowList,
      required this.hintText,
      required this.searchType,
      required this.tappedBeasiswa,
      required this.searchKeywordBeasiswa})
      : assert(
            (searchType == TypeSearchBarBeasiswa.regular) ||
                ((searchType == TypeSearchBarBeasiswa.withClear) &&
                    (controller != null)) ||
                ((searchType == TypeSearchBarBeasiswa.withFilter)),
            "\n\nBaca dulu ges\nPlease give either 'controller' or 'listOption' parameter \nbecause search bar '.withClear' requires 'controller' and \nsearch bar '.withFilter' requires 'listOption'"),
        super(key: key);

  @override
  _NewSearchBarBeasiswaState createState() => _NewSearchBarBeasiswaState();
}

int? idFilterBeasiswa = 0;

class _NewSearchBarBeasiswaState extends State<NewSearchBarBeasiswa> {
  String? checkColor = "Semua";
  late SearchBeasiswaBloc searchBeasiswaBloc;

  @override
  Widget build(BuildContext context) {
    searchBeasiswaBloc = BlocProvider.of<SearchBeasiswaBloc>(context);
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

  Widget searchBarPrefix(TypeSearchBarBeasiswa searchType) {
    switch (searchType) {
      case TypeSearchBarBeasiswa.regular:
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

  Widget searchBarSuffix(TypeSearchBarBeasiswa searchType) {
    switch (searchType) {
      case TypeSearchBarBeasiswa.withClear:
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
      case TypeSearchBarBeasiswa.withFilter:
        return Container(
          margin: EdgeInsets.only(right: 16.w),
          child: IconButton(
            padding: EdgeInsets.zero,
            constraints: BoxConstraints(),
            onPressed: () {
              myBuild(context);
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

  void myBuild(BuildContext context) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10.r),
            topRight: Radius.circular(10.r),
          ),
        ),
        // isDismissible: true,
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return Builder(builder: (context) {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 8.w),
                    Center(child: greyIconBar()),
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 17.w, vertical: 30.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Filter',
                            style: TextStyle(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w700,
                                color: blue3),
                          ),
                          SizedBox(
                            height: 30.w,
                          ),
                          Text(
                            'Penerima Beasiswa',
                            style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w700,
                                color: blue3),
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          Wrap(runSpacing: 10.w, spacing: 10.w, children: [
                            GestureDetector(
                                onTap: () {
                                  setState(() {
                                    idFilterBeasiswa = 0;
                                    checkColor = "Semua";
                                  });
                                  searchBeasiswaBloc.add(
                                      FetchSearchBeasiswaEvent(
                                          keyword: widget.searchKeywordBeasiswa
                                              .toString()));
                                },
                                child: containerFilter(
                                    colorsText: checkColor == "Semua"
                                        ? Colors.white
                                        : Colors.black,
                                    title: "Semua",
                                    colors: checkColor == "Semua"
                                        ? blue3
                                        : Colors.white)),
                            GestureDetector(
                                onTap: () {
                                  setState(() {
                                    idFilterBeasiswa = 3;
                                    checkColor = "Umum";
                                  });
                                  searchBeasiswaBloc.add(
                                      FetchSearchBeasiswaFilterEvent(
                                          keyword: widget.searchKeywordBeasiswa
                                              .toString(),
                                          penerima: 3));
                                },
                                child: containerFilter(
                                    colorsText: checkColor == "Umum"
                                        ? Colors.white
                                        : Colors.black,
                                    title: "Umum",
                                    colors: checkColor == "Umum"
                                        ? blue3
                                        : Colors.white)),
                            GestureDetector(
                                onTap: () {
                                  setState(() {
                                    idFilterBeasiswa = 2;
                                    checkColor = "Mahasiswa";
                                  });
                                  searchBeasiswaBloc.add(
                                      FetchSearchBeasiswaFilterEvent(
                                          keyword: widget.searchKeywordBeasiswa
                                              .toString(),
                                          penerima: 2));
                                },
                                child: containerFilter(
                                    colorsText: checkColor == "Mahasiswa"
                                        ? Colors.white
                                        : Colors.black,
                                    title: "Mahasiswa",
                                    colors: checkColor == "Mahasiswa"
                                        ? blue3
                                        : Colors.white)),
                            GestureDetector(
                                onTap: () {
                                  setState(() {
                                    idFilterBeasiswa = 1;
                                    checkColor = "Dosen";
                                  });
                                  searchBeasiswaBloc.add(
                                      FetchSearchBeasiswaFilterEvent(
                                          keyword: widget.searchKeywordBeasiswa
                                              .toString(),
                                          penerima: 1));
                                },
                                child: containerFilter(
                                    colorsText: checkColor == "Dosen"
                                        ? Colors.white
                                        : Colors.black,
                                    title: "Dosen",
                                    colors: checkColor == "Dosen"
                                        ? blue3
                                        : Colors.white))
                          ])
                        ],
                      ),
                    )
                  ],
                ),
              );
            });
          });
        }).then((value) {
      setState(() {});
    });
  }

  Container containerFilter(
      {required String title,
      required Color colors,
      required Color colorsText}) {
    return Container(
        decoration: BoxDecoration(
            color: colors,
            border: Border.all(color: abu6),
            borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding:
              EdgeInsets.only(top: 10.w, bottom: 10.w, left: 20.w, right: 20.w),
          child: Text(
            title,
            style: TextStyle(
              color: colorsText,
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ));
  }
}
