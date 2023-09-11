import 'package:app/common/dateFormat.dart';
import 'package:app/injection.dart' as di;
import 'package:app/presentation/component/constant.dart';
import 'package:app/presentation/component/customAppBar.dart';
import 'package:app/presentation/component/noInternet.dart';
import 'package:app/presentation/component/server_problem.dart';
import 'package:app/presentation/pages/beranda/sister/biodata/bloc/biodata_sister_bloc.dart';
import 'package:app/presentation/pages/beranda/sister/component/empty_data.dart';
import 'package:app/presentation/pages/beranda/sister/component/skeleton_loading_sister_tabbar.dart';
import 'package:app/presentation/pages/beranda/sister/component/tabbar_scroll.dart';
import 'package:app/presentation/pages/beranda/sister/component/tabbarviewsister.dart';
import 'package:app/presentation/pages/faq/bloc/faq_module/faqmodule_bloc.dart';
import 'package:app/presentation/pages/faq/faq_page_per_module.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Biodata extends StatefulWidget {
  const Biodata({Key? key}) : super(key: key);

  @override
  State<Biodata> createState() => _BiodataState();
}

class _BiodataState extends State<Biodata> {
  late BiodataSisterBloc _biodataSisterBloc;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BiodataSisterBloc, BiodataSisterState>(
        listener: (context, state) {
      _biodataSisterBloc = BlocProvider.of<BiodataSisterBloc>(context);
      if (state is BiodataSisterNoInternetState) {
        ScaffoldMessenger.of(context).showSnackBar(noInternet);
      }
    }, builder: (context, state) {
      if (state is BiodataSisterNoInternetState) {
        return _biodataWidgetState(context, state, state.nidn);
      } else if (state is BiodataSisterErrorState) {
        return _biodataWidgetState(context, state, state.nidn);
      } else if (state is BiodataSisterLoadedState) {
        return _biodataWidgetState(context, state, state.nidn);
      } else {
        return _biodataWidgetState(context, state, '');
      }
    });

