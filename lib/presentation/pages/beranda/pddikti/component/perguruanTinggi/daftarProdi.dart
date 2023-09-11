import 'dart:convert';

import 'package:app/common/baseUrl.dart';
import 'package:app/common/internetCheck.dart';
import 'package:app/data/source/remote/model/pddikti/perguruanTinggi/getDetailPT.dart';
import 'package:app/data/source/remote/model/pddikti/perguruanTinggi/getListProdi.dart';
import 'package:app/injection.dart' as di;
import 'package:app/presentation/component/constant.dart';
import 'package:app/presentation/pages/beranda/pddikti/bloc/detail_pencarian/prodi/detail_pencarian_prodi_bloc.dart';
import 'package:app/presentation/pages/beranda/pddikti/component/card/cardDaftarProdi.dart';
import 'package:app/presentation/pages/beranda/pddikti/component/loadingPddikti/loading_detail_perguruan_tinggi_pddikti.dart';
import 'package:app/presentation/pages/beranda/pddikti/detailProdiPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;

class TabDaftarProdi extends StatefulWidget {
  final GetDetailPT getDetailPT;
  const TabDaftarProdi({Key? key, required this.getDetailPT}) : super(key: key);

  @override
  _TabDaftarProdiState createState() => _TabDaftarProdiState();
}

class _TabDaftarProdiState extends State<TabDaftarProdi> {
  bool isLoading = true;
  bool isConnected = false;

  var prodiPT;

  bool scrollLoading = false;
  int page = 1;
  ScrollController _scrollController = new ScrollController();

  List<String> jenjangList = [];
  List<String> lembagaList = [];
  List<String> namaList = [];
  List<String> kodePT = [];
  List<String> kodePD = [];

  @override
  void initState() {
    internetCheck();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        page += 1;
        setState(() {
          scrollLoading = true;
        });
        print('after scroll $scrollLoading');

        internetCheck();
      }
    });
    super.initState();
  }

  dynamic internetCheck() async {
    bool result = await InternetCheck().hasConnection();
    if (result) {
      getProdiAPI(portDev, page.toString());
    } else {
      setState(() {
        isLoading = false;
        isConnected = false;
      });
    }
  }

  Future getProdiAPI(String port, String page) async {
    var uri = Uri.parse(
        '$urlStagging/pddikti/perguruan_tinggi/${widget.getDetailPT.data.perguruanTinggi.kode}/prodi?page=$page');
    print(uri);
    var response = await http.get(uri, headers: appHeaders);
    if (response.statusCode == 200 && mounted) {
      String jsonDataString = response.body.toString();
      var jsonData = jsonDecode(jsonDataString);
      prodiPT = GetListProdi.fromJson(jsonData);
      if (mounted) {
        setState(() {
          for (int i = 0; i < prodiPT.data.prodi.length; i++) {
            jenjangList.add(prodiPT.data.prodi[i].jenjangDidik.nama);
            lembagaList.add(prodiPT.data.prodi[i].pt.nama);
            namaList.add(prodiPT.data.prodi[i].nama);
            kodePT.add(prodiPT.data.prodi[i].pt.kode);
            kodePD.add(prodiPT.data.prodi[i].kode);
          }
          isLoading = false;
          Future.delayed(Duration(milliseconds: 700), () {
            setState(() {
              scrollLoading = false;
            });
          });
          isConnected = true;
        });
      }
      print(jenjangList);
      print(jenjangList.length);
    } else {
      print('END');
      isLoading = false;
      Future.delayed(Duration(milliseconds: 700), () {
        setState(() {
          scrollLoading = false;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Container(
            color: white,
            width: double.infinity,
            height: screenHeight(context) * (1 / 2.15),
            child: LoadingDetailPerguruanTinggiCardProdiPDDikti())
        : !isConnected
            ? Center(
                child: Column(
                  children: [
                    SizedBox(
                      height: 24.h,
                    ),
                    Image.asset(
                      'assets/ilus_connectionLost.png',
                      width: 150.w,
                    ),
                    SizedBox(
                      height: 24.h,
                    ),
                    Text(
                      'Koneksi Internet Bermasalah',
                      style: TextStyle(
                          fontWeight: FontWeight.w700, fontSize: 16.sp),
                    ),
                    Text(
                      'Silahkan periksa koneksi anda',
                      style: TextStyle(
                          fontSize: 16.sp, fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              )
            : Stack(
                children: [
                  RawScrollbar(
                    controller: _scrollController,
                    thickness: 0,
                    child: Container(
                      width: double.infinity,
                      color: whiteBgPage,
                      padding: EdgeInsets.only(
                          left: screenWidth(context) * (1 / 30),
                          right: screenWidth(context) * (1 / 30),
                          top: screenHeight(context) * (1 / 50)),
                      child: ListView.separated(
                        physics: BouncingScrollPhysics(),
                        controller: _scrollController,
                        shrinkWrap: true,
                        itemCount: jenjangList.length,
                        separatorBuilder: (context, index) {
                          return SizedBox(
                            height: 20.h,
                          );
                        },
                        itemBuilder: (context, index) {
                          return CardDaftarProdi(
                            akreditas: '',
                            jenjang: jenjangList[index],
                            lembaga: lembagaList[index],
                            namaProdi: namaList[index],
                            status: '',
                            kodePD: kodePD[index],
                            isDetail: false,
                            warnaKodePD: neutralCaption,
                            function: () {
                              Navigator.push(context, MaterialPageRoute(
                                builder: (context) {
                                  return BlocProvider(
                                    create: (context) =>
                                        di.locator<DetailPencarianProdiBloc>()
                                          ..add(LoadPencarianProdiEvent(
                                            kodePT: kodePT[index],
                                            kodeProdi: kodePD[index],
                                            fromPT: true,
                                          )),
                                    child: DetailProdiPage(
                                      kodePT: kodePT[index],
                                      kodeProdi: kodePD[index],
                                      fromPT: true,
                                    ),
                                  );
                                },
                              ));
                            },
                          );
                        },
                      ),
                    ),
                  ),
                  scrollLoading
                      ? Padding(
                          padding: EdgeInsets.all(screenHeight(context) * 0.03),
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white60,
                                  boxShadow: [BoxShadow(blurRadius: 15)]),
                              child: CircularProgressIndicator(
                                backgroundColor: blueLinear1,
                              ),
                            ),
                          ),
                        )
                      : Container()
                ],
              );
  }
}
