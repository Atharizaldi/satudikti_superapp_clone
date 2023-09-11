import 'package:app/common/internetCheck.dart';
import 'package:app/data/repositories/beasiswaRepositoryImpl.dart';
import 'package:app/data/repositories/beritaRepositoryImpl.dart';
import 'package:app/data/repositories/configRepositoryImpl.dart';
import 'package:app/data/repositories/faqApiRepositoryImpl.dart';
import 'package:app/data/repositories/garudaRepositoryImpl.dart';
import 'package:app/data/repositories/gmagzRepositoryImpl.dart';
import 'package:app/data/repositories/ijazahlnRepositoryImpl.dart';
import 'package:app/data/repositories/kampus_merdeka_repository_impl.dart';
import 'package:app/data/repositories/kedairerkaRepositoryImpl.dart';
import 'package:app/data/repositories/kompetensi_dosen_repository_impl.dart';
import 'package:app/data/repositories/modulRepositoryImpl.dart';
import 'package:app/data/repositories/pddiktiDetailRepositoryImpl.dart';
import 'package:app/data/repositories/pddiktiRepositoryImpl.dart';
import 'package:app/data/repositories/pengumumanRepositoryImpl.dart';
import 'package:app/data/repositories/selancar_repository_impl.dart';
import 'package:app/data/repositories/siagaRepositoryImpl.dart';
import 'package:app/data/repositories/sintaRepositoryImpl.dart';
import 'package:app/data/repositories/sister_repository_impl.dart';
import 'package:app/data/repositories/sivilRepositoryImpl.dart';
import 'package:app/data/repositories/sso_repository_impl.dart';
import 'package:app/data/repositories/tracerKuesionerRepositoryImpl.dart';
import 'package:app/data/repositories/tracerStatistikRepositoryImpl.dart';
import 'package:app/data/repositories/userAvatarInformationRepositoryImpl.dart';
import 'package:app/domain/repositories/GMagzRepository.dart';
import 'package:app/domain/repositories/beasiswaRepository.dart';
import 'package:app/domain/repositories/beritaRepository.dart';
import 'package:app/domain/repositories/configRepository.dart';
import 'package:app/domain/repositories/faqApiRepository.dart';
import 'package:app/domain/repositories/garudaRepository.dart';
import 'package:app/domain/repositories/ijazahlnRepository.dart';
import 'package:app/domain/repositories/kampusMerdekaRepository.dart';
import 'package:app/domain/repositories/kedairekaRepository.dart';
import 'package:app/domain/repositories/kompetensi_dosen_repository.dart';
import 'package:app/domain/repositories/modulRepository.dart';
import 'package:app/domain/repositories/pddiktiDetailRepository.dart';
import 'package:app/domain/repositories/pddiktiRepository.dart';
import 'package:app/domain/repositories/pengumumanRepository.dart';
import 'package:app/domain/repositories/selancar_repository.dart';
import 'package:app/domain/repositories/siagaRepository.dart';
import 'package:app/domain/repositories/sintaRepository.dart';
import 'package:app/domain/repositories/sister_repository.dart';
import 'package:app/domain/repositories/sivilRepository.dart';
import 'package:app/domain/repositories/sso_repository.dart';
import 'package:app/domain/repositories/tracerKuesionerRepository.dart';
import 'package:app/domain/repositories/tracerStatistikRepository.dart';
import 'package:app/domain/repositories/userAvatarInformationRepository.dart';
import 'package:app/domain/usecases/beasiswa/getListBeasiswa.dart';
import 'package:app/domain/usecases/beasiswa/searchListBeasiswa.dart';
import 'package:app/domain/usecases/beasiswa/searchListBeasiswaFilter.dart';
import 'package:app/domain/usecases/berita/getNews.dart';
import 'package:app/domain/usecases/berita/getNewsDetail.dart';
import 'package:app/domain/usecases/berita/getNewsSearch.dart';
import 'package:app/domain/usecases/berita/getNewsSearchMoreResults.dart';
import 'package:app/domain/usecases/config/getConfig.dart';
import 'package:app/domain/usecases/faq/getFaq.dart';
import 'package:app/domain/usecases/faq/getFaqModule.dart';
import 'package:app/domain/usecases/faq/getFaqSearch.dart';
import 'package:app/domain/usecases/garuda/getListJournal.dart';
import 'package:app/domain/usecases/garuda/getStatistikGaruda.dart';
import 'package:app/domain/usecases/garuda/searchGarudaJournal.dart';
import 'package:app/domain/usecases/garuda/searchGarudaJournalBySubject.dart';
import 'package:app/domain/usecases/garuda/searchGarudaPaper.dart';
import 'package:app/domain/usecases/gmagz/get_majalah_detail_gmagz.dart';
import 'package:app/domain/usecases/gmagz/get_majalah_gmagz.dart';
import 'package:app/domain/usecases/gmagz/put_downloader_gmagz.dart';
import 'package:app/domain/usecases/gmagz/put_reader_gmagz.dart';
import 'package:app/domain/usecases/ijazahln/getByEmail.dart';
import 'package:app/domain/usecases/ijazahln/getByNoReg.dart';
import 'package:app/domain/usecases/ijazahln/getFaqIjazah.dart';
import 'package:app/domain/usecases/ijazahln/getNegara.dart';
import 'package:app/domain/usecases/ijazahln/getPT.dart';
import 'package:app/domain/usecases/ijazahln/getPostVerif.dart';
import 'package:app/domain/usecases/ijazahln/getProdiPTLN.dart';
import 'package:app/domain/usecases/kampusmerdeka/getCKM.dart';
import 'package:app/domain/usecases/kampusmerdeka/getDetailCKM.dart';
import 'package:app/domain/usecases/kampusmerdeka/getMbkm.dart';
import 'package:app/domain/usecases/kedaireka/getIndustri.dart';
import 'package:app/domain/usecases/kedaireka/getPT.dart';
import 'package:app/domain/usecases/kompetensi_dosen/download_sertifikat.dart';
import 'package:app/domain/usecases/kompetensi_dosen/download_unduhan.dart';
import 'package:app/domain/usecases/kompetensi_dosen/get_file_list.dart';
import 'package:app/domain/usecases/kompetensi_dosen/get_list_tawaran_program.dart';
import 'package:app/domain/usecases/kompetensi_dosen/get_penilaian_dosen.dart';
import 'package:app/domain/usecases/kompetensi_dosen/get_program_terdaftar.dart';
import 'package:app/domain/usecases/kompetensi_dosen/get_sertifikat.dart';
import 'package:app/domain/usecases/kompetensi_dosen/get_unduhan.dart';
import 'package:app/domain/usecases/modul/getModul.dart';
import 'package:app/domain/usecases/pddikti/getElasticSearch.dart';
import 'package:app/domain/usecases/pddikti/getListElasticPTAPI.dart';
import 'package:app/domain/usecases/pddikti/getListElasticProvinsi.dart';
import 'package:app/domain/usecases/pddikti/getListPTAPI.dart';
import 'package:app/domain/usecases/pddikti/getListProdiAPI.dart';
import 'package:app/domain/usecases/pddikti/getStatistic.dart';
import 'package:app/domain/usecases/pddikti/pddikti_detail/dosen/getDetailDosenPageAPI.dart';
import 'package:app/domain/usecases/pddikti/pddikti_detail/dosen/getRiwayatMengajarDosenAPI.dart';
import 'package:app/domain/usecases/pddikti/pddikti_detail/dosen/getRiwayatPendidikanDosenAPI.dart';
import 'package:app/domain/usecases/pddikti/pddikti_detail/mahasiswa/getMahasiswaPageAPI.dart';
import 'package:app/domain/usecases/pddikti/pddikti_detail/mahasiswa/getMahasiswaPageAPIReg.dart';
import 'package:app/domain/usecases/pddikti/pddikti_detail/mahasiswa/getRiwayatKuliahMahasiswa.dart';
import 'package:app/domain/usecases/pddikti/pddikti_detail/mahasiswa/getRiwayatStudiMahasiswa.dart';
import 'package:app/domain/usecases/pddikti/pddikti_detail/prodi/getAkreditasiProdiAPI.dart';
import 'package:app/domain/usecases/pddikti/pddikti_detail/prodi/getDetailProdiAPI.dart';
import 'package:app/domain/usecases/pddikti/pddikti_detail/prodi/getDetailProdiAPIReg.dart';
import 'package:app/domain/usecases/pddikti/pddikti_detail/prodi/getListDosenProdiAPI.dart';
import 'package:app/domain/usecases/pddikti/pddikti_detail/prodi/getRasioProdiAPI.dart';
import 'package:app/domain/usecases/pddikti/pddikti_detail/pt/getAgregatPTAPI.dart';
import 'package:app/domain/usecases/pddikti/pddikti_detail/pt/getAkreditasiPTAPI.dart';
import 'package:app/domain/usecases/pddikti/pddikti_detail/pt/getDetailPTAPI.dart';
import 'package:app/domain/usecases/pddikti/pddikti_detail/pt/getIDPTPDDIKTI.dart';
import 'package:app/domain/usecases/pddikti/pddikti_detail/pt/getPelaporanPTAPI.dart';
import 'package:app/domain/usecases/pddikti/perubahan_dosen_tendik/get_perubahan_dosen_tendik.dart';
import 'package:app/domain/usecases/pddikti/result/getDetailDosenAPI.dart';
import 'package:app/domain/usecases/pddikti/result/getDetailMahasiswaAPI.dart';
import 'package:app/domain/usecases/pddikti/result/getPTAPI.dart';
import 'package:app/domain/usecases/pddikti/result/getProdiAPI.dart';
import 'package:app/domain/usecases/pddikti/usulan_dosen/get_usulan_dosen.dart';
import 'package:app/domain/usecases/pengumuman/getPengumuman.dart';
import 'package:app/domain/usecases/pengumuman/getPengumumanDetail.dart';
import 'package:app/domain/usecases/pengumuman/getPengumumanSearch.dart';
import 'package:app/domain/usecases/pengumuman/getPengumumanSearchMoreResults.dart';
import 'package:app/domain/usecases/pengumuman/getPengumumanWithCategory.dart';
import 'package:app/domain/usecases/profil/get_user_avatar.dart';
import 'package:app/domain/usecases/profil/get_user_information.dart';
import 'package:app/domain/usecases/profil/get_user_information_detail.dart';
import 'package:app/domain/usecases/profil/logout_sso.dart';
import 'package:app/domain/usecases/profil/put_user_avatar.dart';
import 'package:app/domain/usecases/selancar/get_faq_selancar.dart';
import 'package:app/domain/usecases/selancar/get_profile_detail_selancar.dart';
import 'package:app/domain/usecases/selancar/get_usulan_detail.dart';
import 'package:app/domain/usecases/selancar/get_usulan_list.dart';
import 'package:app/domain/usecases/siaga/getDetailTrackingUsulan.dart';
import 'package:app/domain/usecases/siaga/getFaqSiaga.dart';
import 'package:app/domain/usecases/siaga/getSearchTrackingUsulan.dart';
import 'package:app/domain/usecases/sinta/affiliations/getAffiliationsDetail.dart';
import 'package:app/domain/usecases/sinta/affiliations/getAffiliationsList.dart';
import 'package:app/domain/usecases/sinta/affiliations/getAffiliationsScopus.dart';
import 'package:app/domain/usecases/sinta/authors/getAuthorsDetail.dart';
import 'package:app/domain/usecases/sinta/authors/getAuthorsList.dart';
import 'package:app/domain/usecases/sinta/authors/getAuthorsScopus.dart';
import 'package:app/domain/usecases/sinta/getFaqSinta.dart';
import 'package:app/domain/usecases/sinta/journals/getJournalsDetail.dart';
import 'package:app/domain/usecases/sinta/journals/getJournalsList.dart';
import 'package:app/domain/usecases/sinta/journals/getJournalsScholar.dart';
import 'package:app/domain/usecases/sister/get_biodata_sister.dart';
import 'package:app/domain/usecases/sister/get_bkd_rekrutmen_sister.dart';
import 'package:app/domain/usecases/sister/get_pendidikan_diklat_sister.dart';
import 'package:app/domain/usecases/sister/get_pendidikan_formal_dosen_sister.dart';
import 'package:app/domain/usecases/sister/get_pendidikan_pembimbingan_sister.dart';
import 'package:app/domain/usecases/sister/get_pendidikan_pengajaran_sister.dart';
import 'package:app/domain/usecases/sister/get_pendidikan_pengujian_sister.dart';
import 'package:app/domain/usecases/sister/get_penelitian_sister.dart';
import 'package:app/domain/usecases/sister/get_penempatan_sister.dart';
import 'package:app/domain/usecases/sister/get_pengabdian_sister.dart';
import 'package:app/domain/usecases/sister/get_praktisi_sister.dart';
import 'package:app/domain/usecases/sister/get_profile_detail_sister.dart';
import 'package:app/domain/usecases/sivil/getSearchListPT.dart';
import 'package:app/domain/usecases/sivil/getSearchListProdi.dart';
import 'package:app/domain/usecases/sivil/getSivil.dart';
import 'package:app/domain/usecases/tracer/getAllAnswerTracer.dart';
import 'package:app/domain/usecases/tracer/getHorizontalPieChart.dart';
import 'package:app/domain/usecases/tracer/getHorizontalTable.dart';
import 'package:app/domain/usecases/tracer/getListElasticKabupaten.dart';
import 'package:app/domain/usecases/tracer/getListElasticProvinsiTracer.dart';
import 'package:app/domain/usecases/tracer/getListProdiTracer.dart';
import 'package:app/domain/usecases/tracer/getListProvinsi.dart';
import 'package:app/domain/usecases/tracer/getListPtTracer.dart';
import 'package:app/domain/usecases/tracer/getPekerjaanDibawahEnamBulanPieChart.dart';
import 'package:app/domain/usecases/tracer/getPekerjaanTable.dart';
import 'package:app/domain/usecases/tracer/getQuestions.dart';
import 'package:app/domain/usecases/tracer/getVerticalPieChart.dart';
import 'package:app/domain/usecases/tracer/getVerticalTable.dart';
import 'package:app/domain/usecases/tracer/postStoreAnswer.dart';
import 'package:app/domain/usecases/tracer/validateData.dart';
import 'package:app/presentation/component/blocs/PDFViewerBloc/pdfviewer_bloc.dart';
import 'package:app/presentation/pages/beranda/beasiswa/components/list_pagination_beasiswa/list_pagination_beasiswa_bloc.dart';
import 'package:app/presentation/pages/beranda/beasiswa/get_list_beasiswa_bloc/list_beasiswa_bloc.dart';
import 'package:app/presentation/pages/beranda/beasiswa/search_beasiswa_bloc/search_beasiswa_bloc.dart';
import 'package:app/presentation/pages/beranda/beranda/bloc/beranda_bloc.dart';
import 'package:app/presentation/pages/beranda/beranda/bloc/lainnya_bloc.dart';
import 'package:app/presentation/pages/beranda/berita/bloc/berita_bloc.dart';
import 'package:app/presentation/pages/beranda/beritaDanPengumumanDetail/bloc/berita_dan_pengumuman_bloc.dart';
import 'package:app/presentation/pages/beranda/beritaDanPengumumanDetail/detailBloc/berita_pengumuman_detail_bloc.dart';
import 'package:app/presentation/pages/beranda/garuda/bloc/garuda_journal/garuda_bloc.dart';
import 'package:app/presentation/pages/beranda/garuda/bloc/garuda_journal/searching_journal/garuda_searching_journal_bloc.dart';
import 'package:app/presentation/pages/beranda/garuda/bloc/garuda_paper/garuda_paper_bloc.dart';
import 'package:app/presentation/pages/beranda/garuda/bloc/statistik_garuda/statistik_garuda_bloc.dart';
import 'package:app/presentation/pages/beranda/gmagz/bloc/majalah/majalah_gmagz_bloc.dart';
// import 'package:app/presentation/pages/beranda/bloc/lainnya_bloc.dart';
import 'package:app/presentation/pages/beranda/ijazahln/bloc/bloc/bts_pt_ijazah_bloc.dart';
import 'package:app/presentation/pages/beranda/ijazahln/bloc/bts_negara_bloc/bts_negara_bloc.dart';
import 'package:app/presentation/pages/beranda/ijazahln/bloc/cubit/selectedijazah_cubit.dart';
import 'package:app/presentation/pages/beranda/ijazahln/bloc/ijazahln/ijazahbyno/ijazahbyno_bloc.dart';
import 'package:app/presentation/pages/beranda/ijazahln/bloc/ijazahln/statuspengajuan/statuspengajuan_bloc.dart';
import 'package:app/presentation/pages/beranda/ijazahln/bloc/ijazahln/verifikasisk/negarapt/negara_bloc.dart';
import 'package:app/presentation/pages/beranda/ijazahln/bloc/ijazahln/verifikasisk/verifikasisk_bloc.dart';
import 'package:app/presentation/pages/beranda/ijazahln/pencarianPTLN/bloc/detail_prodi_ptln_bloc.dart';
import 'package:app/presentation/pages/beranda/kampusMerdeka/bloc/cerita_kampus_merdeka/cerita_kampus_merdeka_bloc.dart';
import 'package:app/presentation/pages/beranda/kampusMerdeka/bloc/detail_cerita_km/detail_cerita_km_bloc.dart';
import 'package:app/presentation/pages/beranda/kampusMerdeka/bloc/kampus_merdeka/kampusmerdeka_bloc.dart';
import 'package:app/presentation/pages/beranda/kedaireka/bloc/kedairekaindustri_bloc.dart';
import 'package:app/presentation/pages/beranda/kedaireka/bloc/kedairekapt/kedairekapt_bloc.dart';
import 'package:app/presentation/pages/beranda/kompetensiDosen/bloc/file_list/file_list_bloc.dart';
import 'package:app/presentation/pages/beranda/kompetensiDosen/bloc/list_tawaran_program/list_tawaran_program_bloc.dart';
import 'package:app/presentation/pages/beranda/kompetensiDosen/bloc/login_kd/login_kd_bloc.dart';
import 'package:app/presentation/pages/beranda/kompetensiDosen/bloc/penilaian_dosen/penilaian_dosen_bloc.dart';
import 'package:app/presentation/pages/beranda/kompetensiDosen/bloc/program_terdaftar/program_terdaftar_bloc.dart';
import 'package:app/presentation/pages/beranda/kompetensiDosen/bloc/sertifikat/sertifikat_bloc.dart';
import 'package:app/presentation/pages/beranda/kompetensiDosen/bloc/unduhan/unduhan_bloc.dart';
import 'package:app/presentation/pages/beranda/pddikti/bloc/bloc/perubahan_dosen_tendik_bloc.dart';
import 'package:app/presentation/pages/beranda/pddikti/bloc/bottom_sheet_form/bottom_sheet_form_bloc.dart';
import 'package:app/presentation/pages/beranda/pddikti/bloc/detail_pencarian/dosen/detail_pencarian_dosen_bloc.dart';
import 'package:app/presentation/pages/beranda/pddikti/bloc/detail_pencarian/mahasiswa/detail_pencarian_mahasiswa_bloc.dart';
import 'package:app/presentation/pages/beranda/pddikti/bloc/detail_pencarian/prodi/detail_pencarian_prodi_bloc.dart';
import 'package:app/presentation/pages/beranda/pddikti/bloc/detail_pencarian/pt/detail_pencarian_pt_bloc.dart';
import 'package:app/presentation/pages/beranda/pddikti/bloc/pencarian_bloc/pencarian_bloc.dart';
import 'package:app/presentation/pages/beranda/pddikti/bloc/pencarian_spesifik_bloc/pencarian_spesifik_bloc.dart';
import 'package:app/presentation/pages/beranda/pddikti/bloc/result_spesifik_bloc/result_spesifik_bloc.dart';
import 'package:app/presentation/pages/beranda/pddikti/bloc/usulan_dosen/usulan_dosen_bloc.dart';
import 'package:app/presentation/pages/beranda/pddikti/component/bottom_sheet_form/bottom_sheet_provinsi/bloc/bts_provinsi_bloc.dart';
import 'package:app/presentation/pages/beranda/pengumuman/kelembagaan/bloc/pengumuman_kelembagaan_bloc.dart';
import 'package:app/presentation/pages/beranda/pengumuman/pembelajaranDanMahasiswa/bloc/pengumuman_pembelajaran_bloc.dart';
import 'package:app/presentation/pages/beranda/pengumuman/sumberDaya/bloc/pengumuman_sumber_daya_bloc.dart';
import 'package:app/presentation/pages/beranda/pengumuman/umum/bloc/pengumuman_umum_bloc.dart';
import 'package:app/presentation/pages/beranda/searchPage/bloc/searchpage_bloc.dart';
import 'package:app/presentation/pages/beranda/searchPage/bloc/searchpagemoreresults_bloc.dart';
import 'package:app/presentation/pages/beranda/selancarPAK/loggedInPage/bloc/selancarloggedin_bloc.dart';
import 'package:app/presentation/pages/beranda/selancarPAK/riwayat_usulan/daftar_usulan/bloc/daftar_riwayatusulan_bloc.dart';
import 'package:app/presentation/pages/beranda/siaga/bloc/siaga_bloc.dart';
import 'package:app/presentation/pages/beranda/siaga/bottom_sheet_pt/bloc/pt_bloc.dart';
import 'package:app/presentation/pages/beranda/siaga/cubit/tipe_pencarian_cubit.dart';
import 'package:app/presentation/pages/beranda/siaga/pengajuanUsulan/bloc/pengajuan_usulan_bloc.dart';
import 'package:app/presentation/pages/beranda/sinta/sinta_bloc_injection.dart';
import 'package:app/presentation/pages/beranda/sister/biodata/bloc/biodata_sister_bloc.dart';
import 'package:app/presentation/pages/beranda/sister/bkd/bloc/bkd_bloc.dart';
import 'package:app/presentation/pages/beranda/sister/logged_in_page/bloc/sister_logged_in_bloc.dart';
import 'package:app/presentation/pages/beranda/sister/pengabdian/bloc/pengabdian_sister_bloc.dart';
import 'package:app/presentation/pages/beranda/sister/praktisi/bloc/praktisi_bloc.dart';
import 'package:app/presentation/pages/beranda/sivil/bloc/sivil_bloc.dart';
import 'package:app/presentation/pages/beranda/sivil/bottom_sheet_prodi/bloc/bts_prodi_bloc.dart';
import 'package:app/presentation/pages/beranda/sivil/bottom_sheet_pt/bloc/bts_pt_bloc.dart';
import 'package:app/presentation/pages/beranda/sivil/hasil_sivil/bloc/hasil_sivil_bloc.dart';
import 'package:app/presentation/pages/beranda/tracerStudy/bloc/pencarian_bloc/pencarian_prodi_bloc/pencarian_prodi_bloc.dart';
import 'package:app/presentation/pages/beranda/tracerStudy/bloc/tracer_bloc.dart';
import 'package:app/presentation/pages/beranda/tracerStudy/component/buttom_sheet_form/bottom_sheet_kabupaten/bloc/bts_Kabupaten_bloc.dart';
import 'package:app/presentation/pages/beranda/tracerStudy/statistik/hasilStatistik/bloc/statistik_bloc.dart';
import 'package:app/presentation/pages/faq/bloc/faq/faqapi_bloc.dart';
import 'package:app/presentation/pages/faq/bloc/faq_module/faqmodule_bloc.dart';
import 'package:app/presentation/pages/notifikasi/bloc/notifikasi_bloc.dart';
import 'package:app/presentation/pages/profil/profil_bloc_injection.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