    // return _biodataWidgetState(context);
  }

  Widget _biodataWidgetState(
      BuildContext context, BiodataSisterState state, String nidn) {
    return Scaffold(
        backgroundColor: Color(0xFFF9FAFE),
        appBar: CustomAppBar(
          actions: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return BlocProvider(
                        create: (context) => di.locator<FaqmoduleBloc>()
                          ..add(FetchfaqModuleEvent('sister')),
                        child: FAQModul(),
                      );
                    },
                  ),
                );
              },
              child: Padding(
                padding: EdgeInsets.only(right: 16.w),
                child: ImageIcon(
                  AssetImage("assets/icons/to_faq_icon.png"),
                  size: 20.sp,
                ),
              ),
            ),
          ],
          title: "Biodata",
        ),
        body: _tabBar(context, state));
  }

  Widget _tabBar(
    BuildContext context,
    BiodataSisterState state,
  ) {
    if (state is BiodataSisterInitial) {
      return SkeletonLoadingSisterTabBar();
    } else if (state is BiodataSisterLoadedState) {
      // a
      if (state.nidn.isEmpty) {
        return EmptyDataPage();
      } else {
        return Column(
          children: [
            TabBarScroll(
              tabs: [
                Tab(child: Text("Profil")),
                Tab(child: Text("Alamat dan Kontak")),
                Tab(child: Text("Kualifikasi")),
                Tab(child: Text("Kependudukan")),
                Tab(child: Text("Keluarga")),
                Tab(child: Text("Kepegawaian")),
                Tab(child: Text("Lain - lain")),
              ],
              tabview: [
                TabBarViewSister(data: [
                  // {'nama': "NAMA", 'info': "ASDASDSAD"}
                  {
                    'nama': 'Nama',
                    'info': state.biodataSister.data.profile.nama
                  },
                  {
                    'nama': 'NIDN',
                    'info': state.biodataSister.data.profile.nidn
                  },
                  {
                    'nama': 'Jenis Kelamin',
                    'info': state.biodataSister.data.profile.jenisKelamin
                  },
                  {
                    'nama': 'Tempat dan Tanggal Lahir',
                    'info': (state.biodataSister.data.profile.tempatLahir) +
                        ", " +
                        FormatDate().formatDate2(
                            state.biodataSister.data.profile.tglLahir)
                  },
                ]),
                TabBarViewSister(data: [
                  {
                    'nama': 'Email',
                    'info': state.biodataSister.data.alamatKontak.email
                  },
                  {
                    'nama': 'Alamat',
                    'info': state.biodataSister.data.alamatKontak.jalan
                  },
                  {
                    'nama': 'RT',
                    'info': state.biodataSister.data.alamatKontak.rt
                  },
                  {
                    'nama': 'RW',
                    'info': state.biodataSister.data.alamatKontak.rw
                  },
                  {
                    'nama': 'Dusun',
                    'info': state.biodataSister.data.alamatKontak.dusun
                  },
                  {
                    'nama': 'Desa/Kelurahan',
                    'info': state.biodataSister.data.alamatKontak.desaKelurahan
                  },
                  {
                    'nama': 'Kota/Kabupaten',
                    'info': state.biodataSister.data.alamatKontak.kotaKabupaten
                  },
                  {
                    'nama': 'Provinsi',
                    'info': state.biodataSister.data.alamatKontak.provinsi
                  },
                  {
                    'nama': 'Kode Pos',
                    'info': state.biodataSister.data.alamatKontak.kodePos
                  },
                  {
                    'nama': 'No. Telepon Rumah',
                    'info': state.biodataSister.data.alamatKontak.noTelp
                  },
                  {
                    'nama': 'No. HP',
                    'info': state.biodataSister.data.alamatKontak.noHp
                  },
                ]),
                TabBarViewSister(data: [
                  {
                    'nama': 'Jabatan Fungsional',
                    'info': (state
                            .biodataSister.data.kualifikasi.jabfung.nama) +
                        "(" +
                        state.biodataSister.data.kualifikasi.jabfung.angkaKredit
                            .toString() +
                        ")"
                  },
                  {
                    'nama': 'Pendidikan terakhir',
                    'info':
                        state.biodataSister.data.kualifikasi.pendidikanTerakhir
                  },
                  {
                    'nama': 'Pangkat/Golongan',
                    'info': (state.biodataSister.data.kualifikasi.kepangkatan
                            .pangkat) +
                        "(" +
                        (state.biodataSister.data.kualifikasi.kepangkatan
                            .golongan) +
                        ")"
                  },
                  {
                    'nama': 'Sertifikasi Dosen',
                    'info': state.biodataSister.data.kualifikasi
                            .sertifikasiDosen.isEmpty
                        ? "Belum Tersertifikasi Dosen"
                        : "Telah Tersertifikasi Dosen"
                  },
                ]),
                TabBarViewSister(data: [
                  {
                    'nama': 'NIK',
                    'info': state.biodataSister.data.kependudukan.nik
                  },
                  {
                    'nama': 'Agama',
                    'info': state.biodataSister.data.kependudukan.agama
                  },
                  {
                    'nama': 'Kewarganegaraan',
                    'info':
                        state.biodataSister.data.kependudukan.kewarganegaraan
                  },
                ]),
                TabBarViewSister(data: [
                  {
                    'nama': 'Status Perkawinan',
                    'info': state.biodataSister.data.keluarga.statusPerkawinan
                  },
                  {
                    'nama': 'Nama Suami/Istri',
                    'info': state.biodataSister.data.keluarga.namaSuamiIstri
                  },
                  {
                    'nama': 'NIP Suami/Istri',
                    'info': state.biodataSister.data.keluarga.nipSuamiIstri
                  },
                ]),
                TabBarViewSister(data: [
                  {
                    'nama': 'Pembina',
                    'info': state.biodataSister.data.kepegawaian.pembina
                  },
                  {
                    'nama': 'Perguruan Tinggi',
                    'info': state.biodataSister.data.kepegawaian.nmPt
                  },
                  {
                    'nama': 'Program Studi',
                    'info': state.biodataSister.data.kepegawaian.nmProdi
                  },
                  {
                    'nama': 'NIP',
                    'info': state.biodataSister.data.kepegawaian.nip
                  },
                  {
                    'nama': 'Status Kepegawaian',
                    'info':
                        state.biodataSister.data.kepegawaian.statusKepegawaian
                  },
                  {
                    'nama': 'Status Keaktifan',
                    'info': state.biodataSister.data.kepegawaian.statusKeaktifan
                  },
                  {
                    'nama': 'Nomor SK CPNS',
                    'info': state.biodataSister.data.kepegawaian.skCpns
                  },
                  {
                    'nama': 'SK CPNS Terhitung Mulai Tanggal',
                    'info': FormatDate().formatDate2(
                        state.biodataSister.data.kepegawaian.tglSkCpns)
                  },
                  {
                    'nama': 'Nomor SK TMMD',
                    'info': state.biodataSister.data.kepegawaian.nomorSkTmmd
                  },
                  {
                    'nama': 'Tanggal Mulai Menjadi Dosen (TMMD)',
                    'info': FormatDate().formatDate2(
                            state.biodataSister.data.kepegawaian.tglSkTmmd) +
                        ' (Masa kerja: ' +
                        state.biodataSister.data.kepegawaian.masaKerja +
                        ' Tahun)'
                  },
                  {
                    'nama': 'Masa Kerja',
                    'info': state.biodataSister.data.kepegawaian.masaKerja
                  },
                  {
                    'nama': 'Ikatan Kerja',
                    'info': state.biodataSister.data.kepegawaian.ikatanKerja
                  },
                  {
                    'nama': 'Lembaga Pengangkatan',
                    'info': state.biodataSister.data.kepegawaian.lembagaAngkat
                  },
                  {
                    'nama': 'Sumber Gaji',
                    'info': state.biodataSister.data.kepegawaian.sumberGaji
                  },
                ]),
                TabBarViewSister(data: [
                  {
                    'nama': 'NPWP',
                    'info': state.biodataSister.data.lainLain.npwp
                  },
                  {
                    'nama': 'Nama Wajib Pajak',
                    'info': state.biodataSister.data.lainLain.namaWajibPajak
                  },
                  {
                    'nama': 'SINTA ID',
                    'info': state.biodataSister.data.lainLain.idSinta
                  },
                ]),
              ],
            ),
          ],
        );
      }
    } else {
      if (state is BiodataSisterNoInternetState) {
        return Container(
          color: Colors.transparent,
          height: screenHeight(context) * 0.5,
          child: NoInternet(
              onPressed: () {
                _biodataSisterBloc.add(GetBiodataSisterEvent(nidn: state.nidn));
              },
              buttonHide: false),
        );
      } else if (state is BiodataSisterNotFoundState) {
        return Container(
          child: EmptyDataPage(),
        );
      } else if (state is BiodataSisterErrorState) {
        return Container(
          alignment: Alignment.center,
          color: Colors.transparent,
          height: screenHeight(context) * 0.5,
          child: ServerProblem(
              onPressed: () {
                _biodataSisterBloc.add(GetBiodataSisterEvent(nidn: state.nidn));
              },
              buttonHide: false),
        );
      } else {
        return Container(
          color: Colors.transparent,
          height: screenHeight(context) * 0.5,
          child: ServerProblem(
              onPressed: () {
                _biodataSisterBloc
                    .add(GetBiodataSisterEvent(nidn: _biodataSisterBloc.nidn));
              },
              buttonHide: false),
        );
      }
    }
  }
}
