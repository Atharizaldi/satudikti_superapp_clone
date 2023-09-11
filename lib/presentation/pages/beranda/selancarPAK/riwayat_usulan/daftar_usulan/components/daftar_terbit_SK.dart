import 'package:app/common/dateFormat.dart';
import 'package:app/data/source/remote/model/selancar/usulan_detail.dart';
import 'package:app/data/source/remote/model/selancar/usulan_list.dart';
import 'package:app/presentation/component/constant.dart';
import 'package:app/presentation/component/customPercentIndicator.dart';
import 'package:app/presentation/component/inkEffect.dart';
import 'package:app/presentation/pages/beranda/selancarPAK/riwayat_usulan/daftar_usulan/components/empty_usulan.dart';
import 'package:app/presentation/pages/beranda/selancarPAK/riwayat_usulan/detail_usulan/detail_riwayat_usulan_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:truncate/truncate.dart';

Widget terbitSK(
  String nama,
  String nidn,
  List<Usulan> usulanList,
  List<UsulanDetail> usulanDetailList,
) {
  FormatDate formatDate = new FormatDate();

  // Codes to filter the tab's view
  List<num> usulanPercentages = [];

  for (int i = 0; i < usulanDetailList.length; i++) {
    usulanPercentages.add(usulanDetailList[i].progressPercentage);
  }

  if (usulanList.isEmpty || !usulanPercentages.contains(100)) {
    return usulanIsEmpty();
  }

  void _navigateToDetailRiwayat(
    BuildContext context,
    String nama,
    String nidn,
    Usulan last,
    UsulanDetail usulanDetail,
  ) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailRiwayatUsulanPage(
          nama: nama,
          nidn: nidn,
          usulanList: last,
          usulanDetail: usulanDetail,
        ),
      ),
    );
  }

  // Codes to show the usulan list
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 16.w),
    child: ListView.builder(
      shrinkWrap: true,
      itemCount: usulanList.length,
      itemBuilder: (context, index) {
        final Usulan data = usulanList[index];
        final UsulanDetail dataDetail = usulanDetailList[index];
        return Padding(
          padding: EdgeInsets.only(bottom: 20.h),
          child: Material(
            child: InkEffect(
              boxDecoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4.r),
                color: white,
                boxShadow: shadow1,
              ),
              onTap: () {
                _navigateToDetailRiwayat(
                  context,
                  nama,
                  nidn,
                  data,
                  dataDetail,
                );
              },
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 20.w,
                  vertical: 20.h,
                ),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SelectableText(
                          truncate(data.namaUsulan, 30),
                          onTap: () {
                            _navigateToDetailRiwayat(
                              context,
                              nama,
                              nidn,
                              data,
                              dataDetail,
                            );
                          },
                          enableInteractiveSelection: false,
                          //overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 14.sp,
                            color: blue4,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Container(
                          alignment: Alignment.center,
                          width: 56.w,
                          height: 21.h,
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            border: Border.all(color: green3),
                            borderRadius: BorderRadius.circular(4.r),
                          ),
                          child: SelectableText(
                            data.jenisPengajuan,
                            onTap: () {
                              _navigateToDetailRiwayat(
                                context,
                                nama,
                                nidn,
                                data,
                                dataDetail,
                              );
                            },
                            enableInteractiveSelection: false,
                            style: TextStyle(
                              color: green3,
                              fontSize: 10.sp,
                            ),
                          ),
                        ),
                        SizedBox(height: 16.h),
                        SelectableText(
                          data.nomorSurat,
                          onTap: () {
                            _navigateToDetailRiwayat(
                              context,
                              nama,
                              nidn,
                              data,
                              dataDetail,
                            );
                          },
                          enableInteractiveSelection: false,
                          style: TextStyle(
                            color: neutral50,
                            fontSize: 12.sp,
                          ),
                        ),
                        SizedBox(height: 4.h),
                        SelectableText(
                          'Tanggal ${formatDate.formatDate(data.tanggalSurat)}',
                          onTap: () {
                            _navigateToDetailRiwayat(
                              context,
                              nama,
                              nidn,
                              data,
                              dataDetail,
                            );
                          },
                          enableInteractiveSelection: false,
                          style: TextStyle(
                            color: neutral30,
                            fontSize: 12.sp,
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                    CustomPercentIndicator(
                      radius: 36,
                      containerHeight: 62,
                      containerWidth: 62,
                      lineWidth: 3,
                      fontSize: 14,
                      progressPercentage: dataDetail.progressPercentage,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    ),
  );
}
