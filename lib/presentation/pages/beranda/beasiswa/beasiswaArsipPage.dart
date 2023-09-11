import 'package:app/data/source/remote/model/beasiswa/beasiswa.dart';
import 'package:app/injection.dart' as di;
import 'package:app/presentation/component/constant.dart';
import 'package:app/presentation/component/customAppBar.dart';
import 'package:app/presentation/component/noInternet.dart';
import 'package:app/presentation/pages/beranda/beasiswa/components/beasiswa_loading.dart';
import 'package:app/presentation/pages/beranda/beasiswa/components/cardBeasiswa.dart';
import 'package:app/presentation/pages/beranda/beasiswa/components/newSearchBarBeasiswa.dart';
import 'package:app/presentation/pages/beranda/beasiswa/search_beasiswa_bloc/search_beasiswa_bloc.dart';
import 'package:app/presentation/pages/beranda/searchPage/component/searchNotFound.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BeasiswaArsipPage extends StatefulWidget {
  const BeasiswaArsipPage({Key? key}) : super(key: key);

  @override
  State<BeasiswaArsipPage> createState() => _BeasiswaArsipPageState();
}

class _BeasiswaArsipPageState extends State<BeasiswaArsipPage> {
  TextEditingController textEditingController = TextEditingController();

  ScrollController scrollController = ScrollController();
  bool tappedBeasiswa = false;
  String? searchKeywordBeasiswa = "";
  String? temp = "";

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var textStyle = TextStyle(fontSize: 14.sp, color: neutral50);
    return BlocProvider(
      create: (context) => di.locator<SearchBeasiswaBloc>()
        ..add(InitFetchSearchBeasiswaEvent(closedFilter: true, keyword: "")),
      child: Builder(builder: (context) {
        scrollController.addListener(() {
          onScroll(context, searchKeywordBeasiswa.toString());
        });
        return Scaffold(
          backgroundColor: whiteBgPage,
          resizeToAvoidBottomInset: false,
          appBar: CustomAppBar(
            title: "Arsip Beasiswa",
          ),
          body: BlocBuilder<SearchBeasiswaBloc, SearchBeasiswaState>(
            builder: (context, state) {
              if (state is SearchBeasiswaLoadingState) {
                return programBeasiswaLoading();
              } else if (state is InitSearchBeasiswaLoadedState) {
                return SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: 28.h,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: NewSearchBarBeasiswa(
                          onChanged: (String keyword) {
                            setState(() {
                              searchKeywordBeasiswa = keyword;
                            });
                            print(
                                'searchKeywordBeasiswa $searchKeywordBeasiswa');
                          },
                          searchKeywordBeasiswa:
                              searchKeywordBeasiswa.toString(),
                          tappedBeasiswa: tappedBeasiswa,
                          controller: textEditingController,
                          openKeyboard: false,
                          hintText: 'Pencarian Beasiswa',
                          searchType: TypeSearchBarBeasiswa.regular,
                          isSubmitted: (String keyword) {
                            // setState(() {
                            //   tappedBeasiswa = true;
                            // });
                            searchKeywordBeasiswa = keyword;
                            _search(context, keyword);
                            // if (keyword.isNotEmpty) {

                            // }
                          },
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      _jumlahAwalPencarian(
                          textStyle, state.beasiswa.data!.rowCount),
                      SizedBox(
                        height: 28.w,
                      ),
                      cardLoadedInitial(state),
                      SizedBox(
                        height: 50.h,
                      )
                    ],
                  ),
                );
              } else if (state is SearchBeasiswaServerErrorState) {
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 28, bottom: 20, left: 16, right: 16),
                      child: NewSearchBarBeasiswa(
                        onChanged: (String keyword) {
                          setState(() {
                            searchKeywordBeasiswa = keyword;
                          });
                          print('searchKeywordBeasiswa $searchKeywordBeasiswa');
                        },
                        searchKeywordBeasiswa: searchKeywordBeasiswa.toString(),
                        tappedBeasiswa: tappedBeasiswa,
                        controller: textEditingController,
                        openKeyboard: false,
                        hintText: 'Pencarian Beasiswa',
                        searchType: TypeSearchBarBeasiswa.regular,
                        isSubmitted: (String keyword) {
                          // setState(() {
                          //   tappedBeasiswa = true;
                          // });
                          searchKeywordBeasiswa = keyword;
                          _search(context, keyword);
                          // if (keyword.isNotEmpty) {

                          // }
                        },
                      ),
                    ),
                    SizedBox(
                      height: 20.sp,
                    ),
                    _jumlahPencarian(textStyle, 0, "Error"),
                    SizedBox(
                      height: 28.w,
                    ),
                    Flexible(child: searchNotFound(""))
                  ],
                );
              } else if (state is SearchBeasiswaLoadedState) {
                final listBeasiswa = state.listBeasiswa
                    .where((element) =>
                        element.tanggalDitutup.isBefore(DateTime.now()))
                    .toList();
                final res = state.beasiswa.data!.rowCount;
                final searchKey = state.searchKeyword.toString();

                return SingleChildScrollView(
                  controller: scrollController,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 28, bottom: 20, left: 16, right: 16),
                        child: NewSearchBarBeasiswa(
                          onChanged: (String keyword) {
                            setState(() {
                              searchKeywordBeasiswa = keyword;
                            });
                            print(
                                'searchKeywordBeasiswa $searchKeywordBeasiswa');
                          },
                          searchKeywordBeasiswa:
                              searchKeywordBeasiswa.toString(),
                          tappedBeasiswa: tappedBeasiswa,
                          controller: textEditingController,
                          openKeyboard: false,
                          hintText: 'Pencarian Beasiswa',
                          searchType: TypeSearchBarBeasiswa.regular,
                          isSubmitted: (String keyword) {
                            // setState(() {
                            //   tappedBeasiswa = true;
                            // });
                            searchKeywordBeasiswa = keyword;
                            _search(context, keyword);
                            // if (keyword.isNotEmpty) {

                            // }
                          },
                        ),
                      ),
                      _jumlahPencarian(
                          textStyle, listBeasiswa.length, searchKey),
                      SizedBox(
                        height: 28.w,
                      ),
                      cardResult(state, listBeasiswa),
                      SizedBox(
                        height: 30.w,
                      ),
                    ],
                  ),
                );
              } else if (state is SearchBeasiswaLoadingState) {
                return programBeasiswaLoading();
              } else if (state is SearchBeasiswaNoInternetState) {
                return NoInternet(
                    onPressed: () {
                      _search(context, searchKeywordBeasiswa.toString());
                    },
                    buttonHide: true);
              }

              return SizedBox();
            },
          ),
        );
      }),
    );
  }

  Flexible cardLoadedInitial(InitSearchBeasiswaLoadedState state) {
    return Flexible(
      child: ListView.separated(
          separatorBuilder: (context, index) {
            return SizedBox(
              height: 20.w,
            );
          },
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: state.listBeasiswa.length,
          itemBuilder: (BuildContext context, index) {
            return CardBeasiswa(
              namaBeasiswa: state.listBeasiswa[index].nama,
              namaInstansi: state.listBeasiswa[index].penyelenggara,
              startDate: state.listBeasiswa[index].tanggalDibuka.toString(),
              endDate: state.listBeasiswa[index].tanggalDitutup.toString(),
              listTagName: state.listBeasiswa[index].penerima
                  .map((e) => e.nama)
                  .toList(),
              deskripsi: state.listBeasiswa[index].deskripsi,
              persyaratan: state.listBeasiswa[index].persyaratan,
              url: state.listBeasiswa[index].linkPendaftaran,
              isOpen: state.listBeasiswa[index].isOpen,
              urlLampiran: state.listBeasiswa[index].lampiran!.pathFile,
              daftar: false,
              closed: true,
            );
          }),
    );
  }

  Flexible cardResult(
      SearchBeasiswaLoadedState state, List<ListBeasiswa> listBeasiswa) {
    return Flexible(
      child: ListView.separated(
          separatorBuilder: (context, index) {
            return SizedBox(
              height: 20.w,
            );
          },
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: (state.hasReached)
              ? listBeasiswa.length
              : listBeasiswa.length + 1,
          itemBuilder: (BuildContext context, index) {
            if (index < listBeasiswa.length) {
              return CardBeasiswa(
                namaBeasiswa: listBeasiswa[index].nama,
                namaInstansi: listBeasiswa[index].penyelenggara,
                startDate: listBeasiswa[index].tanggalDibuka.toString(),
                endDate: listBeasiswa[index].tanggalDitutup.toString(),
                listTagName:
                    listBeasiswa[index].penerima.map((e) => e.nama).toList(),
                deskripsi: listBeasiswa[index].deskripsi,
                persyaratan: listBeasiswa[index].persyaratan,
                url: listBeasiswa[index].linkPendaftaran,
                isOpen: listBeasiswa[index].isOpen,
                urlLampiran: state.listBeasiswa[index].lampiran!.pathFile,
                daftar: false,
                closed: true,
              );
            } else {
              return Center(
                child: SizedBox(
                  width: 30,
                  height: 30,
                  child: CircularProgressIndicator(color: blueLinear1),
                ),
              );
            }
          }),
    );
  }

  Widget _jumlahPencarian(TextStyle textStyle, int jumlahPencarian, searchKey) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        children: [
          SizedBox(
            width: 2.w,
          ),
          Image.asset(
            'assets/icons/search_active.png',
            width: 18.67.sp,
            height: 17.88.sp,
            color: neutral10,
          ),
          SizedBox(
            width: 16.33.sp,
          ),
          Flexible(
            child: RichText(
                text: TextSpan(children: [
              TextSpan(text: "Menemukan ", style: textStyle),
              TextSpan(
                  text: "$jumlahPencarian ",
                  style: textStyle.copyWith(fontWeight: FontWeight.bold)),
              TextSpan(text: "Beasiswa ", style: textStyle),
              TextSpan(text: "Search ", style: textStyle),
              TextSpan(
                  text: "$searchKey ",
                  style: textStyle.copyWith(fontWeight: FontWeight.bold))
            ])),
          )
        ],
      ),
    );
  }

  Widget _jumlahAwalPencarian(TextStyle textStyle, int jumlahPencarian) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        children: [
          SizedBox(
            width: 4.w,
          ),
          Flexible(
            child: RichText(
                text: TextSpan(children: [
              TextSpan(text: "Ada ", style: textStyle),
              TextSpan(
                  text: "$jumlahPencarian ",
                  style: textStyle.copyWith(fontWeight: FontWeight.bold)),
              TextSpan(text: "Program yang sudah ditutup", style: textStyle),
            ])),
          )
        ],
      ),
    );
  }

  void _search(BuildContext context, String keyword) {
    if (idFilterBeasiswa == 0) {
      context
          .read<SearchBeasiswaBloc>()
          .add(FetchSearchBeasiswaEvent(keyword: keyword));
    } else {
      context.read<SearchBeasiswaBloc>().add(FetchSearchBeasiswaFilterEvent(
          keyword: keyword, penerima: idFilterBeasiswa));
    }
  }

  void onScroll(BuildContext context, String keyword) {
    double maxScroll = scrollController.position.maxScrollExtent;
    double currentScroll = scrollController.position.pixels;

    if (currentScroll == maxScroll) {
      if (idFilterBeasiswa == 0) {
        context
            .read<SearchBeasiswaBloc>()
            .add(FetchSearchBeasiswaEvent(keyword: keyword));
      } else {
        context.read<SearchBeasiswaBloc>().add(FetchSearchBeasiswaFilterEvent(
            keyword: keyword, penerima: idFilterBeasiswa));
      }
    }
  }
}
