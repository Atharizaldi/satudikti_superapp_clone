import 'package:app/common/dateFormat.dart';
import 'package:app/data/source/local/model/notification.dart'
    as NotificationModel;
import 'package:app/data/source/remote/model/profil/user_detail_information.dart';
import 'package:app/injection.dart' as di;
import 'package:app/presentation/component/constant.dart';
import 'package:app/presentation/pages/beranda/beritaDanPengumumanDetail/beritaDanPengumumanSubPage.dart';
import 'package:app/presentation/pages/beranda/kompetensiDosen/bloc/list_tawaran_program/list_tawaran_program_bloc.dart';
import 'package:app/presentation/pages/beranda/kompetensiDosen/bloc/login_kd/login_kd_bloc.dart';
import 'package:app/presentation/pages/beranda/kompetensiDosen/kompetensiDosenPage.dart';
import 'package:app/presentation/pages/beranda/pddikti/bloc/pencarian_spesifik_bloc/pencarian_spesifik_bloc.dart';
import 'package:app/presentation/pages/beranda/pddikti/pddiktiMainPage.dart';
import 'package:app/presentation/pages/beranda/selancarPAK/loggedInPage/bloc/selancarloggedin_bloc.dart';
import 'package:app/presentation/pages/beranda/selancarPAK/loggedInPage/selancar_PAK_logged_in_page.dart';
import 'package:app/presentation/pages/beranda/selancarPAK/selancar_PAK_page.dart';
import 'package:app/presentation/pages/notifikasi/component/notificationCard.dart';
import 'package:app/presentation/pages/profil/bloc/profil_bloc.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grouped_list/grouped_list.dart';

import 'bloc/notifikasi_bloc.dart';

class NotifikasiSemuaList extends StatefulWidget {
  final int notificationCategory;

  const NotifikasiSemuaList({Key? key, required this.notificationCategory})
      : super(key: key);

  @override
  _NotifikasiSemuaListState createState() => _NotifikasiSemuaListState();
}

class _NotifikasiSemuaListState extends State<NotifikasiSemuaList> {
  FormatDate formatDate = FormatDate();
  late NotifikasiBloc _notifikasiBloc;

  @override
  Widget build(BuildContext context) {
    _notifikasiBloc = BlocProvider.of<NotifikasiBloc>(context);
    return RefreshIndicator(
      onRefresh: () async {
        _notifikasiBloc.add(GetNotifikasiEvent());
      },
      backgroundColor: selectedLabelColor,
      color: white,
      child: BlocBuilder<NotifikasiBloc, NotifikasiState>(
        builder: (context, state) {
          if (state is NotifikasiLoadedState) {
            List<NotificationModel.Notification> notificationList = [];
            if (widget.notificationCategory == 0) {
              notificationList = state.notificationList;
            } else if (widget.notificationCategory == 1) {
              notificationList = state.notificationPengumumanList;
            } else if (widget.notificationCategory == 2) {
              notificationList = state.notificationBeritaList;
            } else if (widget.notificationCategory == 3) {
              notificationList = state.notificationPDDiktiList;
            } else if (widget.notificationCategory == 4) {
              notificationList = state.notificationKomdosList;
            } else if (widget.notificationCategory == 5) {
              notificationList = state.notificationSelancarPAKList;
            }

            return notificationList.isEmpty
                ? Center(child: _noNotif())
                : _buildListView(context, notificationList);
          } else {
            return Center(
              child: CircularProgressIndicator(
                color: selectedLabelColor,
              ),
            );
          }
        },
      ),
    );
  }

