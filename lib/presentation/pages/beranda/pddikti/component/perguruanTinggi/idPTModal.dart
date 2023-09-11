import 'package:app/presentation/component/constant.dart';
import 'package:app/presentation/component/search/searchBar.dart';
import 'package:app/presentation/pages/beranda/pddikti/bloc/detail_pencarian/pt/detail_pencarian_pt_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class IDMODALPDDIKTI extends StatelessWidget {
  BuildContext context;
  TextEditingController controller;
  String pt;
  Function(String)? onPtSelected;

  IDMODALPDDIKTI(
      {Key? key,
      required this.context,
      required this.controller,
      this.onPtSelected,
      required this.pt})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DetailPencarianPtBloc, DetailPencarianPtState>(
        builder: (context, state) {
      if (state is InitDetailPTState) {
        return _modalShow(context);
      } else if (state is LoadingPTState) {
        return _modalShow(context);
      } else if (state is IDPTLoaded) {
        return FractionallySizedBox(
          heightFactor: 0.8,
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            decoration: BoxDecoration(
              color: whiteBgPage,
              borderRadius: BorderRadius.vertical(top: Radius.circular(12.r)),
            ),
            child: Column(
              children: [
                SizedBox(height: 16.h),
                Container(
                  width: 30.w,
                  height: 3.h,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                ),
                SizedBox(height: 16.h),
                Expanded(
                    child: Column(
                  children: [
                    SearchBar(
                      controller: controller,
                      openKeyboard: true,
                      hintText: 'Pilih perguruan ',
                      searchType: TypeSearchBar.withClear,
                      isSubmitted: (value) {
                        print("INI VALUE $value");
                        BlocProvider.of<DetailPencarianPtBloc>(context)
                            .add(IDPTPDDIKTIEvent(id: value));
                        // _detailPencarianPtBloc
                        //     .add(IDPTPDDIKTIEvent(id: value));
                        // _majalahGMagzBloc.add(GetMajalahGMagzEvent(
                        //     sort: "", judul: value, displayby: ""));
                      },
                    ),
                    SizedBox(
                      height: 20.h,
                    ),

                    ListView.separated(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: state.idptpddikti.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            controller.text = state.idptpddikti[index].nama;
                            pt = state.idptpddikti[index].id;
                            if (onPtSelected != null) {
                              onPtSelected!(pt);
                            }
                            Navigator.pop(context);
                          },
                          // onTap: () {
                          //   pt = "asd";
                          //   namaPerguruanTinggiController.text = "asd";
                          //   Navigator.pop(context);
                          // },
                          child: Text(state.idptpddikti[index].nama),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return SizedBox(height: 12.h);
                      },
                    ),
                    // Text("data"),
                    // ListView.separated(
                    //     itemBuilder: (context, index) {
                    //       return GestureDetector(
                    //         onTap: () {
                    //           pt = "asd";
                    //           namaPerguruanTinggiController.text = "asd";
                    //         },
                    //         child: Text("ASD"),
                    //       );
                    //     },
                    //     separatorBuilder:
                    //         (BuildContext context, int index) {
                    //       return SizedBox(height: 10);
                    //     },
                    //     itemCount: 2)
                  ],
                )),
              ],
            ),
          ),
        );
      } else {
        if (state is NoInternetPTState) {
          return _modalShow(context);
        } else if (state is NotFoundPTState) {
          return FractionallySizedBox(
            heightFactor: 0.8,
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              decoration: BoxDecoration(
                color: whiteBgPage,
                borderRadius: BorderRadius.vertical(top: Radius.circular(12.r)),
              ),
              child: Column(
                children: [
                  SizedBox(height: 16.h),
                  Container(
                    width: 30.w,
                    height: 3.h,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Expanded(
                      child: Column(
                    children: [
                      SearchBar(
                        controller: controller,
                        openKeyboard: true,
                        hintText: 'Pilih perguruan ',
                        searchType: TypeSearchBar.withClear,
                        isSubmitted: (value) {
                          print("INI VALUE $value");
                          BlocProvider.of<DetailPencarianPtBloc>(context)
                              .add(IDPTPDDIKTIEvent(id: value));
                          // _detailPencarianPtBloc
                          //     .add(IDPTPDDIKTIEvent(id: value));
                          // _majalahGMagzBloc.add(GetMajalahGMagzEvent(
                          //     sort: "", judul: value, displayby: ""));
                        },
                      ),
                      SizedBox(
                        height: 20.h,
                      ),

                      // Text("data"),
                      // ListView.separated(
                      //     itemBuilder: (context, index) {
                      //       return GestureDetector(
                      //         onTap: () {
                      //           pt = "asd";
                      //           namaPerguruanTinggiController.text = "asd";
                      //         },
                      //         child: Text("ASD"),
                      //       );
                      //     },
                      //     separatorBuilder:
                      //         (BuildContext context, int index) {
                      //       return SizedBox(height: 10);
                      //     },
                      //     itemCount: 2)
                    ],
                  )),
                ],
              ),
            ),
          );
        } else if (state is ErrorPTState) {
          return FractionallySizedBox(
            heightFactor: 0.8,
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              decoration: BoxDecoration(
                color: whiteBgPage,
                borderRadius: BorderRadius.vertical(top: Radius.circular(12.r)),
              ),
              child: Column(
                children: [
                  SizedBox(height: 16.h),
                  Container(
                    width: 30.w,
                    height: 3.h,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Expanded(
                      child: Column(
                    children: [
                      SearchBar(
                        controller: controller,
                        openKeyboard: true,
                        hintText: 'Pilih perguruan ',
                        searchType: TypeSearchBar.withClear,
                        isSubmitted: (value) {
                          print("INI VALUE $value");
                          BlocProvider.of<DetailPencarianPtBloc>(context)
                              .add(IDPTPDDIKTIEvent(id: value));
                          // _detailPencarianPtBloc
                          //     .add(IDPTPDDIKTIEvent(id: value));
                          // _majalahGMagzBloc.add(GetMajalahGMagzEvent(
                          //     sort: "", judul: value, displayby: ""));
                        },
                      ),
                      SizedBox(
                        height: 20.h,
                      ),

                      // Text("data"),
                      // ListView.separated(
                      //     itemBuilder: (context, index) {
                      //       return GestureDetector(
                      //         onTap: () {
                      //           pt = "asd";
                      //           namaPerguruanTinggiController.text = "asd";
                      //         },
                      //         child: Text("ASD"),
                      //       );
                      //     },
                      //     separatorBuilder:
                      //         (BuildContext context, int index) {
                      //       return SizedBox(height: 10);
                      //     },
                      //     itemCount: 2)
                    ],
                  )),
                ],
              ),
            ),
          );
        } else {
          return FractionallySizedBox(
            heightFactor: 0.8,
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              decoration: BoxDecoration(
                color: whiteBgPage,
                borderRadius: BorderRadius.vertical(top: Radius.circular(12.r)),
              ),
              child: Column(
                children: [
                  SizedBox(height: 16.h),
                  Container(
                    width: 30.w,
                    height: 3.h,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Expanded(
                      child: Column(
                    children: [
                      SearchBar(
                        controller: controller,
                        openKeyboard: true,
                        hintText: 'Pilih perguruan ',
                        searchType: TypeSearchBar.withClear,
                        isSubmitted: (value) {
                          print("INI VALUE $value");
                          BlocProvider.of<DetailPencarianPtBloc>(context)
                              .add(IDPTPDDIKTIEvent(id: value));
                          // _detailPencarianPtBloc
                          //     .add(IDPTPDDIKTIEvent(id: value));
                          // _majalahGMagzBloc.add(GetMajalahGMagzEvent(
                          //     sort: "", judul: value, displayby: ""));
                        },
                      ),
                      SizedBox(
                        height: 20.h,
                      ),

                      // Text("data"),
                      // ListView.separated(
                      //     itemBuilder: (context, index) {
                      //       return GestureDetector(
                      //         onTap: () {
                      //           pt = "asd";
                      //           namaPerguruanTinggiController.text = "asd";
                      //         },
                      //         child: Text("ASD"),
                      //       );
                      //     },
                      //     separatorBuilder:
                      //         (BuildContext context, int index) {
                      //       return SizedBox(height: 10);
                      //     },
                      //     itemCount: 2)
                    ],
                  )),
                ],
              ),
            ),
          );
        }
      }
    }, listener: (context, state) {
      if (state is NoInternetPTState) {
        ScaffoldMessenger.of(context).showSnackBar(noInternet);
      }
    });
    // return
  }

  Widget _modalShow(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: 0.8,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        decoration: BoxDecoration(
          color: whiteBgPage,
          borderRadius: BorderRadius.vertical(top: Radius.circular(12.r)),
        ),
        child: Column(
          children: [
            SizedBox(height: 16.h),
            Container(
              width: 30.w,
              height: 3.h,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4.r),
              ),
            ),
            SizedBox(height: 16.h),
            Expanded(
                child: Column(
              children: [
                SearchBar(
                  controller: controller,
                  openKeyboard: true,
                  hintText: 'Pilih perguruan ',
                  searchType: TypeSearchBar.withClear,
                  isSubmitted: (value) {
                    print("INI VALUE $value");
                    BlocProvider.of<DetailPencarianPtBloc>(context)
                        .add(IDPTPDDIKTIEvent(id: value));
                    // _detailPencarianPtBloc
                    //     .add(IDPTPDDIKTIEvent(id: value));
                    // _majalahGMagzBloc.add(GetMajalahGMagzEvent(
                    //     sort: "", judul: value, displayby: ""));
                  },
                ),
                SizedBox(
                  height: 20.h,
                ),

                CircularProgressIndicator(),
                // Text("data"),
                // ListView.separated(
                //     itemBuilder: (context, index) {
                //       return GestureDetector(
                //         onTap: () {
                //           pt = "asd";
                //           namaPerguruanTinggiController.text = "asd";
                //         },
                //         child: Text("ASD"),
                //       );
                //     },
                //     separatorBuilder:
                //         (BuildContext context, int index) {
                //       return SizedBox(height: 10);
                //     },
                //     itemCount: 2)
              ],
            )),
          ],
        ),
      ),
    );
  }
}
