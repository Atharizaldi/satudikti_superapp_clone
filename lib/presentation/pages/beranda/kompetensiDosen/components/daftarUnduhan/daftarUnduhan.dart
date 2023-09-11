import 'package:app/presentation/component/constant.dart';
import 'package:app/presentation/component/customAppBar.dart';
import 'package:app/presentation/pages/beranda/kompetensiDosen/bloc/file_list/file_list_bloc.dart';
import 'package:app/presentation/pages/beranda/kompetensiDosen/components/daftarUnduhan/cardDaftarUnduhan.dart';
import 'package:app/presentation/pages/beranda/kompetensiDosen/components/daftarUnduhan/skeleton_card_daftar_unduhan.dart';
import 'package:app/presentation/pages/beranda/kompetensiDosen/reusableWidgets/reusableWidgetsCard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DaftarUnduhan extends StatelessWidget {
  const DaftarUnduhan({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteBgPage,
      appBar: CustomAppBar(
        title: "Daftar Unduhan",
      ),
      body: Container(
        color: whiteBgPage,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 30.sp,
              ),
              BlocBuilder<FileListBloc, FileListState>(
                builder: (context, state) {
                  if (state is FileListLoaded) {
                    return ListView.builder(
                        padding: EdgeInsets.zero,
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: state.filelist.length,
                        itemBuilder: (buildContext, index) {
                          return Column(
                            children: [
                              CardDaftarUnduhan(
                                id: state.filelist[index].id ?? "",
                                name: state.filelist[index].name ?? "",
                                createdAt: state.filelist[index].date ??
                                    "2022-04-11T19:19:23Z",
                                url: state.filelist[index].url ?? "",
                              ),
                              SizedBox(height: 20.sp)
                            ],
                          );
                        });
                  } else if (state is FileListNoInternet) {
                    return Container(
                        height: 400.w,
                        alignment: Alignment.center,
                        child: noInternetWithContainer());
                  } else if (state is FileListError) {
                    return Container(
                      height: 400.w,
                      alignment: Alignment.center,
                      child: serverProblem(),
                    );
                  } else {
                    return ListView.builder(
                        padding: EdgeInsets.zero,
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: 4,
                        itemBuilder: (buildContext, index) {
                          return Column(
                            children: [
                              SkeletonCardDaftarUnduhan(),
                              SizedBox(height: 20.sp)
                            ],
                          );
                        });
                  }
                },
              ),
              SizedBox(
                height: 5.sp,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
