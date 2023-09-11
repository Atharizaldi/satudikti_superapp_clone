class PengajuanDummyData {
  final String nama;
  final String nidn;
  final String jabatanDiajukan;
  final String jenisPengajuan;
  final String nomorSKPengajuan;
  final String tanggalPengajuan;
  final String statusPengajuan;
  final int progress;

  PengajuanDummyData({
    this.nama = 'Han Ay Lie',
    this.nidn = '18111105423211',
    required this.jabatanDiajukan,
    required this.jenisPengajuan,
    required this.tanggalPengajuan,
    required this.nomorSKPengajuan,
    required this.progress,
    this.statusPengajuan = 'Sedang Diproses',
  });
}

class ProgressPengajuan {
  final String namaProgress;
  final String detailProgress;
  final String jamProgress;
  final String tanggalProgress;

  ProgressPengajuan({
    required this.namaProgress,
    required this.detailProgress,
    required this.jamProgress,
    required this.tanggalProgress,
  });
}

class ProgressPengajuanUsulanSiaga {
  final String namaProgress;
  final String detailProgress;
  final String oleh;
  final String jamProgress;
  final String tanggalProgress;

  ProgressPengajuanUsulanSiaga({
    required this.oleh,
    required this.namaProgress,
    required this.detailProgress,
    required this.jamProgress,
    required this.tanggalProgress,
  });
}

List<PengajuanDummyData> pengajuanList = [
  // PengajuanDummyData(
  //   jabatanDiajukan: 'Pembina Utama (IV/E)',
  //   jenisPengajuan: 'Pangkat',
  //   nomorSKPengajuan: '/UN7.P3/KP/2021',
  //   tanggalPengajuan: '2021-03-08',
  //   progress: 25,
  // ),
  // PengajuanDummyData(
  //   jabatanDiajukan: 'Guru Besar',
  //   jenisPengajuan: 'Jabatan',
  //   nomorSKPengajuan: '/UN7.P2/KP/2021',
  //   tanggalPengajuan: '2021-02-07',
  //   progress: 50,
  // ),
  // PengajuanDummyData(
  //   jabatanDiajukan: 'Penata Muda Tingkat I (III/B)',
  //   jenisPengajuan: 'Pangkat',
  //   nomorSKPengajuan: '/UN7.P1/KP/2021',
  //   tanggalPengajuan: '2021-01-06',
  //   progress: 75,
  // ),
  // PengajuanDummyData(
  //   jabatanDiajukan: 'Penata (III/C)',
  //   jenisPengajuan: 'Pangkat',
  //   nomorSKPengajuan: '/UN7.P1/KP/2021',
  //   tanggalPengajuan: '2021-01-06',
  //   progress: 100,
  //   statusPengajuan: 'Ditolak',
  // ),
  // PengajuanDummyData(
  //   jabatanDiajukan: 'Dosen',
  //   jenisPengajuan: 'Jabatan',
  //   nomorSKPengajuan: '/UN7.P2/KP/2021',
  //   tanggalPengajuan: '2020-12-07',
  //   progress: 100,
  // ),
];

List<ProgressPengajuan> progressPengajuanList = [
  ProgressPengajuan(
    namaProgress: 'USULAN TELAH DIINPUT',
    detailProgress: 'Usulan mulai diinput oleh petugas. Update jam 09:39:22',
    jamProgress: 'Jam 21.00',
    tanggalProgress: '2021-05-01',
  ),
  ProgressPengajuan(
    namaProgress: 'VERIFIKASI ADMINISTRASI',
    detailProgress:
        'Berkas administrasi usulan dinyatakan tidak valid oleh petugas Dikti. Update jam 21:49:13',
    jamProgress: 'Jam 21.00',
    tanggalProgress: '2021-05-01',
  ),
  ProgressPengajuan(
    namaProgress: 'Penjadwalan Penilaian',
    detailProgress:
        'Usulan dijadwalkan untuk dinilai pada periode penilaian 13-16 Januari 2021. Update jam 21.00',
    jamProgress: 'Jam 21.00',
    tanggalProgress: '2021-05-01',
  ),
  ProgressPengajuan(
    namaProgress: 'PROSES VERIFIKASI DATA',
    detailProgress:
        'Memverfikasi berkas pengusul no register 12011906. Update jam 16:01:33',
    jamProgress: 'Jam 21.00',
    tanggalProgress: '2021-05-01',
  ),
  ProgressPengajuan(
    namaProgress: 'DITANDA TANGANI DAN SIAP DIAMBIL',
    detailProgress:
        'Mengirim notifikasi SK siap diambil. Nomor register SK tersebut adalah 22111813',
    jamProgress: 'Jam 21.00',
    tanggalProgress: '2021-05-01',
  ),
];
List<ProgressPengajuanUsulanSiaga> pengajuanListSiaga = [
  ProgressPengajuanUsulanSiaga(
    namaProgress: 'PENGAJUAN USULAN PRODI',
    oleh: 'Oleh Pengusul',
    detailProgress:
        'Operator Perguruan Tinggi mengajukan usulan prodi jam 16:01:33',
    jamProgress: 'Jam 21.00',
    tanggalProgress: '2021-05-01',
  ),
  ProgressPengajuanUsulanSiaga(
    namaProgress: 'USULAN SEDANG DIEVALUASI',
    oleh: 'Oleh Dit Kelembagaan',
    detailProgress:
        'Evaluator sedang mengevaluasi usulan program studi jam 16:01:33',
    jamProgress: 'Jam 21.00',
    tanggalProgress: '2021-05-01',
  ),
  ProgressPengajuanUsulanSiaga(
    namaProgress: 'DIREKOMENDASIKAN',
    oleh: 'Oleh LLDIKTI',
    detailProgress: 'Note Usulan Direkomendasikan  jam 16:01:33',
    jamProgress: 'Jam 21.00',
    tanggalProgress: '2021-05-01',
  ),
  ProgressPengajuanUsulanSiaga(
    namaProgress: 'PROSES LAINNYA TERAKHIR SELESAI',
    oleh: 'Oleh Dit Kelembagaan',
    detailProgress:
        'Memverfikasi berkas pengusul no register 12011906 jam 16:01:33',
    jamProgress: 'Jam 21.00',
    tanggalProgress: '2021-05-01',
  ),
];