import 'presentation/pages/beranda/garuda/bloc/garuda_umum_search/garuda_umum_search_bloc.dart';
import 'presentation/pages/beranda/gmagz/bloc/detailmajalah/majalah_detail_gmagz_bloc.dart';
import 'presentation/pages/beranda/sister/pendidikan/bloc/pendidikan_formal_dosen/pendidikan_formal_sister_bloc.dart';
import 'presentation/pages/beranda/sister/penelitian/bloc/penelitian_sister_bloc.dart';
import 'presentation/pages/beranda/sister/penempatan/bloc/penempatan_sister_bloc.dart';
import 'presentation/pages/beranda/tracerStudy/bloc/bottom_sheet_form/bottom_sheet_form_bloc.dart';
import 'presentation/pages/beranda/tracerStudy/bloc/kuesioner/kuesioner_bloc.dart';
import 'presentation/pages/beranda/tracerStudy/bloc/pencarian_bloc/pencarian_kabupaten_bloc/pencarian_kabupaten_bloc.dart';
import 'presentation/pages/beranda/tracerStudy/bloc/pencarian_bloc/pencarian_pt_bloc/pencarian_pt_bloc.dart';
import 'presentation/pages/beranda/tracerStudy/bloc/pencarian_spesifik_bloc/pencarian_spesifik_bloc.dart';
import 'presentation/pages/beranda/tracerStudy/bloc/post_store_bloc/post_store_bloc.dart';
import 'presentation/pages/beranda/tracerStudy/component/buttom_sheet_form/bottom_sheet_provinsi/bloc/bts_provinsi_bloc.dart';

