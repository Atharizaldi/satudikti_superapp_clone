import 'package:app/presentation/component/constant.dart';
import 'package:app/presentation/pages/beranda/pddikti/cubit/tab_bar/tab_bar_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

TabBar pddiktiTabBarButton(BuildContext context, TabController tabController) {
  return TabBar(
    onTap: (index) {
      BlocProvider.of<TabBarCubit>(context).changeTabIndex(index);
    },
    controller: tabController,
    isScrollable: true,
    indicatorColor: Colors.transparent,
    labelPadding: EdgeInsets.symmetric(horizontal: 5.w),
    //left 4 because added with label padding so 12 + 4 = 16
    padding: EdgeInsets.symmetric(horizontal: 11.w),
    tabs: [
      _tab(title: "Semua", tabIndex: 0),
      _tab(title: "Mahasiswa", tabIndex: 1),
      _tab(title: "Perguruan Tinggi", tabIndex: 2),
      _tab(title: "Dosen", tabIndex: 3),
      _tab(title: "Prodi", tabIndex: 4),
    ],
  );
}

TabBar riwayatUsulanDosenTabBar({
  required BuildContext context,
  required TabController tabController,
  required int totalSemua,
  required int totalDraft,
  required int totalDisetujui,
  required int totalDiusulkan,
  required int totalDitolak,
  required int totalDitangguhkan,
}) {
  return TabBar(
    onTap: (index) {
      BlocProvider.of<TabBarCubit>(context).changeTabIndex(index);
    },
    controller: tabController,
    isScrollable: true,
    indicatorColor: Colors.transparent,
    labelPadding: EdgeInsets.symmetric(horizontal: 5.w),
    //left 4 because added with label padding so 12 + 4 = 16
    padding: EdgeInsets.symmetric(horizontal: 11.w),
    tabs: [
      _tab(title: "Semua", tabIndex: 0, totalItem: totalSemua),
      _tab(title: "Draft", tabIndex: 1, totalItem: totalDraft),
      _tab(title: "Disetujui", tabIndex: 2, totalItem: totalDisetujui),
      _tab(title: "Diusulkan", tabIndex: 3, totalItem: totalDiusulkan),
      _tab(title: "Ditolak", tabIndex: 4, totalItem: totalDitolak),
      _tab(title: "Ditangguhkan", tabIndex: 5, totalItem: totalDitangguhkan),
    ],
  );
}

TabBar riwayatPerubahanDosenTendikTabBar({
  required BuildContext context,
  required TabController tabController,
  required int totalSemua,
  required int totalDraft,
  required int totalDisetujui,
  required int totalDiusulkan,
  required int totalDitolak,
  required int totalDitangguhkan,
}) {
  return TabBar(
    onTap: (index) {
      BlocProvider.of<TabBarCubit>(context).changeTabIndex(index);
    },
    controller: tabController,
    isScrollable: true,
    indicatorColor: Colors.transparent,
    labelPadding: EdgeInsets.symmetric(horizontal: 5.w),
    //left 4 because added with label padding so 12 + 4 = 16
    padding: EdgeInsets.symmetric(horizontal: 11.w),
    tabs: [
      _tab(title: "Semua", tabIndex: 0, totalItem: totalSemua),
      _tab(title: "Draft", tabIndex: 1, totalItem: totalDraft),
      _tab(title: "Disetujui", tabIndex: 2, totalItem: totalDisetujui),
      _tab(title: "Diusulkan", tabIndex: 3, totalItem: totalDiusulkan),
      _tab(title: "Ditolak", tabIndex: 4, totalItem: totalDitolak),
      _tab(title: "Ditangguhkan", tabIndex: 5, totalItem: totalDitangguhkan),
    ],
  );
}

TabBar notifikasiTabBar(
    {required BuildContext context,
    required TabController tabController,
    required int totalUnread,
    required int pengumumanUnread,
    required int beritaUnread,
    required int usulanDosenUnread,
    required int kompetensiDosenUnRead,
    required int selancarPAKUnread}) {
  return TabBar(
    controller: tabController,
    onTap: (index) {
      BlocProvider.of<TabBarCubit>(context).changeTabIndex(index);
    },
    isScrollable: true,
    indicatorColor: Colors.transparent,
    labelPadding: EdgeInsets.symmetric(horizontal: 12.w),
    //left 4 because added with label padding so 12 + 4 = 16
    padding: EdgeInsets.only(left: 4.w),
    tabs: [
      _tab(title: "Semua", tabIndex: 0, totalItem: totalUnread),
      _tab(title: "Pengumuman", tabIndex: 1, totalItem: pengumumanUnread),
      _tab(title: "Berita", tabIndex: 2, totalItem: beritaUnread),
      _tab(title: "Usulan Dosen", tabIndex: 3, totalItem: usulanDosenUnread),
      _tab(
          title: "Kompetensi Dosen",
          tabIndex: 4,
          totalItem: kompetensiDosenUnRead),
      _tab(title: "Selancar PAK", tabIndex: 5, totalItem: selancarPAKUnread)
    ],
  );
}

