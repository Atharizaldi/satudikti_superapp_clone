import 'package:app/common/internetCheck.dart';
import 'package:app/data/source/remote/model/pddikti/perubahan_dosen_tendik/model_perubahan_dosen_tendik.dart';
import 'package:app/domain/usecases/pddikti/perubahan_dosen_tendik/get_perubahan_dosen_tendik.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:logger/logger.dart';

part 'perubahan_dosen_tendik_event.dart';
part 'perubahan_dosen_tendik_state.dart';

class PerubahanDosenTendikBloc
    extends Bloc<PerubahanDosenTendikEvent, PerubahanDosenTendikState> {
  var logger = Logger();
  InternetCheck internetCheck;
  GetPerubahanDosenDanTendik getPerubahanDosenDanTendik;
  String nidn = '';
  PerubahanDosenTendikBloc(
      {required this.internetCheck, required this.getPerubahanDosenDanTendik})
      : super(PerubahanDosenTendikInitial()) {
    on<FetchPerubahanDosenTendikEvent>(getListPerubahanDataDosenDanTendik);
  }
  void getListPerubahanDataDosenDanTendik(FetchPerubahanDosenTendikEvent event,
      Emitter<PerubahanDosenTendikState> emit) async {
    bool hasInternet = await internetCheck.hasConnection();
    try {
      if (hasInternet) {
        print("MASUK KE BLOC");
        if (state is PerubahanDosenTendikLoaded) {
          nidn = event.nidn;
          PerubahanDosenTendikLoaded perubahanDosenTendikLoaded =
              state as PerubahanDosenTendikLoaded;
          if (perubahanDosenTendikLoaded.hasReached) {
            logger.i("TENDIK hasReachedMax");
          } else {
            int newPage = perubahanDosenTendikLoaded.page + 1;
            logger.i("TENDIK NEW PAGE: $newPage");
            final result =
                await getPerubahanDosenDanTendik.execute(event.nidn, newPage);

            await result.fold((left) async {
              print("return left");
            }, (right) async {
              List<ListPerubahanDosenTendikResponse> listSemua =
                  right.data!.listPerubahanDosenTendikResponse;
              List<ListPerubahanDosenTendikResponse> listDraft = [];
              List<ListPerubahanDosenTendikResponse> listDisetujui = [];
              List<ListPerubahanDosenTendikResponse> listDiusulkan = [];
              List<ListPerubahanDosenTendikResponse> listDitolak = [];
              List<ListPerubahanDosenTendikResponse> listDitangguhkan = [];
              for (var perubahanDosen in listSemua) {
                print("KESINSI");
                if (perubahanDosen.namaStatusUsulan!.trim() == "Draft") {
                  print("1INI KEDRAFT");

                  listDraft.add(perubahanDosen);
                } else if (perubahanDosen.namaStatusUsulan!.trim() ==
                    "Disetujui") {
                  listDisetujui.add(perubahanDosen);
                } else if (perubahanDosen.namaStatusUsulan!.trim() ==
                    "Diusulkan") {
                  listDiusulkan.add(perubahanDosen);
                } else if (perubahanDosen.namaStatusUsulan!.trim() ==
                    "Ditolak") {
                  listDitolak.add(perubahanDosen);
                } else if (perubahanDosen.namaStatusUsulan!.trim() ==
                    "Ditangguhkan") {
                  listDitangguhkan.add(perubahanDosen);
                }
              }
              bool hasReachedMax =
                  right.data!.listPerubahanDosenTendikResponse.isEmpty ||
                      right.data!.listPerubahanDosenTendikResponse.length < 5;

              emit(PerubahanDosenTendikLoaded(
                  listSemua: perubahanDosenTendikLoaded.listSemua + listSemua,
                  listDisetujui:
                      perubahanDosenTendikLoaded.listDisetujui + listDisetujui,
                  listDitangguhkan:
                      perubahanDosenTendikLoaded.listDitangguhkan +
                          listDitangguhkan,
                  listDitolak:
                      perubahanDosenTendikLoaded.listDitolak + listDitolak,
                  listDiusulkan:
                      perubahanDosenTendikLoaded.listDiusulkan + listDiusulkan,
                  listDraft: perubahanDosenTendikLoaded.listDraft + listDraft,
                  hasReached: hasReachedMax,
                  page: newPage));

              logger.i("TENDIK: $newPage hasReachedMax: $hasReachedMax");
              logger.i(
                  "PANJANG DATA: ${right.data!.listPerubahanDosenTendikResponse.length}");
            });
          }
        } else {
          emit(PerubahanDosenTendikLoading());
          final result =
              await getPerubahanDosenDanTendik.execute(event.nidn, 0);
          await result.fold((left) async {
            emit(PerubahanErrorState());
            print("return left");
          }, (right) async {
            List<ListPerubahanDosenTendikResponse> listSemua =
                right.data!.listPerubahanDosenTendikResponse;
            List<ListPerubahanDosenTendikResponse> listDraft = [];
            List<ListPerubahanDosenTendikResponse> listDisetujui = [];
            List<ListPerubahanDosenTendikResponse> listDiusulkan = [];
            List<ListPerubahanDosenTendikResponse> listDitolak = [];
            List<ListPerubahanDosenTendikResponse> listDitangguhkan = [];
            for (var perubahanDosen in listSemua) {
              if (perubahanDosen.namaStatusUsulan!.trim() == "Draft") {
                print("INI KEDRAFT");
                listDraft.add(perubahanDosen);
              } else if (perubahanDosen.namaStatusUsulan!.trim() ==
                  "Disetujui") {
                listDisetujui.add(perubahanDosen);
              } else if (perubahanDosen.namaStatusUsulan!.trim() ==
                  "Diusulkan") {
                listDiusulkan.add(perubahanDosen);
              } else if (perubahanDosen.namaStatusUsulan!.trim() == "Ditolak") {
                listDitolak.add(perubahanDosen);
              } else if (perubahanDosen.namaStatusUsulan!.trim() ==
                  "Ditangguhkan") {
                listDitangguhkan.add(perubahanDosen);
              }
            }
            bool hasReachedMax =
                right.data!.listPerubahanDosenTendikResponse.isEmpty ||
                    right.data!.listPerubahanDosenTendikResponse.length < 5;
            emit(PerubahanDosenTendikLoaded(
                listSemua: listSemua,
                listDisetujui: listDisetujui,
                listDitangguhkan: listDitangguhkan,
                listDitolak: listDitolak,
                listDiusulkan: listDiusulkan,
                listDraft: listDraft,
                hasReached: hasReachedMax,
                page: 0));
          });
        }
      } else {
        emit(PerubahanNoInternetState());
      }
    } catch (e) {
      print(e);
    }
  }
}