final locator = GetIt.instance;

void init() {
  initRepository();
  initUseCase();
  initBloc();

  // external
  locator.registerLazySingleton(() => http.Client());
  locator.registerLazySingleton(() => Logger());
  locator.registerLazySingleton(() => InternetCheck());
}

void initRepository() {
  locator.registerLazySingleton<BeritaRepository>(
    () => BeritaRepositoryImpl(
      client: locator(),
    ),
  );
  locator.registerLazySingleton<FaqApiRepository>(
    () => FaqApiRepositoryImpl(),
  );
  locator.registerLazySingleton<PengumumanRepository>(
    () => PengumumanRepositoryImpl(
      client: locator(),
    ),
  );
  locator.registerLazySingleton<IjazahLnRepository>(
    () => IjazahLnRepositoryImpl(
      client: locator(),
    ),
  );
  locator.registerLazySingleton<SivilRepository>(
    () => SivilRepositoryImpl(
      client: locator(),
    ),
  );
  locator.registerLazySingleton<ModulRepository>(
    () => ModulRepositoryImpl(
      client: locator(),
    ),
  );
  locator.registerLazySingleton<KampusMerdekaRepository>(
    () => KampusMerdekaRepositoryImpl(
      client: locator(),
    ),
  );

  locator.registerLazySingleton<PddiktiRepository>(
    () => PddiktiRepositoryImpl(
      client: locator(),
    ),
  );

  locator.registerLazySingleton<PddiktiDetailRepository>(
    () => PddiktiDetailRepositoryImpl(
      client: locator(),
    ),
  );

  locator.registerLazySingleton<KedairekaRepository>(
    () => KedairekaRepositoryImpl(
      client: locator(),
    ),
  );

  locator.registerLazySingleton<BeasiswaRepository>(
    () => BeasiswaRepositoryImpl(
      client: locator(),
    ),
  );

  locator.registerLazySingleton<SiagaRepository>(
    () => SiagaRepositoryImpl(
      client: locator(),
    ),
  );

  locator.registerLazySingleton<SintaRepository>(
    () => SintaRepositoryImpl(
      client: locator(),
    ),
  );

  locator.registerLazySingleton<KompetensiDosenRepository>(
    () => KompetensiDosenRepositoryImpl(
      client: locator(),
    ),
  );

  locator.registerLazySingleton<SelancarRepository>(
    () => SelancarRepositoryImpl(
      client: locator(),
    ),
  );

  locator.registerLazySingleton<GarudaRepository>(
    () => GarudaRepositoryImpl(
      client: locator(),
    ),
  );

  locator.registerLazySingleton<SSORepository>(
    () => SSORepositoryImpl(
      client: locator(),
    ),
  );

  locator.registerLazySingleton<UserAvatarInformationRepository>(
    () => UserAvatarInformationRepositoryImpl(
      client: locator(),
    ),
  );

  locator.registerLazySingleton<StatistikTracerRepository>(
    () => StatistikTracerRepositoryImpl(
      client: locator(),
    ),
  );

  locator.registerLazySingleton<ConfigRepository>(
    () => ConfigRepositoryImpl(
      client: locator(),
    ),
  );

  locator.registerLazySingleton<KuesionerTracerRepository>(
    () => KuesionerTracerRepositoryImpl(
      client: locator(),
    ),
  );

  locator.registerLazySingleton<SisterRepository>(
    () => SisterRepositoryImpl(
      client: locator(),
    ),
  );

  locator.registerLazySingleton<GMagzRepository>(
    () => GMagzRepositoryImpl(
      client: locator(),
    ),
  );
}

