import 'package:app/presentation/component/constant.dart';
import 'package:app/presentation/pages/profil/notification/bloc/notification_settings_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotificationSettings extends StatelessWidget {
  const NotificationSettings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteBgPage,
      appBar: _appBar(),
      body: _body(context),
    );
  }

  AppBar _appBar() {
    return AppBar(
      title: Text(
        'Notifikasi',
        style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20.sp),
      ),
      flexibleSpace: Container(
          decoration: BoxDecoration(
        gradient: appBarGradient,
      )),
      centerTitle: true,
      elevation: 0,
    );
  }

  Widget _body(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 30.h, horizontal: 16.w),
      child: BlocBuilder<NotificationSettingsBloc, NotificationSettingsState>(
        builder: (context, state) {
          if (state is NotificationSwitchsState) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _cardBerita(context, 0, "Notifikasi Berita", state.berita),
                _cardPengumuman(
                    context, 12.h, "Notifikasi Pengumuman", state.pengumuman),
              ],
            );
          }
          return Container();
        },
      ),
    );
  }

  Widget _cardBerita(
      BuildContext context, double marginTop, String title, bool value) {
    return Card(
      margin: EdgeInsets.only(top: marginTop),
      color: white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 16.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
                flex: 1,
                child: Text(
                  title,
                  style: TextStyle(
                      color: neutral70,
                      fontWeight: FontWeight.w400,
                      fontSize: 14.sp),
                )),
            Container(
              width: 40.w,
              height: 20.w,
              child: Switch.adaptive(
                  value: value,
                  inactiveTrackColor: Color(0xffe4ebf6),
                  onChanged: (value) {
                    BlocProvider.of<NotificationSettingsBloc>(context)
                      ..add(UpdateSettingEvent(isBerita: true, value: value));
                  }),
            )
          ],
        ),
      ),
    );
  }

  Widget _cardPengumuman(
      BuildContext context, double marginTop, String title, bool value) {
    return Card(
      margin: EdgeInsets.only(top: marginTop),
      color: white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 16.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
                flex: 1,
                child: Text(
                  title,
                  style: TextStyle(
                      color: neutral70,
                      fontWeight: FontWeight.w400,
                      fontSize: 14.sp),
                )),
            Container(
              width: 40.w,
              height: 20.w,
              child: Switch.adaptive(
                  value: value,
                  inactiveTrackColor: Color(0xffe4ebf6),
                  onChanged: (value) {
                    BlocProvider.of<NotificationSettingsBloc>(context)
                      ..add(UpdateSettingEvent(isBerita: false, value: value));
                  }),
            )
          ],
        ),
      ),
    );
  }
}
