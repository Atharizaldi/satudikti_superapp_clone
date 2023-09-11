import 'package:app/data/source/remote/model/kampusMerdeka/MBKMList.dart'
    as MBKMBList;
import 'package:app/presentation/pages/beranda/kampusMerdeka/component/card_MBKM.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProgramWidget extends StatelessWidget {
  final List<MBKMBList.Data> listProgram;

  const ProgramWidget({Key? key, required this.listProgram}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final programs = {
      'Bangkit by Google, GoTo, and Traveloka': [
        'assets/km/program-logo/bangkit-logo.png',
        'https://grow.google/intl/id_id/bangkit/'
      ],
      'Indonesian International Student Mobility Awards': [
        'assets/km/program-logo/iisma.png',
        'https://kampusmerdeka.kemdikbud.go.id/km/IISMA/landing.html'
      ],
      'Kampus Mengajar': [
        'assets/km/program-logo/kampus_mengajar.png',
        'https://kampusmerdeka.kemdikbud.go.id/program/mengajar'
      ],
      'Kementerian ESDM - GERILYA': [
        'assets/km/program-logo/ESDM_gerilya.png',
        'https://www.esdm.go.id/id/page/gerilya'
      ],
      'Magang': [
        'assets/km.png',
        'https://kampusmerdeka.kemdikbud.go.id/program/magang'
      ],
      'Membangun Desa (KKN Tematik)': [
        'assets/km.png',
        'https://kampusmerdeka.kemdikbud.go.id/'
      ],
      'Pejuang Muda Kampus Merdeka': [
        'assets/km/program-logo/pejuang_muda.png',
        'https://pejuangmuda.kemensos.go.id/'
      ],
      'Pertukaran Mahasiswa Merdeka': [
        'assets/km/program-logo/pmm.png',
        'https://kampusmerdeka.kemdikbud.go.id/web/pertukaranMahasiswaMerdeka2021'
      ],
      'Proyek Kemanusiaan': [
        'assets/km.png',
        'https://kampusmerdeka.kemdikbud.go.id/'
      ],
      'Riset atau Penelitian': [
        'assets/km.png',
        'https://kampusmerdeka.kemdikbud.go.id/'
      ],
      'Studi Independen': [
        'assets/km/program-logo/studi_independen.png',
        'https://kampusmerdeka.kemdikbud.go.id/program/studi-independen'
      ],
      'Wirausaha Merdeka': [
        'assets/km.png',
        'https://kampusmerdeka.kemdikbud.go.id/',
      ],
    };

    return Flexible(
      child: ListView.separated(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: listProgram.length,
        separatorBuilder: (context, index) {
          return SizedBox(
            height: 20.h,
          );
        },
        itemBuilder: (context, index) {
          return CardMBKM(
              program: listProgram[index].namaKegiatan,
              startDate: listProgram[index].startDate ?? "",
              endDate: listProgram[index].endDate ?? "",
              penjelasan: listProgram[index].deskripsi,

              // The indexes (0 and 1) will give
              // the respective value (img or url)
              // based on the key (namaKegiatan).
              image: listProgram[index].image ?? "",
              url: listProgram[index].url ??
                  "https://kampusmerdeka.kemdikbud.go.id/");
        },
      ),
    );
  }
}
