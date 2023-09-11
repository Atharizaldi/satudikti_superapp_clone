import 'package:app/injection.dart' as di;
import 'package:app/presentation/component/constant.dart';
import 'package:app/presentation/pages/beranda/kompetensiDosen/reusableWidgets/reusableWidgetsCard.dart';
import 'package:app/presentation/pages/beranda/pddikti/component/tabBarButton.dart';
import 'package:app/presentation/pages/beranda/pddikti/cubit/tab_bar/tab_bar_cubit.dart';
import 'package:app/presentation/pages/notifikasi/bloc/notifikasi_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'notifikasiSemuaList.dart';

class NotifikasiPage extends StatefulWidget {
  NotifikasiPage({
    Key? key,
  }) : super(key: key);

  @override
  _NotifikasiPageState createState() => _NotifikasiPageState();
}

class _NotifikasiPageState extends State<NotifikasiPage>
    with TickerProviderStateMixin {
  late TabController tabController;
  late Future<bool> boolFuture;

  @override
  void initState() {
    boolFuture = checkLogin();

    super.initState();
  }

  Future<bool> checkLogin() async {
    String? userCredentials =
        await FlutterSecureStorage().read(key: "user_credentials");
    if (userCredentials != null) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<NotifikasiBloc>(
            create: (BuildContext context) =>
                di.locator<NotifikasiBloc>()..add(GetNotifikasiEvent()),
          ),
        ],
        child: FutureBuilder(
          future: boolFuture,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return Scaffold(
                  backgroundColor: whiteBgPage,
                  appBar: _appBar(),
                  body: Container(
                    child: Center(child: CircularProgressIndicator()),
                  ));
            }

            if (!snapshot.hasData) {
              return Scaffold(
                  backgroundColor: whiteBgPage,
                  appBar: _appBar(),
                  body: Container(
                    child: Center(child: serverProblem()),
                  )); //your widget when error happens
            }

            final data = snapshot.data; //your Map<String,dynamic>
            final int length = data ? 6 : 3;
            tabController = new TabController(length: length, vsync: this);
            tabController.addListener(() {
              BlocProvider.of<TabBarCubit>(context)
                  .changeTabIndex(tabController.index);
            });
            print(data);

            if (data) {
              return Scaffold(
                backgroundColor: whiteBgPage,
                appBar: _appBar(),
                body: Container(
                  margin: EdgeInsets.only(top: 30.h),
                  child: Scaffold(
                    backgroundColor: whiteBgPage,
                    appBar: _appBar2(),
                    body: TabBarView(
                      controller: tabController,
                      physics: NeverScrollableScrollPhysics(),
                      children: [
                        NotifikasiSemuaList(
                          notificationCategory: 0,
                        ),
                        NotifikasiSemuaList(
                          notificationCategory: 1,
                        ),
                        NotifikasiSemuaList(
                          notificationCategory: 2,
                        ),
                        NotifikasiSemuaList(
                          notificationCategory: 3,
                        ),
                        NotifikasiSemuaList(
                          notificationCategory: 4,
                        ),
                        NotifikasiSemuaList(
                          notificationCategory: 5,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            } else {
              return Scaffold(
                backgroundColor: whiteBgPage,
                appBar: _appBar(),
                body: Container(
                  margin: EdgeInsets.only(top: 30.h),
                  child: Scaffold(
                    backgroundColor: whiteBgPage,
                    appBar: _appBar3(),
                    body: TabBarView(
                      controller: tabController,
                      physics: NeverScrollableScrollPhysics(),
                      children: [
                        NotifikasiSemuaList(
                          notificationCategory: 0,
                        ),
                        NotifikasiSemuaList(
                          notificationCategory: 1,
                        ),
                        NotifikasiSemuaList(
                          notificationCategory: 2,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }
            //return Container(); //place your widget here
          },
        ));
  }

  AppBar _appBar() {
    return AppBar(
      backgroundColor: white,
      title: Text(
        'Notifikasi',
        style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20.sp),
      ),
      flexibleSpace: Padding(
        padding: const EdgeInsets.only(bottom: 0.5),
        child: Container(
            decoration: BoxDecoration(
          gradient: appBarGradient,
        )),
      ),
      centerTitle: true,
      actions: <Widget>[
        PopupMenuButton(
            icon: Icon(Icons.more_horiz),
            color: white,
            shape: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.r)),
                borderSide: BorderSide(
                  color: neutral40,
                )),
            itemBuilder: (context) => [
                  PopupMenuItem(
                    child: Center(
                        child: Container(width: 180.w, child: _readAllNotif())),
                    onTap: () {
                      BlocProvider.of<NotifikasiBloc>(context)
                        ..add(MarkReadAllNotifikasiEvent());
                    },
                    padding: EdgeInsets.zero,
                    height: 72.h,
                  ),
                ])
      ],
      elevation: 0,
    );
  }

  PreferredSize _appBar2() {
    return PreferredSize(
      //not using .h for static size
      preferredSize: Size.fromHeight(100.h),
      child: BlocBuilder<NotifikasiBloc, NotifikasiState>(
        builder: (context, state) {
          if (state is NotifikasiLoadedState) {
            int totalUnread = state.notificationList
                .where((notification) => notification.isRead == 0)
                .length;
            int pengumumanUnread = state.notificationPengumumanList
                .where((notification) => notification.isRead == 0)
                .length;
            int beritaUnread = state.notificationBeritaList
                .where((notification) => notification.isRead == 0)
                .length;
            int komdosUnread = state.notificationKomdosList
                .where((notification) => notification.isRead == 0)
                .length;
            int selancarPAKUnread = state.notificationSelancarPAKList
                .where((notification) => notification.isRead == 0)
                .length;
            int pddiktiUnread = state.notificationPDDiktiList
                .where((notification) => notification.isRead == 0)
                .length;
            return Container(
                width: double.infinity,
                color: whiteBgPage,
                child: notifikasiTabBar(
                  context: context,
                  tabController: tabController,
                  totalUnread: totalUnread,
                  pengumumanUnread: pengumumanUnread,
                  beritaUnread: beritaUnread,
                  usulanDosenUnread: pddiktiUnread,
                  kompetensiDosenUnRead: komdosUnread,
                  selancarPAKUnread: selancarPAKUnread,
                ));
          } else {
            return Container(
                width: double.infinity,
                color: whiteBgPage,
                child: notifikasiTabBar(
                  context: context,
                  tabController: tabController,
                  totalUnread: 0,
                  pengumumanUnread: 0,
                  beritaUnread: 0,
                  usulanDosenUnread: 0,
                  kompetensiDosenUnRead: 0,
                  selancarPAKUnread: 0,
                ));
          }
        },
      ),
    );
  }

  PreferredSize _appBar3() {
    return PreferredSize(
      //not using .h for static size
      preferredSize: Size.fromHeight(100.h),
      child: BlocBuilder<NotifikasiBloc, NotifikasiState>(
        builder: (context, state) {
          if (state is NotifikasiLoadedState) {
            int totalUnread = state.notificationList
                .where((notification) => notification.isRead == 0)
                .length;
            int pengumumanUnread = state.notificationPengumumanList
                .where((notification) => notification.isRead == 0)
                .length;
            int beritaUnread = state.notificationBeritaList
                .where((notification) => notification.isRead == 0)
                .length;
            int komdosUnread = state.notificationKomdosList
                .where((notification) => notification.isRead == 0)
                .length;
            int selancarPAKUnread = state.notificationSelancarPAKList
                .where((notification) => notification.isRead == 0)
                .length;
            int pddiktiUnread = state.notificationPDDiktiList
                .where((notification) => notification.isRead == 0)
                .length;
            return Container(
                width: double.infinity,
                color: whiteBgPage,
                child: notifikasiTabBar2(
                  context: context,
                  tabController: tabController,
                  totalUnread: totalUnread,
                  pengumumanUnread: pengumumanUnread,
                  beritaUnread: beritaUnread,
                  usulanDosenUnread: pddiktiUnread,
                  kompetensiDosenUnRead: komdosUnread,
                  selancarPAKUnread: selancarPAKUnread,
                ));
          } else {
            return Container(
                width: double.infinity,
                color: whiteBgPage,
                child: notifikasiTabBar2(
                  context: context,
                  tabController: tabController,
                  totalUnread: 0,
                  pengumumanUnread: 0,
                  beritaUnread: 0,
                  usulanDosenUnread: 0,
                  kompetensiDosenUnRead: 0,
                  selancarPAKUnread: 0,
                ));
          }
        },
      ),
    );
  }

  Widget _readAllNotif() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset('assets/notifikasi/ic_outline_mark_read.png'),
        Container(
          margin: EdgeInsets.only(left: 5.w),
          child: Text(
            "Tandai Sudah Dibaca",
            style: TextStyle(
                color: green3, fontSize: 12.sp, fontWeight: FontWeight.w400),
          ),
        ),
      ],
    );
  }
}