void initUseCase() {
  //berita
  locator.registerLazySingleton(() => GetNews(locator()));
  locator.registerLazySingleton(() => GetNewsDetail(locator()));

  //pengumuman
  locator.registerLazySingleton(() => GetPengunguman(locator()));
  locator.registerLazySingleton(() => GetPengumumanDetail(locator()));
  locator.registerLazySingleton(() => GetPengumumanWithCategory(locator()));

  //faq
  locator.registerLazySingleton(() => GetFaq(locator()));
  locator.registerLazySingleton(() => GetFaqModule(locator()));

  //ijazahln
  locator.registerLazySingleton(() => GetFaqIjazah(locator()));
  locator.registerLazySingleton(() => GetByEmail(locator()));
  locator.registerLazySingleton(() => GetByNoReg(locator()));
  locator.registerLazySingleton(() => GetPostVerif(locator()));
  locator.registerLazySingleton(() => GetNegara(locator()));
  locator.registerLazySingleton(() => GetPT(locator()));
  locator.registerLazySingleton(() => GetProdiPTLN(locator()));

  //sivil
  locator.registerLazySingleton(() => GetSearchListProdi(locator()));
  locator.registerLazySingleton(() => GetSearchListPT(locator()));
  locator.registerLazySingleton(() => GetSivil(locator()));

  //searchPage
  locator.registerLazySingleton(() => GetFaqSearch(locator()));
  locator.registerLazySingleton(() => GetNewsSearch(locator()));
  locator.registerLazySingleton(() => GetNewsSearchMoreResults(locator()));
  locator.registerLazySingleton(() => GetPengumumanSearch(locator()));
  locator
      .registerLazySingleton(() => GetPengumumanSearchMoreResults(locator()));
  locator.registerLazySingleton(() => GetModul(locator()));

  //Kampus Merdeka
  locator.registerLazySingleton(() => GetMBKM(locator()));
  locator.registerLazySingleton(() => GetCKM(locator()));
  locator.registerLazySingleton(() => GetDetailCKM(locator()));

  //pddikti
  //pencarian spesifik
  locator.registerLazySingleton(() => GetListElasticProvinsi(locator()));
  locator.registerLazySingleton(() => GetListElasticPTAPI(locator()));
  locator.registerLazySingleton(() => GetListProdiAPI(locator()));
  locator.registerLazySingleton(() => GetListPTAPI(locator()));
  locator.registerLazySingleton(() => GetStatistic(locator()));

  //pencarian
  locator.registerLazySingleton(() => GetElasticSearch(locator()));

  //result pencarian spesifik
  locator.registerLazySingleton(() => GetPTAPI(locator()));
  locator.registerLazySingleton(() => GetProdiAPI(locator()));
  locator.registerLazySingleton(() => GetDetailMahasiswaAPI(locator()));
  locator.registerLazySingleton(() => GetDetailDosenAPI(locator()));

  //pddikti detail mahasiswa
  locator.registerLazySingleton(() => GetMahasiswaPageAPI(locator()));
  locator.registerLazySingleton(() => GetMahasiswaPageAPIReg(locator()));
  locator.registerLazySingleton(() => GetRiwayatKuliahMahasiswa(locator()));
  locator.registerLazySingleton(() => GetRiwayatStudiMahasiswa(locator()));

  //pddikti detail dosen
  locator.registerLazySingleton(() => GetDetailDosenPageAPI(locator()));
  locator.registerLazySingleton(() => GetRiwayatMengajarDosenAPI(locator()));
  locator.registerLazySingleton(() => GetRiwayatPendidikanDosenAPI(locator()));

  //pddikti detail pt
  locator.registerLazySingleton(() => GetIDPTPDDIKTI(locator()));
  locator.registerLazySingleton(() => GetAgregatPTAPI(locator()));
  locator.registerLazySingleton(() => GetAkreditasiPTAPI(locator()));
  locator.registerLazySingleton(() => GetDetailPTAPI(locator()));
  locator.registerLazySingleton(() => GetPelaporanPTAPI(locator()));

  //pddikti detail prodi
  locator.registerLazySingleton(() => GetAkreditasiProdiAPI(locator()));
  locator.registerLazySingleton(() => GetDetailProdiAPI(locator()));
  locator.registerLazySingleton(() => GetDetailProdiAPIReg(locator()));
  locator.registerLazySingleton(() => GetListDosenProdiAPI(locator()));
  locator.registerLazySingleton(() => GetRasioProdiAPI(locator()));

  //pddikti usulan dosen
  locator.registerLazySingleton(() => GetUsulanDosen(locator()));

  //pddikti perubahan dosen dan tendik
  locator.registerLazySingleton(() => GetPerubahanDosenDanTendik(locator()));

  //kedaireka list
  locator.registerLazySingleton(() => GetListIndustri(locator()));
  locator.registerLazySingleton(() => GetListInsanPT(locator()));

  //beasiswa
  locator.registerLazySingleton(() => GetListBeasiswa(locator()));
  locator.registerLazySingleton(() => GetListBeasiswaSedangDitutup(locator()));
  locator.registerLazySingleton(() => GetListBeasiswaAkanDibuka(locator()));
  locator.registerLazySingleton(() => SearchListBeasiswa(locator()));
  locator.registerLazySingleton(() => SearchListBeasiswaFilter(locator()));

  //siaga
  locator.registerLazySingleton(() => GetFaqSiaga(locator()));
  locator.registerLazySingleton(() => GetSearchTrackingUsulan(locator()));
  locator.registerLazySingleton(() => GetDetailTrackingUsulan(locator()));

  //sinta
  locator.registerLazySingleton(() => GetFaqSinta(locator()));
  locator.registerLazySingleton(() => GetAuthorsList(locator()));
  locator.registerLazySingleton(() => GetAuthorsDetail(locator()));
  locator.registerLazySingleton(() => GetAuthorsScopus(locator()));
  locator.registerLazySingleton(() => GetAffiliationsList(locator()));
  locator.registerLazySingleton(() => GetAffiliationsDetail(locator()));
  locator.registerLazySingleton(() => GetAffiliationsScopus(locator()));
  locator.registerLazySingleton(() => GetJournalsList(locator()));
  locator.registerLazySingleton(() => GetJournalsDetail(locator()));
  locator.registerLazySingleton(() => GetJournalsScholar(locator()));

  // kompetensi dosen
  locator.registerLazySingleton(() => GetFileList(locator()));
  locator.registerLazySingleton(() => GetListTawaranProgram(locator()));
  locator.registerLazySingleton(() => GetPenilaianDosen(locator()));
  locator.registerLazySingleton(() => GetProgramTerdaftar(locator()));
  locator.registerLazySingleton(() => GetSertifikat(locator()));
  locator.registerLazySingleton(() => DownloadSertifikat(locator()));
  locator.registerLazySingleton(() => GetUnduhan(locator()));
  locator.registerLazySingleton(() => DownloadUnduhan(locator()));

  //selancar
  locator.registerLazySingleton(() => GetFAQSelancar(locator()));
  locator.registerLazySingleton(() => GetProfileDetailSelancar(locator()));
  locator.registerLazySingleton(() => GetUsulanList(locator()));
  locator.registerLazySingleton(() => GetUsulanDetail(locator()));

  //garuda
  locator.registerLazySingleton(() => GetListJournal(locator()));
  locator.registerLazySingleton(() => SearchGarudaPaper(locator()));
  locator.registerLazySingleton(() => SearchGarudaJournal(locator()));
  locator.registerLazySingleton(() => SearchGarudaJournalBySubject(locator()));
  locator.registerLazySingleton(() => GetListStatistikGaruda(locator()));

  // SSO
  locator.registerLazySingleton(() => GetUserInformation(locator()));
  locator.registerLazySingleton(() => GetUserInformationDetail(locator()));
  locator.registerLazySingleton(() => LogoutSSO(locator()));
  locator.registerLazySingleton(() => GetUserAvatar(locator()));
  locator.registerLazySingleton(() => PutUserAvatar(locator()));

  // Tracer Study
  locator.registerLazySingleton(() => GetHorizontalPieChart(locator()));
  locator.registerLazySingleton(() => GetHorizontalTable(locator()));
  locator.registerLazySingleton(() => GetVerticalPieChart(locator()));
  locator.registerLazySingleton(() => GetVerticalTable(locator()));
  locator.registerLazySingleton(
      () => GetPekerjaanDibawahEnamBulanPieChart(locator()));
  locator.registerLazySingleton(() => GetPekerjaanTable(locator()));
  locator.registerLazySingleton(() => GetConfig(locator()));
  locator.registerLazySingleton(() => GetQuestions(locator()));
  locator.registerLazySingleton(() => PostValidateData(locator()));
  locator.registerLazySingleton(() => GetListProvinsi(locator()));
  locator.registerLazySingleton(() => GetListElasticProvinsitracer(locator()));
  locator.registerLazySingleton(() => GetListElasticKabupaten(locator()));
  locator.registerLazySingleton(() => GetListPtTracer(locator()));
  locator.registerLazySingleton(() => GetListProdiTracer(locator()));
  locator.registerLazySingleton(() => GetAllAnswersTracer(locator()));
  locator.registerLazySingleton(() => PostStoreAnswer(locator()));

  // Sister
  locator.registerLazySingleton(() => GetProfileDetailSister(locator()));
  locator.registerLazySingleton(() => GetPenempatanSister(locator()));
  locator.registerLazySingleton(() => GetBiodataSister(locator()));
  locator.registerLazySingleton(() => GetPraktisiSister(locator()));
  locator
      .registerLazySingleton(() => GetPendidikanFormalDosenSister(locator()));
  locator.registerLazySingleton(() => GetPendidikanDiklatSister(locator()));
  locator.registerLazySingleton(() => GetPendidikanPengajaranSister(locator()));
  locator.registerLazySingleton(() => GetPendidikanPengujianSister(locator()));
  locator
      .registerLazySingleton(() => GetPendidikanPembimbinganSister(locator()));
  locator.registerLazySingleton(() => GetPengabdianSister(locator()));
  locator.registerLazySingleton(() => GetPenelitianSister(locator()));
  locator.registerLazySingleton(() => GetBKDRekrutmenSister(locator()));

  // GMagz

  locator.registerLazySingleton(() => PutReaderGMagz(locator()));
  locator.registerLazySingleton(() => PutDownloaderGMAgz(locator()));
  locator.registerLazySingleton(() => GetMajalahGMagz(locator()));
  locator.registerLazySingleton(() => GetMajalahDetailGMagz(locator()));
}

