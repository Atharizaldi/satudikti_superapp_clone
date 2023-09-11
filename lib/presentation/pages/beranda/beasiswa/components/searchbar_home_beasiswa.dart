import 'package:app/presentation/component/search/searchBar.dart';
import 'package:app/presentation/pages/beranda/beasiswa/beasiswaSearchPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

GestureDetector searchBarHomeBeasiswa(BuildContext context) {
  return GestureDetector(
    onTap: () async {
      Navigator.push(context,
          MaterialPageRoute(builder: (builder) => BeasiswaSearchPage()));
    },
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      color: Colors.transparent,
      child: IgnorePointer(
        child: SearchBar(
          openKeyboard: false,
          hintText: 'Pencarian Beasiswa',
          searchType: TypeSearchBar.regular,
        ),
      ),
    ),
  );
}
