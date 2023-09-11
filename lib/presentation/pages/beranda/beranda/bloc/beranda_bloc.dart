import 'package:app/common/internetCheck.dart';
import 'package:app/data/source/local/model/menuItems.dart';
import 'package:app/data/source/remote/model/berita/newsList.dart';
import 'package:app/data/source/remote/model/pengumuman/pengumumanList.dart';
import 'package:app/domain/usecases/berita/getNews.dart';
import 'package:app/domain/usecases/pengumuman/getPengumuman.dart';
import 'package:app/presentation/component/menuItemsList.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'beranda_state.dart';

part 'beranda_event.dart';

class BerandaBloc extends Bloc<BerandaEvent, BerandaState> {
  GetNews getNews;
  GetPengunguman getPengunguman;

  Logger log = Logger();

  static Future<SharedPreferences> getPrefs() async {
    final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

    return await _prefs;
  }

  BerandaBloc({required this.getNews, required this.getPengunguman})
      : super(BerandaLoadingState()) {
    on<GetRecentBeritaEvent>(_getRecentBerita);
    on<GetPopularBeritaEvent>(_getPopularBerita);
    on<GetPengungumanEvent>(_getPengunguman);
    on<GetLayananFavoritEvent>(_getLayananFavorit);
  }

  void _getRecentBerita(
      GetRecentBeritaEvent event, Emitter<BerandaState> emit) async {
    bool hasInternet = await InternetCheck().hasConnection();
    if (hasInternet) {
      final result = await getNews.execute('1', '1', '12');

      await result.fold(
        (failure) async {
          emit(BerandaErrorState());
        },
        (recentBeritaList) async {
          if (state is BerandaLoadedState) {
            BerandaLoadedState beritaLoadedState = state as BerandaLoadedState;
            emit(BerandaLoadedState(
                recentBeritaList: recentBeritaList,
                popularBeritaList: beritaLoadedState.popularBeritaList,
                pengumumanList: beritaLoadedState.pengumumanList,
                listMenuFavorit: beritaLoadedState.listMenuFavorit,
                listMenuLainnya: beritaLoadedState.listMenuLainnya));
          } else {
            emit(BerandaLoadedState(
                recentBeritaList: recentBeritaList,
                popularBeritaList: NewsList(
                  currentPage: 0,
                  data: [],
                  lastPage: 0,
                  totalItem: 0,
                  totalItemPerPage: 0,
                ),
                pengumumanList: PengumumanList(
                  currentPage: 0,
                  data: [],
                  lastPage: 0,
                  totalItem: 0,
                  totalItemPerPage: 0,
                ),
                listMenuFavorit: [],
                listMenuLainnya: []));
          }
        },
      );
    } else {
      emit(BerandaNoInternetState());
    }
  }

  void _getPopularBerita(
      GetPopularBeritaEvent event, Emitter<BerandaState> emit) async {
    bool hasInternet = await InternetCheck().hasConnection();
    if (hasInternet) {
      final result = await getNews.execute('3', '1', '12');

      await result.fold(
        (failure) async {
          emit(BerandaErrorState());
        },
        (popularBeritaList) async {
          if (state is BerandaLoadedState) {
            BerandaLoadedState beritaLoadedState = state as BerandaLoadedState;
            emit(BerandaLoadedState(
                recentBeritaList: beritaLoadedState.recentBeritaList,
                popularBeritaList: popularBeritaList,
                pengumumanList: beritaLoadedState.pengumumanList,
                listMenuFavorit: beritaLoadedState.listMenuFavorit,
                listMenuLainnya: beritaLoadedState.listMenuLainnya));
          } else {
            emit(BerandaLoadedState(
                recentBeritaList: NewsList(
                  currentPage: 0,
                  data: [],
                  lastPage: 0,
                  totalItem: 0,
                  totalItemPerPage: 0,
                ),
                popularBeritaList: popularBeritaList,
                pengumumanList: PengumumanList(
                  currentPage: 0,
                  data: [],
                  lastPage: 0,
                  totalItem: 0,
                  totalItemPerPage: 0,
                ),
                listMenuFavorit: [],
                listMenuLainnya: []));
          }
        },
      );
    } else {
      emit(BerandaNoInternetState());
    }
  }

