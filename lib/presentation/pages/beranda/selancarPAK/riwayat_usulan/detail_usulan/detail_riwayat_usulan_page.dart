import 'package:app/data/source/remote/model/selancar/usulan_detail.dart';
import 'package:app/data/source/remote/model/selancar/usulan_list.dart';
import 'package:app/presentation/component/constant.dart';
import 'package:app/presentation/component/customAppBar.dart';
import 'package:app/presentation/component/customPercentIndicator.dart';
import 'package:app/presentation/component/newBannerSubJudul.dart';
import 'package:app/presentation/pages/beranda/beasiswa/components/cardBeasiswa.dart';
import 'package:app/presentation/pages/beranda/ijazahln/component/reusableWidgets/rowResult.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:timeline_tile/timeline_tile.dart';

class DetailRiwayatUsulanPage extends StatelessWidget {
  final String nama;
  final String nidn;
  final Usulan usulanList;
  final UsulanDetail usulanDetail;
  final String statusPengajuan;
  const DetailRiwayatUsulanPage({
    Key? key,
    required this.nama,
    required this.nidn,
    required this.usulanList,
    required this.usulanDetail,
    this.statusPengajuan = '',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Detail Riwayat Usulan'),
      body: SingleChildScrollView(
          child: Container(
        color: whiteBgPage,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 30.h),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 30.h),
                decoration: BoxDecoration(
                  boxShadow: shadow1,
                  borderRadius: BorderRadius.circular(8.r),
                  color: white,
                ),
                child: Column(
                  children: [
                    RowResult(
                      keterangan: "Nama",
                      widgetHasil: SelectableText(
                        nama,
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.08.sp,
                        ),
                      ),
                    ),
                    SizedBox(height: 30.h),
                    RowResult(
                      keterangan: "NIDN",
                      hasil: nidn,
                    ),
                    SizedBox(height: 30.h),
                    RowResult(
                      keterangan: "Jabatan yang Diajukan",
                      widgetHasil: SelectableText(
                        usulanList.namaUsulan,
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.08.sp,
                        ),
                      ),
                    ),
                    SizedBox(height: 30.h),
                    RowResult(
                      keterangan: "Jenis Pengajuan",
                      widgetHasil: Container(
                        alignment: Alignment.center,
                        width: 56.w,
                        height: 21.h,
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          border: Border.all(color: green3),
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                        child: SelectableText(
                          usulanList.jenisPengajuan,
                          enableInteractiveSelection: false,
                          style: TextStyle(
                            color: green3,
                            fontSize: 10.sp,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 30.h),
                    RowResult(
                      keterangan: "Tanggal Pengajuan",
                      hasil: formatDate.formatDate(usulanList.tanggalSurat),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 48.h),
              NewBannerSubJudul(
                subJudul: 'Status Pengajuan',
                subJudul2: 'Progress yang diajukan',
              ),
              SizedBox(height: 20.h),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                decoration: BoxDecoration(
                  color: white,
                  boxShadow: shadow1,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20.w,
                        vertical: 20.h,
                      ),
                      decoration: BoxDecoration(
                        color: usulanDetail.detailUsulan.last.kelas == 'danger'
                            ? red4
                            : green6,
                        // color:
                        //     usulanDetail.detailUsulan.last.kelas == 'danger'
                        //         ? null
                        //         : green6,
                        boxShadow: shadow1,
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                      child: Row(
                        children: [
                          CustomPercentIndicator(
                            radius: 40,
                            containerWidth: 70,
                            containerHeight: 70,
                            image: statusIcons(
                              usulanDetail.detailUsulan.last.judul,
                            ),
                            containerColor:
                                usulanDetail.detailUsulan.last.kelas == 'danger'
                                    ? red
                                    : green3,
                            progressColor:
                                usulanDetail.detailUsulan.last.kelas == 'danger'
                                    ? red
                                    : green3,
                            progressPercentage: usulanDetail.progressPercentage,
                          ),
                          SizedBox(width: 24.w),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                usulanDetail.detailUsulan.last.kelas == 'danger'
                                    ? 'Pengajuan Ditolak'
                                    : '${usulanDetail.progressPercentage}%',
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w700,
                                  color: usulanDetail.detailUsulan.last.kelas ==
                                          'danger'
                                      ? red3
                                      : green3,
                                ),
                              ),
                              SizedBox(height: 4.h),
                              Text(
                                usulanDetail.detailUsulan.last.kelas == 'danger'
                                    ? 'Silahkan Perbaiki Berkas \nPengajuan Anda'
                                    : 'Presentase progress \npengajuanmu',
                                style: TextStyle(
                                  color: neutral70,
                                  fontSize: 14.sp,
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 30.h),
                    ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: usulanDetail.detailUsulan.length,
                      itemBuilder: (context, index) {
                        var idx = usulanDetail.detailUsulan.length - index;
                        var awal = usulanDetail.detailUsulan.length - 1;
                        return _tlTile(
                          usulanDetail.detailUsulan[idx - 1].tanggal,
                          usulanDetail.detailUsulan[idx - 1].tanggal,
                          (idx).toString(),
                          usulanDetail.detailUsulan[idx - 1].judul,
                          usulanDetail.detailUsulan[idx - 1].deskripsi,
                          statusPengajuan,
                          idx == usulanDetail.detailUsulan.length
                              ? blueLinear1
                              : abu2,
                          idx == usulanDetail.detailUsulan.length
                              ? blueLinear1
                              : abu2,
                          idx == 1 ? true : false,
                          idx - 1 == awal ? true : false,
                          idx,
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }

  TimelineTile _tlTile(
      String tanggal,
      jam,
      step,
      namaProgres,
      detailProgres,
      statusPengajuan,
      warnaIndikator,
      warnaGaris,
      bool akhir,
      bool awal,
      int index) {
    return TimelineTile(
      alignment: TimelineAlign.manual,
      lineXY: 0.3,
      startChild: Padding(
        padding: EdgeInsets.only(left: 4.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${tanggal.split(' ')[0]} ${tanggal.split(' ')[1]} ${tanggal.split(' ')[2]}',
              style: TextStyle(
                fontSize: 9.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              'Jam ${jam.split(' ').last.split(':')[0]}.${jam.split(' ').last.split(':')[1]}',
              style: TextStyle(
                fontSize: 8.5.sp,
                fontWeight: FontWeight.w400,
              ),
            )
          ],
        ),
      ),
      endChild: Container(
        padding: EdgeInsets.only(left: 8.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              child: Text(
                namaProgres,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w700,
                  color: awal
                      ? usulanDetail.detailUsulan.last.kelas == 'danger'
                          ? red
                          : warnaIndikator
                      : neutralCaption,
                ),
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              detailProgres,
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
                color: awal ? neutral100 : neutral50,
              ),
            ),
            SizedBox(height: 28.h)
          ],
        ),
      ),
      isLast: akhir,
      isFirst: awal,
      indicatorStyle: IndicatorStyle(
        indicator: Container(
          width: 32.r,
          height: 32.r,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: usulanDetail.detailUsulan.last.kelas == 'danger'
                ? awal
                    ? red
                    : warnaIndikator
                : warnaIndikator,
          ),
          child: Text(
            index.toString(),
            style: TextStyle(fontSize: 16.sp, color: white),
          ),
        ),
        indicatorXY: 0,
        width: 32.r,
        height: 32.r,
      ),
      afterLineStyle: LineStyle(
        color: awal
            ? usulanDetail.detailUsulan.last.kelas == 'danger'
                ? red
                : warnaGaris
            : abu2,
      ),
    );
  }

  String statusIcons(namaProgres) {
    switch (namaProgres) {
      case 'Berkas Dikirim':
        return 'assets/selancar/icons/berkas_dikirim.png';

      case 'Usulan Telah Diinput':
        return 'assets/selancar/icons/usulan_telah_diinput.png';

      case 'Usulan Diajukan':
        return 'assets/selancar/icons/usulan_diajukan.png';

      case 'Verifikasi Administrasi':
        return 'assets/selancar/icons/verifikasi_administrasi.png';

      case 'Proses Penilaian':
        return 'assets/selancar/icons/proses_penilaian.png';

      case 'Penjadwalan Penilaian':
        return 'assets/selancar/icons/penjadwalan_penilaian.png';

      case 'Proses Validasi':
        return 'assets/selancar/icons/proses_validasi.png';

      case 'Terbit PAK':
        return 'assets/selancar/icons/terbit_PAK.png';

      default:
        return 'assets/selancar/icons/icon_default.png';
    }
  }
}
