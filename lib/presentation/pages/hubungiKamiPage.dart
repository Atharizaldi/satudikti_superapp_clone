import 'package:app/common/launchUrl.dart';
import 'package:app/presentation/component/constant.dart';
import 'package:app/presentation/component/customAppBar.dart';
import 'package:app/presentation/component/mainPage/containerKontak.dart';
import 'package:app/presentation/component/mainPage/containerWebDikti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:maps_launcher/maps_launcher.dart';

class HubungiKamiPage extends StatefulWidget {
  const HubungiKamiPage({Key? key}) : super(key: key);

  @override
  _HubungiKamiPageState createState() => _HubungiKamiPageState();
}

class _HubungiKamiPageState extends State<HubungiKamiPage> {
  String urlFacebook = 'https://m.facebook.com/ditjen.dikti/';
  String urlTwitter = 'https://twitter.com/ditjendikti?s=21';
  String urlInstagram = 'https://www.instagram.com/ditjen.dikti/';
  String urlYoutube =
      'https://www.youtube.com/c/DitjenDiktiSIGAPMelayani/featured';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteBgPage,
      appBar: CustomAppBar(title: "Hubungi Kami"),
      body: SingleChildScrollView(
        child: Container(
          color: whiteBgPage,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                  top: 30.h,
                  left: 24.w,
                  right: 24.w,
                ),
                child: containerWebDikti(context),
              ),
              containerKontak(
                icon: 'assets/hubungiKami/phone.png',
                judul: "Telepon",
                deskripsi: "(021) 57946104\n(Pusat Panggilan ULT DIKTI 126)",
                function: () {
                  launchURLHK('tel:02157946104');
                },
              ),
              containerKontak(
                icon: 'assets/hubungiKami/mail.png',
                judul: 'Email',
                deskripsi: "sekretariat.dikti@kemdikbud.go.id",
                function: () {
                  launchURLHK('mailto:sekretariat.dikti@kemdikbud.go.id');
                },
              ),
              containerKontak(
                icon: 'assets/hubungiKami/lokasi.png',
                judul: "Alamat",
                deskripsi:
                    'Gedung D, Jl. Jenderal Sudirman, \nPintu 1 Senayan, Jakarta Pusat. \n10270',
                function: () {
                  MapsLauncher.launchQuery(
                    'Direktorat Jenderal Pendidikan Tinggi',
                  );
                },
              ),
              SizedBox(height: 59.h),
              Center(
                child: Text(
                  'Ikuti Media Sosial Ditjen Diktiristek',
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff858585),
                  ),
                ),
              ),
              SizedBox(height: 16.h),
              Center(
                child: Container(
                  width: 172.w,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () => launchURLHK(urlFacebook),
                        child: Image.asset(
                          'assets/hubungiKami/fb.png',
                          width: 28.w,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => launchURLHK(urlTwitter),
                        child: Image.asset(
                          'assets/hubungiKami/twitter.png',
                          width: 28.w,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => launchURLHK(urlInstagram),
                        child: Image.asset(
                          'assets/hubungiKami/ig.png',
                          width: 28.w,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => launchURLHK(urlYoutube),
                        child: Image.asset(
                          'assets/hubungiKami/youtube.png',
                          width: 28.w,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 50.h),
            ],
          ),
        ),
      ),
    );
  }
}