TabBar notifikasiTabBar2(
    {required BuildContext context,
    required TabController tabController,
    required int totalUnread,
    required int pengumumanUnread,
    required int beritaUnread,
    required int usulanDosenUnread,
    required int kompetensiDosenUnRead,
    required int selancarPAKUnread}) {
  return TabBar(
    controller: tabController,
    onTap: (index) {
      BlocProvider.of<TabBarCubit>(context).changeTabIndex(index);
    },
    isScrollable: true,
    indicatorColor: Colors.transparent,
    labelPadding: EdgeInsets.symmetric(horizontal: 12.w),
    //left 4 because added with label padding so 12 + 4 = 16
    padding: EdgeInsets.only(left: 4.w),
    tabs: [
      _tab(title: "Semua", tabIndex: 0, totalItem: totalUnread),
      _tab(title: "Pengumuman", tabIndex: 1, totalItem: pengumumanUnread),
      _tab(title: "Berita", tabIndex: 2, totalItem: beritaUnread),
      // _tab(title: "Usulan Dosen", tabIndex: 3, totalItem: usulanDosenUnread),
      // _tab(
      //     title: "Kompetensi Dosen",
      //     tabIndex: 4,
      //     totalItem: kompetensiDosenUnRead),
      // _tab(title: "Selancar PAK", tabIndex: 5, totalItem: selancarPAKUnread)
    ],
  );
}

TabBar pengumumanTabBar({
  required BuildContext context,
  required TabController tabController,
}) {
  return TabBar(
    controller: tabController,
    onTap: (index) {
      BlocProvider.of<TabBarCubit>(context).changeTabIndex(index);
    },
    isScrollable: true,
    indicatorColor: Colors.transparent,
    labelPadding: EdgeInsets.symmetric(horizontal: 12.w),
    //left 4 because added with label padding so 12 + 4 = 16
    padding: EdgeInsets.only(left: 4.w),
    tabs: [
      _tab(
        title: "Umum",
        tabIndex: 0,
      ),
      _tab(
        title: "Sumber daya",
        tabIndex: 1,
      ),
      _tab(
        title: "Kelembagaan",
        tabIndex: 2,
      ),
      _tab(
        title: "Pembelajaran dan mahasiswa",
        tabIndex: 3,
      ),
    ],
  );
}

TabBar hasilTracerTabBar({
  required BuildContext context,
  required TabController tabController,
}) {
  return TabBar(
    controller: tabController,
    onTap: (index) {
      BlocProvider.of<TabBarCubit>(context).changeTabIndex(index);
    },
    isScrollable: true,
    indicatorColor: Colors.transparent,
    labelPadding: EdgeInsets.symmetric(horizontal: 12.w),
    //left 4 because added with label padding so 12 + 4 = 16
    padding: EdgeInsets.only(left: 4.w),
    tabs: [
      _tab(
        title: "Keselarasan Horizontal",
        tabIndex: 0,
      ),
      _tab(
        title: "Keselarasan Vertikal",
        tabIndex: 1,
      ),
      _tab(
        title: "Pekerjaan <= 6 Bulan",
        tabIndex: 2,
      ),
    ],
  );
}

Tab _tab({required String title, required int tabIndex, int? totalItem}) {
  return Tab(
    child: BlocBuilder<TabBarCubit, int>(
      builder: (context, index) {
        return Container(
          decoration: BoxDecoration(
              border: Border.all(
                  color: index == tabIndex
                      ? selectedLabelColor
                      : unselectedTextColor),
              color:
                  index == tabIndex ? selectedLabelColor : unselectedLabelColor,
              borderRadius: BorderRadius.circular(10.r)),
          child: Container(
            height: 45.h,
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14.sp,
                      color: index == tabIndex
                          ? selectedTextColor
                          : unselectedTextColor),
                ),
                (totalItem == null || totalItem == 0)
                    ? SizedBox()
                    : Container(
                        height: 20.h,
                        margin: EdgeInsets.only(left: 8.w),
                        decoration: BoxDecoration(
                          color: index == tabIndex
                              ? selectedTextColor
                              : unselectedTextColor,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 5.5.w),
                            child: Text(
                              "$totalItem",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 14.sp,
                                color: index == tabIndex
                                    ? selectedLabelColor
                                    : unselectedLabelColor,
                              ),
                            ),
                          ),
                        ),
                      ),
              ],
            ),
          ),
        );
      },
    ),
  );
}

// TabBar pddiktiTabBarButton(BuildContext context, TabController controller) {
//   return TabBar(
//     controller: controller,
//     isScrollable: true,
//     labelColor: blue3,
//     labelStyle: TextStyle(
//         fontWeight: FontWeight.w600, fontSize: screenWidth(context) * (1 / 25)),
//     unselectedLabelColor: neutralCaption,
//     unselectedLabelStyle: TextStyle(
//         fontWeight: FontWeight.w500, fontSize: screenWidth(context) * (1 / 25)),
//     indicatorColor: blue3,
//     indicatorWeight: 4,
//     labelPadding:
//         EdgeInsets.symmetric(horizontal: screenWidth(context) * (1 / 20)),
//     tabs: [
//       Tab(
//         child: Text(
//           'Semua',
//           style: TextStyle(
//               fontWeight:
//                   controller.index == 0 ? FontWeight.bold : FontWeight.w400),
//         ),
//       ),
//       Tab(
//         child: Text(
//           'Perguruan Tinggi',
//           style: TextStyle(
//               fontWeight:
//                   controller.index == 1 ? FontWeight.bold : FontWeight.w400),
//         ),
//       ),
//       Tab(
//         child: Text(
//           'Prodi',
//           style: TextStyle(
//               fontWeight:
//                   controller.index == 2 ? FontWeight.bold : FontWeight.w400),
//         ),
//       ),
//       Tab(
//         child: Text(
//           'Dosen',
//           style: TextStyle(
//               fontWeight:
//                   controller.index == 3 ? FontWeight.bold : FontWeight.w400),
//         ),
//       ),
//       Tab(
//         child: Text(
//           'Mahasiswa',
//           style: TextStyle(
//               fontWeight:
//                   controller.index == 4 ? FontWeight.bold : FontWeight.w400),
//         ),
//       ),
//     ],
//   );
// }

