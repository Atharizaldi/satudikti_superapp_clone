import 'package:app/data/source/remote/model/selancar/usulan_detail.dart';
import 'package:app/data/source/remote/model/selancar/usulan_list.dart';
import 'package:app/presentation/component/constant.dart';
import 'package:app/presentation/component/customAppBar.dart';
import 'package:app/presentation/component/noInternet.dart';
import 'package:app/presentation/component/server_problem.dart';
import 'package:app/presentation/pages/beranda/selancarPAK/riwayat_usulan/daftar_usulan/bloc/daftar_riwayatusulan_bloc.dart';
import 'package:app/presentation/pages/beranda/selancarPAK/riwayat_usulan/daftar_usulan/components/daftar_pengajuan_baru.dart';
import 'package:app/presentation/pages/beranda/selancarPAK/riwayat_usulan/daftar_usulan/components/daftar_terbit_SK.dart';
import 'package:app/presentation/pages/beranda/selancarPAK/riwayat_usulan/daftar_usulan/components/list_skeleton_PAK.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DaftarRiwayatUsulanPage extends StatelessWidget {
  final String nama;
  final String nidn;
  final List<Usulan> usulanList;
  const DaftarRiwayatUsulanPage({
    Key? key,
    required this.nama,
    required this.nidn,
    required this.usulanList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteBgPage,
      appBar: CustomAppBar(title: 'Daftar Riwayat Usulan'),
      body: BlocConsumer<DaftarRiwayatusulanBloc, DaftarRiwayatusulanState>(
        listener: (context, state) {
          if (state is DaftarRiwayatusulanNoInternetState) {
            ScaffoldMessenger.of(context).showSnackBar(noInternet);
          } else if (state is DaftarRiwayatusulanErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(noInternet);
          }
        },
        builder: (context, state) {
          if (state is DaftarRiwayatusulanInitial) {
            return _daftarRiwayatUsulanLoading();
          } else if (state is DaftarRiwayatusulanLoadedState) {
            if (state.usulanDetail.isEmpty) {
              return _daftarRiwayatUsulanLoading();
            }
            return _daftarRiwayatUsulan(state.usulanDetail);
          } else if (state is DaftarRiwayatusulanNoInternetState) {
            return NoInternet(onPressed: () {}, buttonHide: false);
          } else if (state is DaftarRiwayatusulanErrorState) {
            return ServerProblem(onPressed: () {}, buttonHide: false);
          } else {
            return SizedBox();
          }
        },
      ),
    );
  }

  Widget _daftarRiwayatUsulan(List<UsulanDetail> usulanDetail) {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          SizedBox(height: 30.h),
          _tabBar(),
          SizedBox(height: 30.h),
          Flexible(
            child: Container(
              child: TabBarView(
                physics: NeverScrollableScrollPhysics(),
                children: [
                  pengajuanBaru(
                    nama,
                    nidn,
                    usulanList,
                    usulanDetail,
                  ),
                  terbitSK(
                    nama,
                    nidn,
                    usulanList,
                    usulanDetail,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _daftarRiwayatUsulanLoading() {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          SizedBox(height: 30.h),
          _tabBar(),
          SizedBox(height: 30.h),
          Flexible(
            child: Container(
              child: TabBarView(
                physics: NeverScrollableScrollPhysics(),
                children: [
                  SkeletonLoadingUsulanListPAK(),
                  SkeletonLoadingUsulanListPAK(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _tabBar() {
    return Container(
      width: 358.w,
      height: 58.sp,
      padding: EdgeInsets.symmetric(
        horizontal: 4.w,
        vertical: 4.w,
      ),
      decoration: BoxDecoration(
        color: neutral10,
        borderRadius: BorderRadius.circular(4.r),
      ),
      child: TabBar(
        unselectedLabelColor: neutral40,
        indicator: BoxDecoration(
          color: blue4,
          borderRadius: BorderRadius.circular(4.r),
        ),
        tabs: [
          Container(
            width: 350.w,
            height: 50.sp,
            alignment: Alignment.center,
            child: Text(
              'Pengajuan Baru',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Container(
            width: 350.w,
            height: 50.sp,
            alignment: Alignment.center,
            child: Text(
              'Terbit SK',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
