import 'package:app/presentation/component/constant.dart';
import 'package:app/presentation/pages/beranda/garuda/bloc/garuda_journal/searching_journal/garuda_searching_journal_bloc.dart';
import 'package:app/presentation/pages/beranda/garuda/components/detailSearchBarGarudaJournal.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum TypeSearchBarGarudaJournal { regular, withClear, withFilter }

class SearchBarGarudaJournal extends StatefulWidget {
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

  /// Search bar with clear requires [controller]
  ///
  /// Search bar with filter requires [listOption]
  ///
  /// Regular search bar doesn't requires anything
  final TypeSearchBarGarudaJournal searchType;

  SearchBarGarudaJournal({
    Key? key,
    this.margin = EdgeInsets.zero,
    this.iconColor = abu,
    this.openKeyboard = false,
    this.controller,
    this.isSubmitted,
    this.boxShadowList,
    required this.hintText,
    required this.searchType,
  })  : assert(
            (searchType == TypeSearchBarGarudaJournal.regular) ||
                ((searchType == TypeSearchBarGarudaJournal.withClear) &&
                    (controller != null)) ||
                ((searchType == TypeSearchBarGarudaJournal.withFilter)),
            "\n\nBaca dulu ges\nPlease give either 'controller' or 'listOption' parameter \nbecause search bar '.withClear' requires 'controller' and \nsearch bar '.withFilter' requires 'listOption'"),
        super(key: key);

  @override
  _SearchBarGarudaJournalState createState() => _SearchBarGarudaJournalState();
}

int? idFilter = 1;

