import 'package:app/common/launchUrl.dart';
import 'package:app/presentation/component/bannerSubJudul.dart';
import 'package:app/presentation/component/constant.dart';
import 'package:app/presentation/component/mainPage/containerKontak.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ContactPddikti extends StatelessWidget {
  final String jalan;
  final String telepon;
  final String faksimile;
  final String email;
  final String website;
  const ContactPddikti({
    Key? key,
    required this.jalan,
    required this.telepon,
    required this.faksimile,
    required this.email,
    required this.website,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        (jalan.isNotEmpty ||
                telepon.isNotEmpty ||
                faksimile.isNotEmpty ||
                website.isNotEmpty)
            ? BannerSubJudul(
                subJudul: 'Kontak',
                warna: blue3,
                edgeInsets: EdgeInsets.zero,
                fontWeight: FontWeight.w700,
              )
            : SizedBox(),
        SizedBox(
          height: 20.h,
        ),
        ...containerContact(
          'assets/hubungiKami/lokasi.png',
          "Alamat",
          jalan,
          () {},
        ),
        ...containerContact(
          'assets/hubungiKami/phone.png',
          "Phone",
          telepon,
          () {
            launchURL('tel:$telepon');
          },
        ),
        ...containerContact(
          'assets/hubungiKami/faximile.png',
          'Faximile',
          faksimile,
          () {
            launchURL(faksimile);
          },
        ),
        ...containerContact(
          'assets/hubungiKami/mail.png',
          'Email',
          email,
          () {
            launchURL('mailto:$email');
          },
        ),
        ...containerContact(
          'assets/hubungiKami/website.png',
          'Website',
          website,
          () {},
        ),
        SizedBox(
          height: 60.h,
        ),
      ],
    );
  }

  List<Widget> containerContact(String icon, String judul, String deskripsi,
      [VoidCallback? function]) {
    return deskripsi.isNotEmpty
        ? [
            containerKontak(
              icon: icon,
              judul: judul,
              deskripsi: deskripsi,
              function: function,
              margin: EdgeInsets.zero,
            ),
            SizedBox(
              height: 20.h,
            ),
          ]
        : [SizedBox()];
  }
}