  Widget _buildListView(BuildContext context,
      List<NotificationModel.Notification> notificationList) {
    return Container(
      color: whiteBgPage,
      child: GroupedListView<NotificationModel.Notification, String>(
        physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        elements: notificationList,
        groupBy: (notification) => formatDate.formatDate(notification.tanggal),
        groupSeparatorBuilder: (
          String tanggal,
        ) {
          if (formatDate.formatDate(
                  notificationList[notificationList.length - 1].tanggal) ==
              tanggal) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.only(left: 24.w, top: 30.h, bottom: 30.h),
                  child: Text(
                    tanggal,
                    style: TextStyle(
                      color: neutral100,
                      fontWeight: FontWeight.w500,
                      fontSize: 12.sp,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(right: 24.w),
                  child: GestureDetector(
                    onTap: () {
                      BlocProvider.of<NotifikasiBloc>(context)
                        ..add(MarkReadAllNotifikasiEvent());
                    },
                    child: Text(
                      "Tandai sudah dibaca",
                      style: TextStyle(
                          color: blue4,
                          fontWeight: FontWeight.w500,
                          fontSize: 12.sp),
                    ),
                  ),
                )
              ],
            );
          } else {
            return Container(
              padding: EdgeInsets.only(left: 24.w, top: 30.h, bottom: 30.h),
              child: Text(
                tanggal,
                style: TextStyle(
                  color: neutral100,
                  fontWeight: FontWeight.w500,
                  fontSize: 12.sp,
                ),
              ),
            );
          }
        },
        itemBuilder: (context, NotificationModel.Notification notification) {
          return Container(
            margin: EdgeInsets.only(bottom: 4.h),
            child: _buildNotificationCard(
              context,
              notification,
            ),
          );
        },
        order: GroupedListOrder.DESC,
      ),
    );
  }

  Widget _buildNotificationCard(
      BuildContext context, NotificationModel.Notification notification) {
    return NotificationCard(
      isRead: notification.isRead == 1 ? true : false,
      isPengumuman: notification.topic == 'pengumuman' ? true : false,
      category: notification.title,
      title: notification.body,
      onTap: () async {
        if (notification.topic == 'news' ||
            notification.topic == 'pengumuman') {
          onTapNewsPengumuman(notification);
        } else if (notification.topic == 'PDDIKTI') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return BlocProvider(
                  create: (context) => di.locator<PencarianSpesifikBloc>()
                    ..add(InitPencarianSpesifikEvent()),
                  child: PDDiktiMainPage(),
                );
              },
            ),
          );
          _notifikasiBloc
              .add(UpdateNotifikasiEvent(notification: notification));
          await FirebaseAnalytics.instance.logScreenView(
            screenClass: "PDDikti",
            screenName: "PDDikti",
          );
        } else if (notification.topic == 'Komdos') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return MultiBlocProvider(
                  providers: [
                    BlocProvider(
                      create: (context) => di.locator<ListTawaranProgramBloc>()
                        ..add(GetListTawaranProgramEvent()),
                    ),
                    BlocProvider(
                      create: (context) => di.locator<LoginKdBloc>(),
                    )
                  ],
                  child: KompetensiDosenPage(
                    parentContext: context,
                  ),
                );
              },
            ),
          );
          _notifikasiBloc
              .add(UpdateNotifikasiEvent(notification: notification));
          await FirebaseAnalytics.instance.logScreenView(
            screenClass: "Kompetensi Dosen",
            screenName: "Kompetensi Dosen",
          );
        } else if (notification.topic == 'selancarPAK') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BlocBuilder<ProfilBloc, ProfilState>(
                  builder: (context, state) {
                if (state is ProfilLoadedState) {
                  UserInformationDetail? _userInfoDetail =
                      state.userInformationDetail;
                  if (_userInfoDetail.role == 'Dosen') {
                    return BlocProvider(
                      create: (context) => di.locator<SelancarloggedinBloc>()
                        ..add(
                          SelancarGetProfileEvent(nidn: _userInfoDetail.nidn!),
                        ),
                      child: SelancarPAKLoggedInPage(
                        avatar: state.userAvatar,
                        userInfoDetail: _userInfoDetail,
                      ),
                    );
                  } else {
                    return SelancarPAKPage();
                  }
                } else {
                  return SelancarPAKPage();
                }
              }),
            ),
          );
          _notifikasiBloc
              .add(UpdateNotifikasiEvent(notification: notification));
        }
      },
    );
  }

  Widget _noNotif() {
    return SingleChildScrollView(
      physics: AlwaysScrollableScrollPhysics(),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/ilus_notification.png',
              width: 271.w,
              height: 194.w,
            ),
            SizedBox(height: 20.h),
            Text(
              'Tidak ada Notifikasi',
              style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.black),
            ),
            SizedBox(height: 8.h),
            Text(
              'Tarik ke bawah untuk segarkan notifikasi',
              style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: neutral80),
            ),
            Container(
              height: 160.h,
            )
          ],
        ),
      ),
    );
  }

  void onTapNewsPengumuman(notification) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return BeritaDanPengumumanSubPage(
            category:
                notification.topic == 'pengumuman' ? notification.category : '',
            id: int.parse(notification.notifId),
          );
        },
      ),
    );

    //this event already handle isRead = true
    _notifikasiBloc.add(UpdateNotifikasiEvent(notification: notification));
  }
}
