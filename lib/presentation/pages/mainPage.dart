import 'package:app/data/source/remote/model/faq/faqList.dart';
import 'package:app/presentation/component/constant.dart';
import 'package:app/presentation/pages/beranda/beranda/berandaPage.dart';
import 'package:app/presentation/pages/faq/faqPage.dart';
import 'package:app/presentation/pages/notifikasi/notifikasiPage.dart';
import 'package:app/presentation/pages/profil/profilPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_version/new_version.dart';

class MainPage extends StatefulWidget {
  final FAQList listFAQ;
  final int statusCode;
  const MainPage({Key? key, required this.listFAQ, required this.statusCode})
      : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

//Class enum sebagai penampung variabel tiap subPage NavBar
enum NavBarMenu { Beranda, FAQ, Notifikasi }

class _MainPageState extends State<MainPage> {
  //Variabel untuk manmpung nilai enum (status subpage)
  NavBarMenu navBarMenu = NavBarMenu.Beranda;

  PageController pageController = PageController(initialPage: 0);
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _checkVersion(context);
    return SafeArea(
      top: false,
      bottom: false,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(
          children: [
            Flexible(
              flex: 9,
              child: Container(
                width: double.infinity,
                child: PageView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  controller: pageController,
                  itemCount: 4,
                  onPageChanged: (index) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                  itemBuilder: (context, index) {
                    return _switchPage(
                      index,
                      widget.listFAQ,
                    );
                  },
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: _currentIndex,
          elevation: 25,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          unselectedLabelStyle: TextStyle(
            color: neutral40,
            fontSize: 12.sp,
            fontWeight: FontWeight.w700,
          ),
          selectedLabelStyle: TextStyle(
            color: blue2,
            fontSize: 12.sp,
            fontWeight: FontWeight.w700,
          ),
          unselectedItemColor: neutral40,
          selectedItemColor: blue2,
          iconSize: 24.r,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
              pageController.animateToPage(
                index,
                duration: Duration(milliseconds: 200),
                curve: Curves.ease,
              );
            });
          },
          items: [
            BottomNavigationBarItem(
              activeIcon: Padding(
                padding: EdgeInsets.only(bottom: 4.h),
                child: ImageIcon(AssetImage("assets/icons/home_active.png")),
              ),
              icon: Padding(
                padding: EdgeInsets.only(bottom: 4.h),
                child: ImageIcon(AssetImage("assets/icons/home_inactive.png")),
              ),
              label: "Beranda",
            ),
            BottomNavigationBarItem(
              activeIcon: Padding(
                padding: EdgeInsets.only(bottom: 4.h),
                child: ImageIcon(AssetImage("assets/icons/FAQ_active.png")),
              ),
              icon: Padding(
                padding: EdgeInsets.only(bottom: 4.h),
                child: ImageIcon(AssetImage("assets/icons/FAQ_inactive.png")),
              ),
              label: "FAQ",
            ),
            BottomNavigationBarItem(
              activeIcon: Padding(
                padding: EdgeInsets.only(bottom: 4.h),
                child: ImageIcon(AssetImage("assets/icons/notif_active.png")),
              ),
              icon: Padding(
                padding: EdgeInsets.only(bottom: 4.h),
                child: ImageIcon(AssetImage("assets/icons/notif_inactive.png")),
              ),
              label: "Notifikasi",
            ),
            BottomNavigationBarItem(
              activeIcon: Padding(
                padding: EdgeInsets.only(bottom: 4.h),
                child: ImageIcon(AssetImage("assets/icons/profil_active.png")),
              ),
              icon: Padding(
                padding: EdgeInsets.only(bottom: 4.h),
                child:
                    ImageIcon(AssetImage("assets/icons/profil_inactive.png")),
              ),
              label: "Profil",
            ),
          ],
        ),
      ),
    );
  }
}

void _checkVersion(BuildContext context) async {
  bool isShown = false;

  // Initiate new_version package
  final newVersion = NewVersion(
    androidId: 'id.satudikti.app',
    iOSId: 'id.satudikti.app',
    iOSAppStoreCountry: 'ID',
  );

  print("CEK");
  // Getting version status and infos in the store
  final status = await newVersion.getVersionStatus();
  print("ini setatus $status");

  // Would show dialog if the store version
  // is newer than local
  if (status!.canUpdate) {
    if (!isShown) {
      isShown = true;
      newVersion.showUpdateDialog(
        allowDismissal: false,
        context: context,
        versionStatus: status,
        dialogTitle: 'Pembaruan Tersedia',
        dialogText:
            'Aplikasi versi ${status.storeVersion} telah tersedia. Silakan perbarui aplikasi ke versi terbaru. \n\n(Versi aplikasi sekarang: ${status.localVersion})',
        updateButtonText: 'Perbarui',
        dismissButtonText: 'Nanti saja',
      );
    }
  }
}

dynamic _switchPage(int index, FAQList listFAQ) {
  switch (index) {
    case 0:
      return BerandaPage();
    case 1:
      return FAQPage(listFAQ: listFAQ);
    case 2:
      return NotifikasiPage();
    case 3:
      return ProfilPage();
    default:
  }
}