void initBloc() {
  sintaBlocInjection();
  profilBlocInjection();
  locator.registerFactory(
    () => BerandaBloc(getNews: locator(), getPengunguman: locator()),
  );
  locator.registerFactory(
    () => FaqapiBloc(getFaq: locator()),
  );
  locator.registerFactory(
    () => FaqmoduleBloc(
      getFaqModule: locator(),
      internetCheck: locator(),
    ),
  );
  locator.registerFactory(
    () => BeritaBloc(
        getNews: locator(), internetCheck: locator(), log: locator()),
  );
  locator.registerFactory(
    () => PengumumanUmumBloc(
        getPengungumanWithCategory: locator(),
        log: locator(),
        internetCheck: locator()),
  );
  locator.registerFactory(
    () => PengumumanSumberDayaBloc(
        getPengungumanWithCategory: locator(),
        log: locator(),
        internetCheck: locator()),
  );
  locator.registerFactory(
    () => PengumumanKelembagaanBloc(
        getPengungumanWithCategory: locator(),
        log: locator(),
        internetCheck: locator()),
  );
  locator.registerFactory(
    () => PengumumanPembelajaranBloc(
        getPengungumanWithCategory: locator(),
        log: locator(),
        internetCheck: locator()),
  );
  locator.registerFactory(
    () => SivilBloc(
      log: locator(),
    ),
  );
  locator.registerFactory(
    () => StatuspengajuanBloc(
      getByEmail: locator(),
    ),
  );
  locator.registerFactory(
    () => IjazahbynoBloc(
      getByNoReg: locator(),
    ),
  );
  locator.registerFactory(
    () => VerifikasiskBloc(getPostVerif: locator(), internetCheck: locator()),
  );
  locator.registerFactory(
    () => NegaraBloc(
      getNegara: locator(),
      getPT: locator(),
    ),
  );
  locator.registerFactory(
    () => SearchpageBloc(
      getFaqSearch: locator(),
      getNewsSearch: locator(),
      getPengumumanSearch: locator(),
      getModul: locator(),
    ),
  );

  locator.registerFactory(
    () => PencarianSpesifikBloc(
      getListElasticPTAPIUseCase: locator(),
      getListElasticProvinsiUseCase: locator(),
      getListPTAPIUseCase: locator(),
      getListProdiAPIUseCase: locator(),
      getStatisticUseCase: locator(),
    ),
  );

  locator.registerFactory(() => PencarianSpesifikTracerBloc(
        getListElasticProvinsiUseCase: locator(),
      ));

  locator.registerFactory(
      () => PencarianBloc(getElasticSearchUseCase: locator(), log: locator()));

  locator.registerFactory(
    () => ResultSpesifikBloc(
      getPTAPIUseCase: locator(),
      getProdiAPIUseCase: locator(),
      getDetailMahasiswaAPIUseCase: locator(),
      getDetailDosenAPIUseCase: locator(),
    ),
  );

  locator.registerFactory(
    () => BottomSheetFormBloc(),
  );

  locator.registerFactory(
    () => UsulanDosenBloc(
      log: locator(),
      internetCheck: locator(),
      getUsulanDosenUseCase: locator(),
    ),
  );

  locator.registerFactory(
    () => KampusmerdekaBloc(
      getMBKM: locator(),
      internetCheck: locator(),
    ),
  );

  locator.registerFactory(
    () => CeritaKampusMerdekaBloc(
      getCKM: locator(),
      internetCheck: locator(),
    ),
  );

  locator.registerFactory(
    () => DetailCeritaKMBloc(
      getDetailCKM: locator(),
      log: locator(),
      internetCheck: locator(),
    ),
  );

  locator.registerFactory(
    () => BeritaDanPengumumanBloc(
        getNewsDetail: locator(),
        getPengumumanDetail: locator(),
        internetCheck: locator(),
        log: locator()),
  );
  locator.registerFactory(
    () => SearchpagemoreresultsBloc(
      getPengumumanSearchMoreResults: locator(),
      getNewsSearchMoreResults: locator(),
      log: locator(),
      internetCheck: locator(),
    ),
  );
  locator.registerFactory(
    () => NotifikasiBloc(
      log: locator(),
    ),
  );
  locator.registerFactory(
    () => DetailPencarianMahasiswaBloc(
      getMahasiswaPageAPIRegUseCase: locator(),
      getMahasiswaPageAPIUseCase: locator(),
      getRiwayatKuliahMahasiswaUseCase: locator(),
      getRiwayatStudiMahasiswaUseCase: locator(),
    ),
  );

  locator.registerFactory(
    () => DetailPencarianDosenBloc(
      getDetailDosenAPIUseCase: locator(),
      getRiwayatPendidikanDosenAPIUseCase: locator(),
      getRiwayatMengajarDosenAPIUseCase: locator(),
    ),
  );

  locator.registerFactory(
    () => DetailPencarianPtBloc(
      internetCheck: locator(),
      log: locator(),
      getIDPTPDDIKTI: locator(),
      getAgregatPTAPIUseCase: locator(),
      getAkreditasiPTAPIUseCase: locator(),
      getDetailPTAPIUseCase: locator(),
      getPelaporanPTAPIUseCase: locator(),
    ),
  );

  locator.registerFactory(
    () => DetailPencarianProdiBloc(
      getAkreditasiProdiAPIUseCase: locator(),
      getListDosenProdiAPIUseCase: locator(),
      getDetailProdiAPIUseCase: locator(),
      getDetailProdiAPIRegUseCase: locator(),
      getRasioProdiAPIUseCase: locator(),
    ),
  );

  locator.registerFactory(() => HasilSivilBloc(getSivilUseCase: locator()));

  locator.registerFactory(() => KedairekaindustriBloc(
      getListIndustri: locator(), internetCheck: locator()));

  locator.registerFactory(() =>
      KedairekaptBloc(getListInsanPT: locator(), internetCheck: locator()));

  locator.registerFactory(() => BeritaPengumumanDetailBloc(log: locator()));

  locator.registerFactory(() => LainnyaBloc(log: locator()));

  locator.registerFactory(() => SearchBeasiswaBloc(
      searchListBeasiswa: locator(),
      internetCheck: locator(),
      searchListBeasiswaFilter: locator()));

  locator.registerFactory(() => ListBeasiswaBloc(
      getListBeasiswaSedangDibuka: locator(),
      getListBeasiswaSedangDitutup: locator(),
      getListBeasiswaAkanDibuka: locator(),
      internetCheck: locator()));

  locator.registerFactory(() => SelancarloggedinBloc(
      internetCheck: locator(),
      getProfileDetailSelancar: locator(),
      getUsulanList: locator(),
      getUsulanDetail: locator(),
      log: locator()));

  locator.registerFactory(() => DaftarRiwayatusulanBloc(
        internetCheck: locator(),
        getUsulanDetail: locator(),
        log: locator(),
      ));
  locator.registerFactory(() => SiagaBloc(log: locator()));
  locator.registerFactory(() => PtBloc(getSearchListPT: locator()));

  locator
      .registerFactory(() => PengajuanUsulanBloc(getSiagaUseCase: locator()));

  locator.registerFactory(() => BtsPtBloc(getSearchListPTUseCase: locator()));
  locator.registerFactory(
    () => BtsProdiBloc(getSearchListProdiUseCase: locator()),
  );

  locator.registerFactory(
    () => BtsProvinsiBloc(getListElasticProvinsiUseCase: locator()),
  );

  // kompetensi dosen

  locator.registerFactory(
    () => LoginKdBloc(internetCheck: locator()),
  );

  locator.registerFactory(
    () => ListTawaranProgramBloc(
        getListTawaranProgram: locator(), internetCheck: locator()),
  );

  locator.registerFactory(
    () => FileListBloc(
      getFileListUseCase: locator(),
      downloadUnduhanUseCase: locator(),
      internetCheck: locator(),
    ),
  );

  locator.registerFactory(
    () => PenilaianDosenBloc(
      getPenilaianDosenUseCase: locator(),
      getSertifikatUseCase: locator(),
      downloadSertifikatUseCase: locator(),
      internetCheck: locator(),
    ),
  );
  locator.registerFactory(
    () => ProgramTerdaftarBloc(
      getProgramTerdaftarUseCase: locator(),
      internetCheck: locator(),
    ),
  );

  locator.registerFactory(
    () => SertifikatBloc(
      getSertifikatUseCase: locator(),
    ),
  );

  locator.registerFactory(
    () => UnduhanBloc(
      getUnduhanUseCase: locator(),
    ),
  );

  locator.registerFactory(
    () => PdfviewerBloc(internetCheck: locator()),
  );

  // locator.registerFactory(
  //   () => SiagaBloc(),
  // );

  locator.registerFactory(
    () => BtsNegaraBlocBloc(getNegara: locator()),
  );

  locator.registerFactory(
    () => BtsPtIjazahBloc(getPT: locator()),
  );

  locator.registerFactory(() => TipePencarianCubit());

  locator.registerFactory(() => SelectedijazahCubit());

  locator.registerFactory(
    () => GarudaBloc(getListJournal: locator(), internetCheck: locator()),
  );

  locator.registerFactory(
    () =>
        GarudaPaperBloc(searchGarudaPaper: locator(), internetCheck: locator()),
  );

  locator.registerFactory(
    () => GarudaSearchingJournalBloc(
        searchGarudaJournal: locator(),
        searchGarudaJournalBySubject: locator(),
        internetCheck: locator()),
  );

  locator.registerFactory(
    () => StatistikGarudaBloc(
        listStatistikGaruda: locator(), internetCheck: locator()),
  );
  locator.registerFactory(() => GarudaUmumSearchBloc(
        internetCheck: locator(),
        searchGarudaJournal: locator(),
        searchGarudaPaper: locator(),
      ));
  locator.registerFactory(
    () => PerubahanDosenTendikBloc(
        getPerubahanDosenDanTendik: locator(), internetCheck: locator()),
  );

  locator.registerFactory(() => ListPaginationBeasiswaBloc(
      internetCheck: locator(),
      getListBeasiswaSedangDibuka: locator(),
      getListBeasiswaSedangDitutup: locator(),
      getListBeasiswaAkanDibuka: locator()));

  locator.registerFactory(() => DetailProdiPtlnBloc(
        internetCheck: locator(),
        getProdiPTLN: locator(),
      ));

  locator.registerFactory(
    () => KuesionerTracerBloc(
        getQuestions: locator(),
        postValidateData: locator(),
        getAllAnswersTracer: locator()),
  );

  locator.registerFactory(
      () => PostStoreAnswerTracerBloc(postStoreAnswer: locator()));

  locator.registerFactory(() => BottomSheetFormTracerBloc());

  locator.registerFactory(
    () => BtsTracerProvinsiBloc(getListProvinsiUseCase: locator()),
  );

  locator.registerFactory(
    () => BtsTracerKabupatenBloc(getListElasticKabupatenUseCase: locator()),
  );

  locator.registerFactory(() => StatistikTracerBloc(
      getHorizontalPieChart: locator(),
      getHorizontalTable: locator(),
      getVerticalPieChart: locator(),
      getVerticalTable: locator(),
      getPekerjaanDibawahEnamBulanPieChart: locator(),
      getPekerjaanTable: locator()));

  locator.registerFactory(() => TracerBloc(getConfig: locator()));

  locator.registerFactory(
      () => PencarianKabupatenTracerBloc(getListKabupatenUsecase: locator()));

  locator.registerFactory(
      () => PencarianPtTracerBloc(getListPtUsecase: locator()));

  locator.registerFactory(
      () => PencarianProdiTracerBloc(getListProdiUsecase: locator()));

  locator.registerFactory(() => SisterLoggedinBloc(
      internetCheck: locator(),
      getProfileDetailSister: locator(),
      log: locator()));

  locator.registerFactory(() => PenempatanSisterBloc(
      internetCheck: locator(),
      getPenempatanSister: locator(),
      log: locator()));
  locator.registerFactory(() => PendidikanSisterBloc(
      internetCheck: locator(),
      getPendidikanFormalDosenSister: locator(),
      getPendidikanDiklatSister: locator(),
      getPendidikanPengajaranSister: locator(),
      getPendidikanPembimbinganSister: locator(),
      getPendidikanPengujianSister: locator(),
      log: locator()));

  locator.registerFactory(() => PengabdianSisterBloc(
      internetCheck: locator(),
      getPengabdianSister: locator(),
      log: locator()));

  locator.registerFactory(() => PenelitianSisterBloc(
      internetCheck: locator(),
      getPenelitianSister: locator(),
      log: locator()));

  locator.registerFactory(() => BiodataSisterBloc(
      internetCheck: locator(), getBiodataSister: locator(), log: locator()));

  locator.registerFactory(() => PraktisiSisterBloc(
      internetCheck: locator(), getPraktisiSister: locator(), log: locator()));

  locator.registerFactory(() => BKDSisterBloc(
      internetCheck: locator(),
      getBKDRekrutmenSister: locator(),
      log: locator()));

  locator.registerFactory(() => MajalahGMagzBloc(
      internetCheck: locator(), getMajalahGMagz: locator(), log: locator()));

  locator.registerFactory(() => MajalahDetailGMagzBloc(
      internetCheck: locator(),
      getMajalahDetailGMagz: locator(),
      putDownloaderGMAgz: locator(),
      putReaderGMagz: locator(),
      log: locator()));
}
