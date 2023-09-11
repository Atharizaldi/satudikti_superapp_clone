import 'package:app/data/source/remote/model/berita/newsList.dart';
import 'package:app/data/source/remote/model/pengumuman/pengumumanList.dart';
import 'package:app/presentation/component/constant.dart';
import 'package:app/presentation/pages/beranda/beritaDanPengumumanDetail/beritaDanPengumumanSubPage.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../showWebsite.dart';
import 'carouselSlides.dart';

class BannerBeritaPengumuman extends StatefulWidget {
  final NewsList recentNewsList;
  final PengumumanList recentPengumumanList;

  const BannerBeritaPengumuman({
    Key? key,
    required this.recentNewsList,
    required this.recentPengumumanList,
  }) : super(key: key);

  @override
  _BannerBeritaPengumumanState createState() => _BannerBeritaPengumumanState();
}

class _BannerBeritaPengumumanState extends State<BannerBeritaPengumuman> {
  int sliderBeritaIndex = 0;

  @override
  Widget build(BuildContext context) {
    if (sliderBeritaIndex == 0) {
      return GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ShowWebsite(
                    link: 'http://satudikti.id/',
                  ),
                ));
          },
          child: Container(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: 18.h),
                  child: Column(
                    children: [
                      CarouselSlider.builder(
                        itemCount: 5,
                        itemBuilder: (context, index, realIndex) {
                          return carouselSlideFirst(context);
                        },
                        options: CarouselOptions(
                          height: 185.h,
                          onPageChanged: ((index, reason) {
                            setState(() {
                              sliderBeritaIndex = index;
                            });
                          }),
                          autoPlayCurve: Curves.easeInOutCubic,
                          autoPlay: true,
                          autoPlayAnimationDuration:
                              Duration(milliseconds: 700),
                          enlargeCenterPage: true,
                          viewportFraction: 1,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.001),
                sliderIndicator()
              ],
            ),
          ));
    } else if (sliderBeritaIndex % 2 == 1) {
      return GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BeritaDanPengumumanSubPage(
                      category: '',
                      id: widget.recentNewsList.data[sliderBeritaIndex].newsId),
                ));
          },
          child: Container(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: 18.h),
                  child: Column(
                    children: [
                      CarouselSlider.builder(
                        itemCount: 5,
                        itemBuilder: (context, index, realIndex) {
                          return itemBannerBerita(
                            context,
                            index,
                            widget.recentNewsList,
                          );
                        },
                        options: CarouselOptions(
                          height: 185.h,
                          onPageChanged: ((index, reason) {
                            setState(() {
                              sliderBeritaIndex = index;
                            });
                          }),
                          autoPlayCurve: Curves.easeInOutCubic,
                          autoPlay: true,
                          autoPlayAnimationDuration:
                              Duration(milliseconds: 700),
                          enlargeCenterPage: true,
                          viewportFraction: 1,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.001),
                sliderIndicator()
              ],
            ),
          ));
    } else {
      return GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BeritaDanPengumumanSubPage(
                      category: widget.recentPengumumanList
                          .data[sliderBeritaIndex].categories[0].categoryName,
                      id: widget
                          .recentPengumumanList.data[sliderBeritaIndex].id),
                ));
          },
          child: Container(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: 18.h),
                  child: Column(
                    children: [
                      CarouselSlider.builder(
                        itemCount: 5,
                        itemBuilder: (context, index, realIndex) {
                          return itemBannerPengumuman(
                            context,
                            index,
                            widget.recentPengumumanList,
                          );
                        },
                        options: CarouselOptions(
                          height: 185.h,
                          onPageChanged: ((index, reason) {
                            setState(() {
                              sliderBeritaIndex = index;
                            });
                          }),
                          autoPlayCurve: Curves.easeInOutCubic,
                          autoPlay: true,
                          autoPlayAnimationDuration:
                              Duration(milliseconds: 700),
                          enlargeCenterPage: true,
                          viewportFraction: 1,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.001),
                sliderIndicator()
              ],
            ),
          ));
    }
  }

  Widget itemBannerPengumuman(BuildContext context, index, PengumumanList res) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  'assets/default-con/bannerPengumumanNew.png',
                ),
                fit: BoxFit.cover),
            borderRadius: BorderRadius.all(Radius.circular(5.r)),
          ),
        ),
        Align(
          alignment: Alignment.topLeft,
          child: Container(
            width: 180.w,
            height: 300.h,
            child: Padding(
              padding: EdgeInsets.only(left: 12.w, right: 20.w, top: 50.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.r),
                      color: Color(0xCC248DDA),
                    ),
                    child: Text(
                      'Pengumuman',
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                        color: white,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Expanded(
                    child: Text(
                      widget.recentPengumumanList.data[sliderBeritaIndex].title,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: white,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold,
                        height: 1.65,
                      ),
                      maxLines: 4,
                    ),
                  ),
                  SizedBox(
                    height: 6,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget itemBannerBerita(BuildContext context, index, NewsList res) {
    String image = res.data[index].thumbnailImage;
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/default-con/bannerBeritaNew.png'),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.all(Radius.circular(5.r)),
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: Container(
            width: 177.w,
            // height: 200.h,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: image == 'null'
                      ? AssetImage("assets/default-con/berita_slider.png")
                          as ImageProvider
                      : NetworkImage(image),
                  fit: BoxFit.cover),
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(5.r),
                  bottomRight: Radius.circular(5.r)),
            ),
          ),
        ),
        Align(
          alignment: Alignment.topLeft,
          child: Container(
            width: 180.w,
            height: 300.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10.r),
                  bottomRight: Radius.circular(10.r)),
            ),
            child: Padding(
              padding: EdgeInsets.only(left: 12.w, right: 20.w, top: 50.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.r),
                      color: Color(0xCC248DDA),
                    ),
                    child: Text(
                      'News',
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                        color: white,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Text(
                    widget.recentNewsList.data[sliderBeritaIndex].title,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: white,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold,
                      height: 1.65,
                    ),
                    maxLines: 4,
                  ),
                  SizedBox(
                    height: 6,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget sliderIndicator() => AnimatedSmoothIndicator(
      activeIndex: sliderBeritaIndex,
      // duration: Duration(milliseconds: 500),
      count: 5,
      effect: WormEffect(
        type: WormType.normal,
        spacing: 8.0,
        radius: 100.0,
        dotWidth: 20.0,
        dotHeight: 6.0,
        strokeWidth: 1.5,
        dotColor: Colors.indigo,
        activeDotColor: neutral10,
      ));
}
