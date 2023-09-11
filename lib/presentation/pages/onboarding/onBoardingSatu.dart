import 'package:app/presentation/pages/mainPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import './component/onboarding_contents.dart';
import '../../../data/source/remote/model/faq/faqList.dart';
import '../../component/constant.dart';
import '../../component/inkEffect.dart';
// import 'onBoardingDua.dart';

class OnBoardingSatu extends StatefulWidget {
  final FAQList listFAQ;

  const OnBoardingSatu({Key? key, required this.listFAQ}) : super(key: key);

  @override
  State<OnBoardingSatu> createState() => _OnBoardingSatuState();
}

class _OnBoardingSatuState extends State<OnBoardingSatu> {
  late PageController _controller;
  int _currentPage = 0;

  @override
  void initState() {
    _controller = PageController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: PageView.builder(
                physics: const BouncingScrollPhysics(),
                controller: _controller,
                onPageChanged: (value) => setState(() => _currentPage = value),
                itemCount: contents.length,
                itemBuilder: (context, i) {
                  return Padding(
                    padding: EdgeInsets.fromLTRB(20, 60, 20, 20),
                    child: Column(
                      children: [
                        Image.asset(
                          contents[i].image,
                          width: 350.w,
                          height: 350.h,
                        ),
                        SizedBox(height: 24.h),
                        Text(
                          contents[i].title,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20.sp,
                            letterSpacing: -0.017,
                            height: 1.5,
                            fontWeight: FontWeight.w700,
                            color: blue3,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        SizedBox(
                          width: 320.w,
                          child: Text(
                            contents[i].description,
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 14.sp,
                              height: 1.7,
                              letterSpacing: -0.006,
                              color: neutral70,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  sliderIndicator(),
                  _currentPage + 1 == contents.length
                      ? Padding(
                          padding: EdgeInsets.all(16),
                          child: InkEffect(
                            boxDecoration: BoxDecoration(
                              // border: Border.all(color: red),
                              gradient: appBarGradient,
                              borderRadius: BorderRadius.circular(5.r),
                            ),
                            onTap: () {
                              Navigator.pushReplacement(
                                  context,
                                  PageRouteBuilder(
                                    transitionDuration: Duration(
                                      seconds: 1,
                                    ),
                                    pageBuilder:
                                        (context, animation, animationTime) {
                                      return MainPage(
                                        listFAQ: widget.listFAQ,
                                        statusCode: 200,
                                      );
                                    },
                                    transitionsBuilder: (context, animation,
                                        secondaryAnimation, child) {
                                      return FadeTransition(
                                        opacity: animation,
                                        child: child,
                                      );
                                    },
                                  ));
                            },
                            child: Container(
                              padding: EdgeInsets.only(
                                  top: 8.h,
                                  bottom: 8.h,
                                  left: 16.w,
                                  right: 16.w),
                              width: 358.w,
                              height: 48.h,
                              child: Center(
                                child: Text(
                                  "Mulai Jelajah",
                                  style: TextStyle(
                                    color: white,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: -0.011,
                                  ),
                                ),
                              ),
                            ),
                          ))
                      : Padding(
                          padding: EdgeInsets.all(16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushReplacement(
                                      context,
                                      PageRouteBuilder(
                                        transitionDuration: Duration(
                                          seconds: 1,
                                        ),
                                        pageBuilder: (context, animation,
                                            animationTime) {
                                          return MainPage(
                                            listFAQ: widget.listFAQ,
                                            statusCode: 200,
                                          );
                                        },
                                        transitionsBuilder: (context, animation,
                                            secondaryAnimation, child) {
                                          return FadeTransition(
                                            opacity: animation,
                                            child: child,
                                          );
                                        },
                                      ));
                                },
                                child: Text(
                                  'Skip',
                                  style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w700,
                                      color: neutral30,
                                      letterSpacing: -0.006),
                                ),
                              ),
                              Spacer(),
                              CircularPercentIndicator(
                                radius: 27,
                                backgroundWidth: 0,
                                lineWidth: 2.5,
                                percent: _currentPage == 1 ? 1 : 0.5,
                                progressColor: blueLinear1,
                                center: ElevatedButton(
                                  onPressed: () async {
                                    final prefs =
                                        await SharedPreferences.getInstance();
                                    setState(() {
                                      _controller.nextPage(
                                        duration:
                                            const Duration(milliseconds: 200),
                                        curve: Curves.easeIn,
                                      );
                                      prefs.setBool("onBoarding", false);
                                    });
                                  },
                                  style: ElevatedButton.styleFrom(
                                      padding: EdgeInsets.zero,
                                      shape: CircleBorder()),
                                  child: Ink(
                                    decoration: BoxDecoration(
                                        gradient: appBarGradient,
                                        shape: BoxShape.circle),
                                    child: Container(
                                      width: 44.w,
                                      height: 44.h,
                                      alignment: Alignment.center,
                                      child: Icon(
                                        Icons.arrow_forward,
                                        color: white,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget sliderIndicator() => AnimatedSmoothIndicator(
      activeIndex: _currentPage,
      count: 3,
      effect: ExpandingDotsEffect(
        spacing: 16.0,
        radius: 100.0,
        dotWidth: 8.0,
        dotHeight: 8.0,
        strokeWidth: 1.5,
        dotColor: neutral40,
        activeDotColor: blue3,
      ));
}