  void _getPengunguman(
      GetPengungumanEvent event, Emitter<BerandaState> emit) async {
    bool hasInternet = await InternetCheck().hasConnection();
    if (hasInternet) {
      final result = await getPengunguman.execute('1', '12');

      await result.fold(
        (failure) async {
          emit(BerandaErrorState());
        },
        (pengumumanList) async {
          if (state is BerandaLoadedState) {
            BerandaLoadedState beritaLoadedState = state as BerandaLoadedState;
            emit(BerandaLoadedState(
                recentBeritaList: beritaLoadedState.recentBeritaList,
                popularBeritaList: beritaLoadedState.popularBeritaList,
                pengumumanList: pengumumanList,
                listMenuFavorit: beritaLoadedState.listMenuFavorit,
                listMenuLainnya: beritaLoadedState.listMenuLainnya));
          } else {
            emit(BerandaLoadedState(
                recentBeritaList: NewsList(
                  currentPage: 0,
                  data: [],
                  lastPage: 0,
                  totalItem: 0,
                  totalItemPerPage: 0,
                ),
                popularBeritaList: NewsList(
                  currentPage: 0,
                  data: [],
                  lastPage: 0,
                  totalItem: 0,
                  totalItemPerPage: 0,
                ),
                pengumumanList: pengumumanList,
                listMenuFavorit: [],
                listMenuLainnya: []));
          }
        },
      );
    } else {
      emit(BerandaNoInternetState());
    }
  }

  void _getLayananFavorit(
      GetLayananFavoritEvent event, Emitter<BerandaState> emit) async {
    final List<MenuItems> resultMenuFavorit = await getListMenuFavorit();
    final List<MenuItems> resultMenuLainnya = await getListMenuLainnya();

    if (state is BerandaLoadedState) {
      BerandaLoadedState beritaLoadedState = state as BerandaLoadedState;
      emit(BerandaLoadedState(
          recentBeritaList: beritaLoadedState.recentBeritaList,
          popularBeritaList: beritaLoadedState.popularBeritaList,
          pengumumanList: beritaLoadedState.pengumumanList,
          listMenuFavorit: resultMenuFavorit,
          listMenuLainnya: resultMenuLainnya));
    } else {
      emit(BerandaLoadedState(
        recentBeritaList: NewsList(
          currentPage: 0,
          data: [],
          lastPage: 0,
          totalItem: 0,
          totalItemPerPage: 0,
        ),
        popularBeritaList: NewsList(
          currentPage: 0,
          data: [],
          lastPage: 0,
          totalItem: 0,
          totalItemPerPage: 0,
        ),
        pengumumanList: PengumumanList(
          currentPage: 0,
          data: [],
          lastPage: 0,
          totalItem: 0,
          totalItemPerPage: 0,
        ),
        listMenuFavorit: resultMenuFavorit,
        listMenuLainnya: resultMenuLainnya,
      ));
    }
  }

  Future<List<MenuItems>> getListMenuFavorit() async {
    SharedPreferences prefs = await getPrefs();
    // prefs.clear();
    prefs.remove('listMenuFavorit');

    if (prefs.getString('listMenuFavorit') == null) {
      prefs.setString(
          'listMenuFavorit', MenuItems.encode(menuItemsListFavorit));
    }
    return MenuItems.decode(prefs.getString('listMenuFavorit')!);
  }

  Future<List<MenuItems>> getListMenuLainnya() async {
    SharedPreferences prefs = await getPrefs();
    prefs.remove('listMenuLainnya');

    if (prefs.getString('listMenuLainnya') == null) {
      prefs.setString(
          'listMenuLainnya', MenuItems.encode(menuItemsListLainnya));
    }

    return MenuItems.decode(prefs.getString('listMenuLainnya')!);
  }

  bool isNewsListEmpty(NewsList newsList) {
    return (newsList.currentPage == 0 &&
        newsList.data == [] &&
        newsList.lastPage == 0 &&
        newsList.totalItem == 0 &&
        newsList.totalItemPerPage == 0);
  }

  bool isPengumumanListEmpty(PengumumanList pengumumanList) {
    return (pengumumanList.currentPage == 0 &&
        pengumumanList.data == [] &&
        pengumumanList.lastPage == 0 &&
        pengumumanList.totalItem == 0 &&
        pengumumanList.totalItemPerPage == 0);
  }

  bool isMenuListEmpty(List<MenuItems> list) {
    return list.isEmpty;
  }
}
