import 'package:app/common/dateFormat.dart';
import 'package:app/data/source/remote/model/berita/newsList.dart';
import 'package:app/presentation/component/constant.dart';
import 'package:app/presentation/pages/beranda/beritaDanPengumumanDetail/beritaDanPengumumanSubPage.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BannerBerita extends StatefulWidget {
  final NewsList recentNewsList;

  const BannerBerita({Key? key, required this.recentNewsList})
      : super(key: key);

  @override
  _BannerBeritaState createState() => _BannerBeritaState();
}

class _BannerBeritaState extends State<BannerBerita> {
  int sliderBeritaIndex = 0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => BeritaDanPengumumanSubPage(
                      category: '',
                      id: widget
                          .recentNewsList.data[sliderBeritaIndex].newsId)));
        },
        child: Padding(
          padding: EdgeInsets.only(left: 16.w, right: 16.w),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: 18.h),
                child: Column(
                  children: [
                    CarouselSlider.builder(
                      itemCount: 3,
                      itemBuilder: (context, index, realIndex) {
                        return itemBanner(
                          context,
                          index,
                          widget.recentNewsList,
                        );
                      },
                      options: CarouselOptions(
                        onPageChanged: ((index, reason) {
                          setState(() {
                            sliderBeritaIndex = index;
                          });
                        }),
                        autoPlay: true,
                        enlargeCenterPage: true,
                        viewportFraction: 1,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.h),
              sliderIndicator()
            ],
          ),
        ));
  }

  Widget itemBanner(BuildContext context, index, NewsList res) {
    FormatDate formatDate = new FormatDate();
    String image = res.data[index].thumbnailImage;
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: image == 'null'
                  ? AssetImage("assets/default-con/berita_slider.png")
                      as ImageProvider
                  : NetworkImage(
                      image,
                    ),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.all(Radius.circular(10.r)),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            width: double.infinity,
            height: 95.h,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: <Color>[
                  Color(0x00000000),
                  Color(0x33000000),
                  Color(0x80000000),
                  Color(0xff000000),
                ],
              ),
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10.r),
                  bottomRight: Radius.circular(10.r)),
            ),
            child: Padding(
              padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 1.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _tag(
                    formatDate.formatDate(widget
                        .recentNewsList.data[sliderBeritaIndex].publisherDate),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Text(
                    widget.recentNewsList.data[sliderBeritaIndex].title,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        height: 1.65),
                    maxLines: 2,
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

  Widget _tag(String tanggal) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.r),
        color: Color(0xCC248DDA),
      ),
      child: Text(
        tanggal,
        style: TextStyle(
          fontSize: 12.sp,
          fontWeight: FontWeight.w500,
          color: white,
        ),
      ),
    );
  }

  Widget sliderIndicator() => AnimatedSmoothIndicator(
        activeIndex: sliderBeritaIndex,
        count: 3,
        effect: WormEffect(
          type: WormType.normal,
          spacing: 8.0,
          radius: 100.0,
          dotWidth: 24.0,
          dotHeight: 6.0,
          strokeWidth: 1.5,
          dotColor: neutral10,
          activeDotColor: Colors.indigo,
        ),
      );
}