class _SearchBarGarudaJournalState extends State<SearchBarGarudaJournal> {
  late GarudaSearchingJournalBloc garudaBloc;
  @override
  void initState() {
    widget.controller!.addListener(() {
      setState(() {
        searchKeywordtemp = widget.controller!.text;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    widget.controller!.dispose();
    super.dispose();
  }

  String filter = "semua";
  @override
  Widget build(BuildContext context) {
    garudaBloc = BlocProvider.of<GarudaSearchingJournalBloc>(context);
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

  Widget searchBarPrefix(TypeSearchBarGarudaJournal searchType) {
    switch (searchType) {
      case TypeSearchBarGarudaJournal.regular:
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

  Widget searchBarSuffix(TypeSearchBarGarudaJournal searchType) {
    switch (searchType) {
      case TypeSearchBarGarudaJournal.withClear:
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
      case TypeSearchBarGarudaJournal.withFilter:
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
          borderRadius: BorderRadius.circular(10.0),
        ),
        // isDismissible: true,
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return Container(
                padding: EdgeInsets.all(10),
                child: DraggableScrollableSheet(
                    expand: false,
                    initialChildSize: 0.55,
                    maxChildSize: 0.95,
                    minChildSize: 0.55,
                    builder: (context, scrollController) {
                      return ListView(
                        controller: scrollController,
                        children: <Widget>[
                          SizedBox(
                            height: 30.h,
                          ),
                          Text(
                            "Subject",
                            style: TextStyle(
                                color: blue3,
                                fontSize: 20.sp,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 16.h,
                          ),
                          Wrap(
                            spacing: 10.0,
                            children: <Widget>[
                              FilterChip(
                                  side: BorderSide(color: abu6),
                                  labelStyle: TextStyle(
                                      color: abu6,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12.sp),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  selected: (filter == "semua") ? true : false,
                                  showCheckmark: false,
                                  selectedColor: blue3,
                                  backgroundColor: Colors.white,
                                  label: Text("Semua"),
                                  onSelected: (bool value) {
                                    setState(() {
                                      filter = "semua";
                                      idFilter = 1;
                                    });
                                    if (tappedGaruda &&
                                        searchKeywordtemp == searchKeyword) {
                                      garudaBloc.add(GarudaSearchingEvent(
                                          keyword: searchKeyword));
                                    }
                                    print("id $idFilter");
                                  }),
                              FilterChip(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  side: BorderSide(color: abu6),
                                  labelStyle: TextStyle(
                                      color: abu6,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12.sp),
                                  selected: (filter == "Aerospace Engineering")
                                      ? true
                                      : false,
                                  showCheckmark: false,
                                  selectedColor: blue3,
                                  backgroundColor: Colors.white,
                                  label: Text("Aerospace Engineering"),
                                  onSelected: (bool value) {
                                    setState(() {
                                      filter = "Aerospace Engineering";
                                      idFilter = 10;
                                    });
                                    if (tappedGaruda &&
                                        searchKeywordtemp == searchKeyword) {
                                      garudaBloc.add(
                                          GarudaSearchingBySubjectEvent(
                                              id: idFilter.toString(),
                                              keyword: searchKeyword));
                                    }
                                    print("id $idFilter");
                                  }),
                              FilterChip(
                                  side: BorderSide(color: abu6),
                                  labelStyle: TextStyle(
                                      color: abu6,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12.sp),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  selected: (filter ==
                                          "Agriculture, Biological Sciences & Forestry")
                                      ? true
                                      : false,
                                  showCheckmark: false,
                                  selectedColor: blue3,
                                  backgroundColor: Colors.white,
                                  label: Text(
                                      "Agriculture, Biological Sciences & Forestry"),
                                  onSelected: (bool value) {
                                    setState(() {
                                      filter =
                                          "Agriculture, Biological Sciences & Forestry";
                                      idFilter = 20;
                                    });
                                    if (tappedGaruda &&
                                        searchKeywordtemp == searchKeyword) {
                                      garudaBloc.add(
                                          GarudaSearchingBySubjectEvent(
                                              id: idFilter.toString(),
                                              keyword: searchKeyword));
                                    }
                                    print("id $idFilter");
                                  }),
                              FilterChip(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  side: BorderSide(color: abu6),
                                  labelStyle: TextStyle(
                                      color: abu6,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12.sp),
                                  selected: (filter == "Automotive Engineering")
                                      ? true
                                      : false,
                                  showCheckmark: false,
                                  selectedColor: blue3,
                                  backgroundColor: Colors.white,
                                  label: Text("Automotive Engineering"),
                                  onSelected: (bool value) {
                                    setState(() {
                                      filter = "Automotive Engineering";
                                      idFilter = 30;
                                    });
                                    if (tappedGaruda &&
                                        searchKeywordtemp == searchKeyword) {
                                      garudaBloc.add(
                                          GarudaSearchingBySubjectEvent(
                                              id: idFilter.toString(),
                                              keyword: searchKeyword));
                                    }
                                    print("id $idFilter");
                                  }),
                              FilterChip(
                                  side: BorderSide(color: abu6),
                                  labelStyle: TextStyle(
                                      color: abu6,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12.sp),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  selected: (filter ==
                                          "Chemical Engineering, Chemistry & Bioengineering")
                                      ? true
                                      : false,
                                  showCheckmark: false,
                                  selectedColor: blue3,
                                  backgroundColor: Colors.white,
                                  label: Text(
                                      "Chemical Engineering, Chemistry & Bioengineering"),
                                  onSelected: (bool value) {
                                    setState(() {
                                      filter =
                                          "Chemical Engineering, Chemistry & Bioengineering";
                                      idFilter = 40;
                                    });
                                    if (tappedGaruda &&
                                        searchKeywordtemp == searchKeyword) {
                                      garudaBloc.add(
                                          GarudaSearchingBySubjectEvent(
                                              id: idFilter.toString(),
                                              keyword: searchKeyword));
                                    }
                                    print("id $idFilter");
                                  }),
                              FilterChip(
                                  side: BorderSide(color: abu6),
                                  labelStyle: TextStyle(
                                      color: abu6,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12.sp),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  selected: (filter ==
                                          "Civil Engineering, Building, Construction & Architecture")
                                      ? true
                                      : false,
                                  showCheckmark: false,
                                  selectedColor: blue3,
                                  backgroundColor: Colors.white,
                                  label: Text(
                                      "Civil Engineering, Building, Construction & Architecture"),
                                  onSelected: (bool value) {
                                    setState(() {
                                      filter =
                                          "Civil Engineering, Building, Construction & Architecture";
                                      idFilter = 50;
                                    });
                                    if (tappedGaruda &&
                                        searchKeywordtemp == searchKeyword) {
                                      garudaBloc.add(
                                          GarudaSearchingBySubjectEvent(
                                              id: idFilter.toString(),
                                              keyword: searchKeyword));
                                    }
                                    print("id $idFilter");
                                  }),
                              FilterChip(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  side: BorderSide(color: abu6),
                                  labelStyle: TextStyle(
                                      color: abu6,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12.sp),
                                  selected: (filter == "Computer Science & IT")
                                      ? true
                                      : false,
                                  showCheckmark: false,
                                  selectedColor: blue3,
                                  backgroundColor: Colors.white,
                                  label: Text("Computer Science & IT"),
                                  onSelected: (bool value) {
                                    setState(() {
                                      filter = "Computer Science & IT";
                                      idFilter = 60;
                                    });
                                    if (tappedGaruda &&
                                        searchKeywordtemp == searchKeyword) {
                                      garudaBloc.add(
                                          GarudaSearchingBySubjectEvent(
                                              id: idFilter.toString(),
                                              keyword: searchKeyword));
                                    }
                                    print("id $idFilter");
                                  }),
                              FilterChip(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  side: BorderSide(color: abu6),
                                  labelStyle: TextStyle(
                                      color: abu6,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12.sp),
                                  selected: (filter ==
                                          "Control & Systems Engineering")
                                      ? true
                                      : false,
                                  showCheckmark: false,
                                  selectedColor: blue3,
                                  backgroundColor: Colors.white,
                                  label: Text("Control & Systems Engineering"),
                                  onSelected: (bool value) {
                                    setState(() {
                                      filter = "Control & Systems Engineering";
                                      idFilter = 70;
                                    });
                                    if (tappedGaruda &&
                                        searchKeywordtemp == searchKeyword) {
                                      garudaBloc.add(
                                          GarudaSearchingBySubjectEvent(
                                              id: idFilter.toString(),
                                              keyword: searchKeyword));
                                    }
                                    print("id $idFilter");
                                  }),
                              FilterChip(
                                  side: BorderSide(color: abu6),
                                  labelStyle: TextStyle(
                                      color: abu6,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12.sp),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  selected: (filter ==
                                          "Decision Sciences, Operations Research & Management")
                                      ? true
                                      : false,
                                  showCheckmark: false,
                                  selectedColor: blue3,
                                  backgroundColor: Colors.white,
                                  label: Text(
                                      "Decision Sciences, Operations Research & Management"),
                                  onSelected: (bool value) {
                                    setState(() {
                                      filter =
                                          "Decision Sciences, Operations Research & Management";
                                      idFilter = 80;
                                    });
                                    if (tappedGaruda &&
                                        searchKeywordtemp == searchKeyword) {
                                      garudaBloc.add(
                                          GarudaSearchingBySubjectEvent(
                                              id: idFilter.toString(),
                                              keyword: searchKeyword));
                                    }
                                    print("id $idFilter");
                                  }),
                              FilterChip(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  side: BorderSide(color: abu6),
                                  labelStyle: TextStyle(
                                      color: abu6,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12.sp),
                                  selected:
                                      (filter == "Earth & Planetary Sciences")
                                          ? true
                                          : false,
                                  showCheckmark: false,
                                  selectedColor: blue3,
                                  backgroundColor: Colors.white,
                                  label: Text("Earth & Planetary Sciences"),
                                  onSelected: (bool value) {
                                    setState(() {
                                      filter = "Earth & Planetary Sciences";
                                      idFilter = 90;
                                    });
                                    if (tappedGaruda &&
                                        searchKeywordtemp == searchKeyword) {
                                      garudaBloc.add(
                                          GarudaSearchingBySubjectEvent(
                                              id: idFilter.toString(),
                                              keyword: searchKeyword));
                                    }
                                    print("id $idFilter");
                                  }),
                              FilterChip(
                                  side: BorderSide(color: abu6),
                                  labelStyle: TextStyle(
                                      color: abu6,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12.sp),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  selected: (filter ==
                                          "Electrical & Electronics Engineering")
                                      ? true
                                      : false,
                                  showCheckmark: false,
                                  selectedColor: blue3,
                                  backgroundColor: Colors.white,
                                  label: Text(
                                      "Electrical & Electronics Engineering"),
                                  onSelected: (bool value) {
                                    setState(() {
                                      filter =
                                          "Electrical & Electronics Engineering";
                                      idFilter = 100;
                                    });
                                    if (tappedGaruda &&
                                        searchKeywordtemp == searchKeyword) {
                                      garudaBloc.add(
                                          GarudaSearchingBySubjectEvent(
                                              id: idFilter.toString(),
                                              keyword: searchKeyword));
                                    }
                                    print("id $idFilter");
                                  }),
                              //ini baris 2
                              FilterChip(
                                  side: BorderSide(color: abu6),
                                  labelStyle: TextStyle(
                                      color: abu6,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12.sp),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  selected: (filter == "Energy") ? true : false,
                                  showCheckmark: false,
                                  selectedColor: blue3,
                                  backgroundColor: Colors.white,
                                  label: Text("Energy"),
                                  onSelected: (bool value) {
                                    setState(() {
                                      filter = "Energy";
                                      idFilter = 110;
                                    });
                                    if (tappedGaruda &&
                                        searchKeywordtemp == searchKeyword) {
                                      garudaBloc.add(
                                          GarudaSearchingBySubjectEvent(
                                              id: idFilter.toString(),
                                              keyword: searchKeyword));
                                    }
                                    print("id $idFilter");
                                  }),
                              FilterChip(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  side: BorderSide(color: abu6),
                                  labelStyle: TextStyle(
                                      color: abu6,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12.sp),
                                  selected: (filter == "Environmental Science")
                                      ? true
                                      : false,
                                  showCheckmark: false,
                                  selectedColor: blue3,
                                  backgroundColor: Colors.white,
                                  label: Text("Environmental Science"),
                                  onSelected: (bool value) {
                                    setState(() {
                                      filter = "Environmental Science";
                                      idFilter = 120;
                                    });
                                    if (tappedGaruda &&
                                        searchKeywordtemp == searchKeyword) {
                                      garudaBloc.add(
                                          GarudaSearchingBySubjectEvent(
                                              id: idFilter.toString(),
                                              keyword: searchKeyword));
                                    }
                                    print("id $idFilter");
                                  }),
                              FilterChip(
                                  side: BorderSide(color: abu6),
                                  labelStyle: TextStyle(
                                      color: abu6,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12.sp),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  selected: (filter ==
                                          "Industrial & Manufacturing Engineering")
                                      ? true
                                      : false,
                                  showCheckmark: false,
                                  selectedColor: blue3,
                                  backgroundColor: Colors.white,
                                  label: Text(
                                      "Industrial & Manufacturing Engineering"),
                                  onSelected: (bool value) {
                                    setState(() {
                                      filter =
                                          "Industrial & Manufacturing Engineering";
                                      idFilter = 132;
                                    });
                                    if (tappedGaruda &&
                                        searchKeywordtemp == searchKeyword) {
                                      garudaBloc.add(
                                          GarudaSearchingBySubjectEvent(
                                              id: idFilter.toString(),
                                              keyword: searchKeyword));
                                    }
                                    print("id $idFilter");
                                  }),
                              FilterChip(
                                  side: BorderSide(color: abu6),
                                  labelStyle: TextStyle(
                                      color: abu6,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12.sp),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  selected: (filter ==
                                          "Materials Science & Nanotechnology")
                                      ? true
                                      : false,
                                  showCheckmark: false,
                                  selectedColor: blue3,
                                  backgroundColor: Colors.white,
                                  label: Text(
                                      "Materials Science & Nanotechnology"),
                                  onSelected: (bool value) {
                                    setState(() {
                                      filter =
                                          "Materials Science & Nanotechnology";
                                      idFilter = 140;
                                    });
                                    if (tappedGaruda &&
                                        searchKeywordtemp == searchKeyword) {
                                      garudaBloc.add(
                                          GarudaSearchingBySubjectEvent(
                                              id: idFilter.toString(),
                                              keyword: searchKeyword));
                                    }
                                    print("id $idFilter");
                                  }),
                              FilterChip(
                                  side: BorderSide(color: abu6),
                                  labelStyle: TextStyle(
                                      color: abu6,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12.sp),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  selected:
                                      (filter == "Mathematics") ? true : false,
                                  showCheckmark: false,
                                  selectedColor: blue3,
                                  backgroundColor: Colors.white,
                                  label: Text("Mathematics"),
                                  onSelected: (bool value) {
                                    setState(() {
                                      filter = "Mathematics";
                                      idFilter = 150;
                                    });
                                    if (tappedGaruda &&
                                        searchKeywordtemp == searchKeyword) {
                                      garudaBloc.add(
                                          GarudaSearchingBySubjectEvent(
                                              id: idFilter.toString(),
                                              keyword: searchKeyword));
                                    }
                                    print("id $idFilter");
                                  }),
                              FilterChip(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  side: BorderSide(color: abu6),
                                  labelStyle: TextStyle(
                                      color: abu6,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12.sp),
                                  selected: (filter == "Mechanical Engineering")
                                      ? true
                                      : false,
                                  showCheckmark: false,
                                  selectedColor: blue3,
                                  backgroundColor: Colors.white,
                                  label: Text("Mechanical Engineering"),
                                  onSelected: (bool value) {
                                    setState(() {
                                      filter = "Mechanical Engineering";
                                      idFilter = 160;
                                    });
                                    if (tappedGaruda &&
                                        searchKeywordtemp == searchKeyword) {
                                      garudaBloc.add(
                                          GarudaSearchingBySubjectEvent(
                                              id: idFilter.toString(),
                                              keyword: searchKeyword));
                                    }
                                    print("id $idFilter");
                                  }),
                              FilterChip(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  side: BorderSide(color: abu6),
                                  labelStyle: TextStyle(
                                      color: abu6,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12.sp),
                                  selected:
                                      (filter == "Medicine & Pharmacology")
                                          ? true
                                          : false,
                                  showCheckmark: false,
                                  selectedColor: blue3,
                                  backgroundColor: Colors.white,
                                  label: Text("Medicine & Pharmacology"),
                                  onSelected: (bool value) {
                                    setState(() {
                                      filter = "Medicine & Pharmacology";
                                      idFilter = 170;
                                    });
                                    if (tappedGaruda &&
                                        searchKeywordtemp == searchKeyword) {
                                      garudaBloc.add(
                                          GarudaSearchingBySubjectEvent(
                                              id: idFilter.toString(),
                                              keyword: searchKeyword));
                                    }
                                    print("id $idFilter");
                                  }),
                              FilterChip(
                                  side: BorderSide(color: abu6),
                                  labelStyle: TextStyle(
                                      color: abu6,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12.sp),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  selected:
                                      (filter == "Physics") ? true : false,
                                  showCheckmark: false,
                                  selectedColor: blue3,
                                  backgroundColor: Colors.white,
                                  label: Text("Physics"),
                                  onSelected: (bool value) {
                                    setState(() {
                                      filter = "Physics";
                                      idFilter = 180;
                                    });
                                    if (tappedGaruda &&
                                        searchKeywordtemp == searchKeyword) {
                                      garudaBloc.add(
                                          GarudaSearchingBySubjectEvent(
                                              id: idFilter.toString(),
                                              keyword: searchKeyword));
                                    }
                                    print("id $idFilter");
                                  }),
                              FilterChip(
                                  side: BorderSide(color: abu6),
                                  labelStyle: TextStyle(
                                      color: abu6,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12.sp),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  selected: (filter == "Social Sciences")
                                      ? true
                                      : false,
                                  showCheckmark: false,
                                  selectedColor: blue3,
                                  backgroundColor: Colors.white,
                                  label: Text("Social Sciences"),
                                  onSelected: (bool value) {
                                    setState(() {
                                      filter = "Social Sciences";
                                      idFilter = 190;
                                    });
                                    if (tappedGaruda &&
                                        searchKeywordtemp == searchKeyword) {
                                      garudaBloc.add(
                                          GarudaSearchingBySubjectEvent(
                                              id: idFilter.toString(),
                                              keyword: searchKeyword));
                                    }
                                    print("id $idFilter");
                                  }),
                              FilterChip(
                                  side: BorderSide(color: abu6),
                                  labelStyle: TextStyle(
                                      color: abu6,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12.sp),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  selected: (filter == "Transportation")
                                      ? true
                                      : false,
                                  showCheckmark: false,
                                  selectedColor: blue3,
                                  backgroundColor: Colors.white,
                                  label: Text("Transportation"),
                                  onSelected: (bool value) {
                                    setState(() {
                                      filter = "Transportation";
                                      idFilter = 200;
                                    });
                                    if (tappedGaruda &&
                                        searchKeywordtemp == searchKeyword) {
                                      garudaBloc.add(
                                          GarudaSearchingBySubjectEvent(
                                              id: idFilter.toString(),
                                              keyword: searchKeyword));
                                    }
                                    print("id $idFilter");
                                  }),
                              //ini baris 3
                              FilterChip(
                                  side: BorderSide(color: abu6),
                                  labelStyle: TextStyle(
                                      color: abu6,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12.sp),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  selected: (filter == "Other") ? true : false,
                                  showCheckmark: false,
                                  selectedColor: blue3,
                                  backgroundColor: Colors.white,
                                  label: Text("Other"),
                                  onSelected: (bool value) {
                                    setState(() {
                                      filter = "Other";
                                      idFilter = 500;
                                    });
                                    if (tappedGaruda &&
                                        searchKeywordtemp == searchKeyword) {
                                      garudaBloc.add(
                                          GarudaSearchingBySubjectEvent(
                                              id: idFilter.toString(),
                                              keyword: searchKeyword));
                                    }
                                    print("id $idFilter");
                                  }),
                              FilterChip(
                                  side: BorderSide(color: abu6),
                                  labelStyle: TextStyle(
                                      color: abu6,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12.sp),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  selected: (filter == "Arts") ? true : false,
                                  showCheckmark: false,
                                  selectedColor: blue3,
                                  backgroundColor: Colors.white,
                                  label: Text("Arts"),
                                  onSelected: (bool value) {
                                    setState(() {
                                      filter = "Arts";
                                      idFilter = 23;
                                    });
                                    if (tappedGaruda &&
                                        searchKeywordtemp == searchKeyword) {
                                      garudaBloc.add(
                                          GarudaSearchingBySubjectEvent(
                                              id: idFilter.toString(),
                                              keyword: searchKeyword));
                                    }
                                    print("id $idFilter");
                                  }),
                              FilterChip(
                                  side: BorderSide(color: abu6),
                                  labelStyle: TextStyle(
                                      color: abu6,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12.sp),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  selected:
                                      (filter == "Astronomy") ? true : false,
                                  showCheckmark: false,
                                  selectedColor: blue3,
                                  backgroundColor: Colors.white,
                                  label: Text("Astronomy"),
                                  onSelected: (bool value) {
                                    setState(() {
                                      filter = "Astronomy";
                                      idFilter = 26;
                                    });
                                    if (tappedGaruda &&
                                        searchKeywordtemp == searchKeyword) {
                                      garudaBloc.add(
                                          GarudaSearchingBySubjectEvent(
                                              id: idFilter.toString(),
                                              keyword: searchKeyword));
                                    }
                                    print("id $idFilter");
                                  }),
                              FilterChip(
                                  side: BorderSide(color: abu6),
                                  labelStyle: TextStyle(
                                      color: abu6,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12.sp),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  selected: (filter ==
                                          "Biochemistry, Genetics & Molecular Biology")
                                      ? true
                                      : false,
                                  showCheckmark: false,
                                  selectedColor: blue3,
                                  backgroundColor: Colors.white,
                                  label: Text(
                                      "Biochemistry, Genetics & Molecular Biology"),
                                  onSelected: (bool value) {
                                    setState(() {
                                      filter =
                                          "Biochemistry, Genetics & Molecular Biology";
                                      idFilter = 35;
                                    });
                                    if (tappedGaruda &&
                                        searchKeywordtemp == searchKeyword) {
                                      garudaBloc.add(
                                          GarudaSearchingBySubjectEvent(
                                              id: idFilter.toString(),
                                              keyword: searchKeyword));
                                    }
                                    print("id $idFilter");
                                  }),
                              FilterChip(
                                  side: BorderSide(color: abu6),
                                  labelStyle: TextStyle(
                                      color: abu6,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12.sp),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  selected:
                                      (filter == "Chemistry") ? true : false,
                                  showCheckmark: false,
                                  selectedColor: blue3,
                                  backgroundColor: Colors.white,
                                  label: Text("Chemistry"),
                                  onSelected: (bool value) {
                                    setState(() {
                                      filter = "Chemistry";
                                      idFilter = 45;
                                    });
                                    if (tappedGaruda &&
                                        searchKeywordtemp == searchKeyword) {
                                      garudaBloc.add(
                                          GarudaSearchingBySubjectEvent(
                                              id: idFilter.toString(),
                                              keyword: searchKeyword));
                                    }
                                    print("id $idFilter");
                                  }),
                              FilterChip(
                                  side: BorderSide(color: abu6),
                                  labelStyle: TextStyle(
                                      color: abu6,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12.sp),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  selected:
                                      (filter == "Dentistry") ? true : false,
                                  showCheckmark: false,
                                  selectedColor: blue3,
                                  backgroundColor: Colors.white,
                                  label: Text("Dentistry"),
                                  onSelected: (bool value) {
                                    setState(() {
                                      filter = "Dentistry";
                                      idFilter = 85;
                                    });
                                    if (tappedGaruda &&
                                        searchKeywordtemp == searchKeyword) {
                                      garudaBloc.add(
                                          GarudaSearchingBySubjectEvent(
                                              id: idFilter.toString(),
                                              keyword: searchKeyword));
                                    }
                                    print("id $idFilter");
                                  }),
                              FilterChip(
                                  side: BorderSide(color: abu6),
                                  labelStyle: TextStyle(
                                      color: abu6,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12.sp),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  selected: (filter ==
                                          "Economics, Econometrics & Finance")
                                      ? true
                                      : false,
                                  showCheckmark: false,
                                  selectedColor: blue3,
                                  backgroundColor: Colors.white,
                                  label:
                                      Text("Economics, Econometrics & Finance"),
                                  onSelected: (bool value) {
                                    setState(() {
                                      filter =
                                          "Economics, Econometrics & Finance";
                                      idFilter = 95;
                                    });
                                    if (tappedGaruda &&
                                        searchKeywordtemp == searchKeyword) {
                                      garudaBloc.add(
                                          GarudaSearchingBySubjectEvent(
                                              id: idFilter.toString(),
                                              keyword: searchKeyword));
                                    }
                                    print("id $idFilter");
                                  }),
                              FilterChip(
                                  side: BorderSide(color: abu6),
                                  labelStyle: TextStyle(
                                      color: abu6,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12.sp),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  selected:
                                      (filter == "Education") ? true : false,
                                  showCheckmark: false,
                                  selectedColor: blue3,
                                  backgroundColor: Colors.white,
                                  label: Text("Education"),
                                  onSelected: (bool value) {
                                    setState(() {
                                      filter = "Education";
                                      idFilter = 97;
                                    });
                                    if (tappedGaruda &&
                                        searchKeywordtemp == searchKeyword) {
                                      garudaBloc.add(
                                          GarudaSearchingBySubjectEvent(
                                              id: idFilter.toString(),
                                              keyword: searchKeyword));
                                    }
                                    print("id $idFilter");
                                  }),
                              FilterChip(
                                  side: BorderSide(color: abu6),
                                  labelStyle: TextStyle(
                                      color: abu6,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12.sp),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  selected:
                                      (filter == "Engineering") ? true : false,
                                  showCheckmark: false,
                                  selectedColor: blue3,
                                  backgroundColor: Colors.white,
                                  label: Text("Engineering"),
                                  onSelected: (bool value) {
                                    setState(() {
                                      filter = "Engineering";
                                      idFilter = 115;
                                    });
                                    if (tappedGaruda &&
                                        searchKeywordtemp == searchKeyword) {
                                      garudaBloc.add(
                                          GarudaSearchingBySubjectEvent(
                                              id: idFilter.toString(),
                                              keyword: searchKeyword));
                                    }
                                    print("id $idFilter");
                                  }),
                              FilterChip(
                                  side: BorderSide(color: abu6),
                                  labelStyle: TextStyle(
                                      color: abu6,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12.sp),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  selected: (filter == "Health Professions")
                                      ? true
                                      : false,
                                  showCheckmark: false,
                                  selectedColor: blue3,
                                  backgroundColor: Colors.white,
                                  label: Text("Health Professions"),
                                  onSelected: (bool value) {
                                    setState(() {
                                      filter = "Health Professions";
                                      idFilter = 125;
                                    });
                                    if (tappedGaruda &&
                                        searchKeywordtemp == searchKeyword) {
                                      garudaBloc.add(
                                          GarudaSearchingBySubjectEvent(
                                              id: idFilter.toString(),
                                              keyword: searchKeyword));
                                    }
                                    print("id $idFilter");
                                  }),
                              //ini baris 4
                              FilterChip(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  side: BorderSide(color: abu6),
                                  labelStyle: TextStyle(
                                      color: abu6,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12.sp),
                                  selected:
                                      (filter == "Immunology & microbiology")
                                          ? true
                                          : false,
                                  showCheckmark: false,
                                  selectedColor: blue3,
                                  backgroundColor: Colors.white,
                                  label: Text("Immunology & microbiology"),
                                  onSelected: (bool value) {
                                    setState(() {
                                      filter = "Immunology & microbiology";
                                      idFilter = 130;
                                    });
                                    if (tappedGaruda &&
                                        searchKeywordtemp == searchKeyword) {
                                      garudaBloc.add(
                                          GarudaSearchingBySubjectEvent(
                                              id: idFilter.toString(),
                                              keyword: searchKeyword));
                                    }
                                    print("id $idFilter");
                                  }),
                              FilterChip(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  side: BorderSide(color: abu6),
                                  labelStyle: TextStyle(
                                      color: abu6,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12.sp),
                                  selected: (filter ==
                                          "Languange, Linguistic, Communication & Media")
                                      ? true
                                      : false,
                                  showCheckmark: false,
                                  selectedColor: blue3,
                                  backgroundColor: Colors.white,
                                  label: Text(
                                      "Languange, Linguistic, Communication & Media"),
                                  onSelected: (bool value) {
                                    setState(() {
                                      filter =
                                          "Languange, Linguistic, Communication & Media";
                                      idFilter = 135;
                                    });
                                    if (tappedGaruda &&
                                        searchKeywordtemp == searchKeyword) {
                                      garudaBloc.add(
                                          GarudaSearchingBySubjectEvent(
                                              id: idFilter.toString(),
                                              keyword: searchKeyword));
                                    }
                                    print("id $idFilter");
                                  }),
                              FilterChip(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  side: BorderSide(color: abu6),
                                  labelStyle: TextStyle(
                                      color: abu6,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12.sp),
                                  selected: (filter ==
                                          "Law, Crime, Criminology & Criminal Justice")
                                      ? true
                                      : false,
                                  showCheckmark: false,
                                  selectedColor: blue3,
                                  backgroundColor: Colors.white,
                                  label: Text(
                                      "Law, Crime, Criminology & Criminal Justice"),
                                  onSelected: (bool value) {
                                    setState(() {
                                      filter =
                                          "Law, Crime, Criminology & Criminal Justice";
                                      idFilter = 137;
                                    });
                                    if (tappedGaruda &&
                                        searchKeywordtemp == searchKeyword) {
                                      garudaBloc.add(
                                          GarudaSearchingBySubjectEvent(
                                              id: idFilter.toString(),
                                              keyword: searchKeyword));
                                    }
                                    print("id $idFilter");
                                  }),
                              FilterChip(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  side: BorderSide(color: abu6),
                                  labelStyle: TextStyle(
                                      color: abu6,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12.sp),
                                  selected: (filter ==
                                          "Library & Information Science")
                                      ? true
                                      : false,
                                  showCheckmark: false,
                                  selectedColor: blue3,
                                  backgroundColor: Colors.white,
                                  label: Text("Library & Information Science"),
                                  onSelected: (bool value) {
                                    setState(() {
                                      filter = "Library & Information Science";
                                      idFilter = 138;
                                    });
                                    if (tappedGaruda &&
                                        searchKeywordtemp == searchKeyword) {
                                      garudaBloc.add(
                                          GarudaSearchingBySubjectEvent(
                                              id: idFilter.toString(),
                                              keyword: searchKeyword));
                                    }
                                    print("id $idFilter");
                                  }),
                              FilterChip(
                                  side: BorderSide(color: abu6),
                                  labelStyle: TextStyle(
                                      color: abu6,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12.sp),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  selected:
                                      (filter == "Neuroscience") ? true : false,
                                  showCheckmark: false,
                                  selectedColor: blue3,
                                  backgroundColor: Colors.white,
                                  label: Text("Neuroscience"),
                                  onSelected: (bool value) {
                                    setState(() {
                                      filter = "Neuroscience";
                                      idFilter = 175;
                                    });
                                    if (tappedGaruda &&
                                        searchKeywordtemp == searchKeyword) {
                                      garudaBloc.add(
                                          GarudaSearchingBySubjectEvent(
                                              id: idFilter.toString(),
                                              keyword: searchKeyword));
                                    }
                                    print("id $idFilter");
                                  }),
                              FilterChip(
                                  side: BorderSide(color: abu6),
                                  labelStyle: TextStyle(
                                      color: abu6,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12.sp),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  selected:
                                      (filter == "Nursing") ? true : false,
                                  showCheckmark: false,
                                  selectedColor: blue3,
                                  backgroundColor: Colors.white,
                                  label: Text("Nursing"),
                                  onSelected: (bool value) {
                                    setState(() {
                                      filter = "Nursing";
                                      idFilter = 177;
                                    });
                                    if (tappedGaruda &&
                                        searchKeywordtemp == searchKeyword) {
                                      garudaBloc.add(
                                          GarudaSearchingBySubjectEvent(
                                              id: idFilter.toString(),
                                              keyword: searchKeyword));
                                    }
                                    print("id $idFilter");
                                  }),
                              FilterChip(
                                  side: BorderSide(color: abu6),
                                  labelStyle: TextStyle(
                                      color: abu6,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12.sp),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  selected: (filter == "Public Health")
                                      ? true
                                      : false,
                                  showCheckmark: false,
                                  selectedColor: blue3,
                                  backgroundColor: Colors.white,
                                  label: Text("Public Health"),
                                  onSelected: (bool value) {
                                    setState(() {
                                      filter = "Public Health";
                                      idFilter = 185;
                                    });
                                    if (tappedGaruda &&
                                        searchKeywordtemp == searchKeyword) {
                                      garudaBloc.add(
                                          GarudaSearchingBySubjectEvent(
                                              id: idFilter.toString(),
                                              keyword: searchKeyword));
                                    }
                                    print("id $idFilter");
                                  }),
                              FilterChip(
                                  side: BorderSide(color: abu6),
                                  labelStyle: TextStyle(
                                      color: abu6,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12.sp),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  selected:
                                      (filter == "Veterinary") ? true : false,
                                  showCheckmark: false,
                                  selectedColor: blue3,
                                  backgroundColor: Colors.white,
                                  label: Text("Veterinary"),
                                  onSelected: (bool value) {
                                    setState(() {
                                      filter = "Veterinary";
                                      idFilter = 220;
                                    });
                                    if (tappedGaruda &&
                                        searchKeywordtemp == searchKeyword) {
                                      garudaBloc.add(
                                          GarudaSearchingBySubjectEvent(
                                              id: idFilter.toString(),
                                              keyword: searchKeyword));
                                    }
                                    print("id $idFilter");
                                  }),
                              FilterChip(
                                  side: BorderSide(color: abu6),
                                  labelStyle: TextStyle(
                                      color: abu6,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12.sp),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  selected:
                                      (filter == "Religion") ? true : false,
                                  showCheckmark: false,
                                  selectedColor: blue3,
                                  backgroundColor: Colors.white,
                                  label: Text("Religion"),
                                  onSelected: (bool value) {
                                    setState(() {
                                      filter = "Religion";
                                      idFilter = 1;
                                    });
                                    if (tappedGaruda &&
                                        searchKeywordtemp == searchKeyword) {
                                      garudaBloc.add(
                                          GarudaSearchingBySubjectEvent(
                                              id: idFilter.toString(),
                                              keyword: searchKeyword));
                                    }
                                    print("id $idFilter");
                                  }),
                              FilterChip(
                                  side: BorderSide(color: abu6),
                                  labelStyle: TextStyle(
                                      color: abu6,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12.sp),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  selected:
                                      (filter == "Humanities") ? true : false,
                                  showCheckmark: false,
                                  selectedColor: blue3,
                                  backgroundColor: Colors.white,
                                  label: Text("Humanities"),
                                  onSelected: (bool value) {
                                    setState(() {
                                      filter = "Humanities";
                                      idFilter = 24;
                                    });
                                    if (tappedGaruda &&
                                        searchKeywordtemp == searchKeyword) {
                                      garudaBloc.add(
                                          GarudaSearchingBySubjectEvent(
                                              id: idFilter.toString(),
                                              keyword: searchKeyword));
                                    }
                                    print("id $idFilter");
                                  }),
                            ],
                          )
                        ],
                      );
                    }));
          });
        }).then((value) {
      setState(() {
        value = idFilter;
      });
    });
  }
}
