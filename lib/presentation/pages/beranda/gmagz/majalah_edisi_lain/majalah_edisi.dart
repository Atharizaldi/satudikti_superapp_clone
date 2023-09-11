import 'package:app/common/baseUrl.dart';
import 'package:app/injection.dart' as di;
import 'package:app/presentation/component/constant.dart';
import 'package:app/presentation/component/customAppBar.dart';
import 'package:app/presentation/component/noInternet.dart';
import 'package:app/presentation/component/server_problem.dart';
import 'package:app/presentation/pages/beranda/gmagz/bloc/detailmajalah/majalah_detail_gmagz_bloc.dart';
import 'package:app/presentation/pages/beranda/gmagz/bloc/majalah/majalah_gmagz_bloc.dart';
import 'package:app/presentation/pages/beranda/gmagz/component/list_majalah.dart';
import 'package:app/presentation/pages/beranda/gmagz/component/skeleton_loading_list.dart';
import 'package:app/presentation/pages/beranda/gmagz/detailPage/detail_page.dart';
import 'package:app/presentation/pages/beranda/sister/component/dropdown_sister.dart';
import 'package:app/presentation/pages/beranda/sister/component/empty_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MajalahEdisiPage extends StatefulWidget {
  const MajalahEdisiPage({Key? key}) : super(key: key);

  @override
  State<MajalahEdisiPage> createState() => _MajalahEdisiPageState();
}

class _MajalahEdisiPageState extends State<MajalahEdisiPage> {
  String? _selectedValue;
  final removeTag = RegExp(r'<[^>]*>');
  late MajalahGMagzBloc _majalahGMagzBloc;

  bool max = false;

  ScrollController _scrollController = ScrollController();
  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void onScroll(BuildContext context) {
    double maxScroll = _scrollController.position.maxScrollExtent;
    double currentScroll = _scrollController.position.pixels;

    if (currentScroll == maxScroll) {
      _majalahGMagzBloc.add(GetMajalahGMagzEvent(
          sort: "false",
          judul: _majalahGMagzBloc.keywordSearch,
          displayby: _majalahGMagzBloc.displayBySearch));
    }
  }

  // void _onChanged(value) {
  //   setState(() {
  //     _selectedValue = value.toString();
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MajalahGMagzBloc, MajalahGMagzState>(
      builder: (context, state) {
        _majalahGMagzBloc = BlocProvider.of<MajalahGMagzBloc>(context);
        _scrollController.addListener(() {
          onScroll(context);
        });
        if (state is MajalahGMagzNoInternetState) {
          return _majalah(context, state);
        } else if (state is MajalahGMagzErrorState) {
          return _majalah(context, state);
        } else if (state is MajalahGMagzLoadedState) {
          return _majalah(context, state);
        } else {
          return _majalah(context, state);
        }
      },
      listener: (context, state) {
        if (state is MajalahGMagzNoInternetState) {
          ScaffoldMessenger.of(context).showSnackBar(noInternet);
        }
      },
    );
    // return _majalah();
  }

  Widget _majalah(BuildContext context, MajalahGMagzState state) {
    _majalahGMagzBloc = BlocProvider.of<MajalahGMagzBloc>(context);

    return Scaffold(
      backgroundColor: whiteBgPage,
      appBar: CustomAppBar(
        title: 'Daftar Majalah',
        textStyle: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w700),
      ),
      body: _body(context, state),
    );
  }

  Widget _body(BuildContext context, MajalahGMagzState state) {
    if (state is MajalahGMagzinInitial) {
      return SkeletonLoadingListGMagz();
    } else if (state is MajalahGMagzLoading) {
      return SkeletonLoadingListGMagz();
    } else if (state is MajalahGMagzLoadedState) {
      if (state.listBook.isEmpty) {
        return SkeletonLoadingListGMagz();
      } else {
        return ListView(
          controller: _scrollController,
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: EdgeInsets.only(right: 16.w, top: 16.w),
                child: DropDownSister(
                  items: [
                    "Majalah rilis terbaru",
                    "Majalah rilis terdahulu",
                  ],
                  value: _selectedValue == null
                      ? "Majalah rilis terbaru"
                      : _selectedValue.toString(),
                  onChanged: (value) {
                    setState(() {
                      _selectedValue = value as String;
                      print(value);
                      _majalahGMagzBloc.add(GetMajalahGMagzEvent(
                          sort: "false",
                          judul: "",
                          displayby: _selectedValue == "Majalah rilis terdahulu"
                              ? "majalah-rilis-asc"
                              : "majalah-rilis-desc"));
                    });
                  },
                ),
              ),
            ),
            ListView.separated(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: (state.hasReachedMax)
                  ? state.listBook.length
                  : state.listBook.length + 1,
              itemBuilder: (context, index) {
                // return Text(state.listBook[index].judul);
                if (index < state.listBook.length) {
                  return MajalahPopulerCard(
                    imageURL:
                        "$urlAPI${state.listBook[index].uriCover.filePath}",
                    // imageURL:
                    //     "$urlAPI${state.listBook[index].uriCover.filePath}",
                    judulMajalah: state.listBook[index].judul,
                    penilaian: state.listBook[index].rating,
                    review: state.listBook[index].totalReview,
                    description: state.listBook[index].sinopsis != ''
                        ? state.listBook[index].sinopsis
                            .replaceAll(removeTag, '')
                        : "-",
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BlocProvider(
                                    create: (context) => di
                                        .locator<MajalahDetailGMagzBloc>()
                                      ..add(GetMajalahDetailGMagzEvent(
                                          id: state.listBook[index].idBook)),
                                    child: DetailMagPage(),
                                  )));
                    },
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
              },
              separatorBuilder: (BuildContext context, int index) {
                return SizedBox(height: 12.h);
              },
            ),
            SizedBox(
              height: 20.h,
            )
          ],
        );
      }
    } else {
      if (state is MajalahGMagzNoInternetState) {
        return Container(
          color: Colors.transparent,
          height: screenHeight(context) * 0.5,
          child: NoInternet(
              onPressed: () {
                _majalahGMagzBloc.add(GetMajalahGMagzEvent(
                    sort: "false",
                    judul: _majalahGMagzBloc.keywordSearch,
                    displayby: _majalahGMagzBloc.displayBySearch));
              },
              buttonHide: false),
        );
      } else if (state is MajalahGMagzNotFoundState) {
        return EmptyDataPage();
      } else if (state is MajalahGMagzErrorState) {
        return Container(
          color: Colors.transparent,
          height: screenHeight(context) * 0.5,
          child: ServerProblem(
              onPressed: () {
                _majalahGMagzBloc.add(GetMajalahGMagzEvent(
                    sort: "false",
                    judul: _majalahGMagzBloc.keywordSearch,
                    displayby: _majalahGMagzBloc.displayBySearch));
              },
              buttonHide: false),
        );
      } else {
        return Container(
          color: Colors.transparent,
          height: screenHeight(context) * 0.5,
          child: ServerProblem(
              onPressed: () {
                _majalahGMagzBloc.add(GetMajalahGMagzEvent(
                    sort: "false",
                    judul: _majalahGMagzBloc.keywordSearch,
                    displayby: _majalahGMagzBloc.displayBySearch));
              },
              buttonHide: false),
        );
      }
    }
  }
}
