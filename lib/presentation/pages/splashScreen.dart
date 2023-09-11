import 'package:app/presentation/component/constant.dart';
import 'package:app/presentation/component/noInternet.dart';
import 'package:app/presentation/pages/faq/bloc/faq/faqapi_bloc.dart';
import 'package:app/presentation/pages/mainPage.dart';
import 'package:app/presentation/pages/onboarding/onBoardingSatu.dart';
import 'package:app/presentation/pages/profil/bloc/profil_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:app/injection.dart' as di;
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: 800),
    vsync: this,
  );

  late final Animation<double> _animation = Tween(
    begin: 0.0,
    end: 1.0,
  ).animate(_controller);

  late SharedPreferences prefs;
  late bool direct;

  void getPrefs() async{
   prefs = await SharedPreferences.getInstance();
   direct = prefs.getBool("onBoarding") ?? true;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    getPrefs();
  }

  @override
  Widget build(BuildContext context) {
    _controller.forward();
    return BlocProvider(
      create: (context) => di.locator<FaqapiBloc>()..add(FetchFaqApi()),
      child: BlocBuilder<ProfilBloc, ProfilState>(
        builder: (context, state) {
          return BlocBuilder<FaqapiBloc, FaqapiState>(
            builder: (context, state) {
              if (state is FaqapiLoaded) {
                Future.delayed(
                    Duration(
                      milliseconds: 1000,
                    ), () {
                  Navigator.pushReplacement(
                      context,
                      PageRouteBuilder(
                        transitionDuration: Duration(
                          seconds: 1,
                        ),
                        pageBuilder: (context, animation, animationTime) {
                          return direct ? OnBoardingSatu(listFAQ: state.listFAQ) : MainPage(listFAQ: state.listFAQ, statusCode: 200);
                        },
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                          return FadeTransition(
                            opacity: animation,
                            child: child,
                          );
                        },
                      ));
                });
              } else if (state is FaqapiNoInternet) {
                return NoInternet(
                  onPressed: () {
                    Navigator.pushReplacement(context, MaterialPageRoute(
                      builder: (context) {
                        return SplashScreen();
                      },
                    ));
                  },
                  buttonHide: false,
                );
              }
              return Scaffold(
                body: Container(
                  width: screenWidth(context),
                  height: screenHeight(context),
                  decoration: BoxDecoration(gradient: splashGradient),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FadeTransition(
                        opacity: _animation,
                        child: Image.asset(
                          'assets/logo_satudikti.png',
                          height: 136.h,
                          width: 60.w,
                        ),
                      ),
                      SizedBox(height: 20.h),
                      FadeTransition(
                        opacity: _animation,
                        child: Image.asset(
                          'assets/logo_satudikti_carousel.png',
                          height: 34.h,
                          width: 147.w,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
