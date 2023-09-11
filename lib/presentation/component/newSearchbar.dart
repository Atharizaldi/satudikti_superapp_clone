import 'package:app/presentation/component/constant.dart';
import 'package:flutter/material.dart';

import 'sub_title_with_arrow_lainnya.dart';

class DataSearch extends SearchDelegate<String> {
  final isinya = [
    'Kampus Merdeka',
    'PDDikti',
    'Kedaireka',
    'Penyetaraan Ijazah LN',
    'SIVIL',
    'Selancar PAK',
    'Silemkerma',
    'SISTER'
        'G-Magz'
  ];
  final kosong = [''];

  @override
  ThemeData appBarTheme(BuildContext context) {
    return Theme.of(context).copyWith(
        primaryColor: blueLinear1,
        inputDecorationTheme: InputDecorationTheme(
          hintStyle: TextStyle(color: teksAbu),
          fillColor: white,
          filled: true,
          labelStyle: TextStyle(),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 0.0, horizontal: 20.0),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(40),
              ),
              borderSide: BorderSide(color: white)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(40),
              ),
              borderSide: BorderSide(color: white)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(40),
              ),
              borderSide: BorderSide(color: white)),
        ));
  }

  // InputDecorationTheme()

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: Icon(Icons.clear))
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, '');
        },
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          progress: transitionAnimation,
        ));
  }

  @override
  Widget buildResults(BuildContext context) {
    final suggestionlist = query.isEmpty
        ? kosong
        : isinya
            .where((e) => e.toLowerCase().startsWith(query.toLowerCase()))
            .toList();

    return suggestionlist.isEmpty
        ? Container(
            width: double.infinity,
            height: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.asset('assets/search/search_not_found.png'),
                Center(
                  child: Text(
                    'Hasil Pencarian Tidak ditemukan\nSilakan coba cari kata kunci lainnya',
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          )
        : Container(
            width: double.infinity,
            height: double.infinity,
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  height: screenHeight(context) * (1 / 4.5),
                  child: Column(
                    children: [
                      SubTitleWithArrowLainnya(
                        subJudul: 'Pengumuman',
                        function: () {},
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) => ListTile(
                            onTap: () {}, title: Text(suggestionlist[index])),
                        itemCount: suggestionlist.length,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionlist = query.isEmpty
        ? kosong
        : isinya
            .where((e) => e.toLowerCase().startsWith(query.toLowerCase()))
            .toList();

    return ListView.builder(
      itemBuilder: (context, index) => ListTile(
        onTap: () {},
        title: RichText(
            text: TextSpan(
                text: suggestionlist[index].substring(0, query.length),
                style:
                    TextStyle(color: neutral100, fontWeight: FontWeight.w600),
                children: [
              TextSpan(
                  text: suggestionlist[index].substring(query.length),
                  style: TextStyle(
                      color: Colors.grey, fontWeight: FontWeight.w600))
            ])),
      ),
      itemCount: suggestionlist.length,
    );
  }
}
