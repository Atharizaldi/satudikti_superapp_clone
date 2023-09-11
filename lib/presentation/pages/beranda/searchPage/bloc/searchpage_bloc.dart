import 'package:app/common/internetCheck.dart';
import 'package:app/data/source/remote/model/berita/newsList.dart';
import 'package:app/data/source/remote/model/faq/faqList.dart';
import 'package:app/data/source/remote/model/modul.dart';
import 'package:app/data/source/remote/model/pengumuman/pengumumanList.dart';
import 'package:app/domain/usecases/berita/getNewsSearch.dart';
import 'package:app/domain/usecases/faq/getFaqSearch.dart';
import 'package:app/domain/usecases/modul/getModul.dart';
import 'package:app/domain/usecases/pengumuman/getPengumumanSearch.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'searchpage_event.dart';
part 'searchpage_state.dart';

class SearchpageBloc extends Bloc<SearchpageEvent, SearchpageState> {
  GetFaqSearch getFaqSearch;
  GetNewsSearch getNewsSearch;
  GetPengumumanSearch getPengumumanSearch;
  GetModul getModul;
  SearchpageBloc({
    required this.getFaqSearch,
    required this.getNewsSearch,
    required this.getPengumumanSearch,
    required this.getModul,
  }) : super(SearchpageInitialState()) {
    on<GetFAQSearchEvent>(_getFAQSearch);
    on<GetNewsSearchEvent>(_getNewsSearch);
    on<GetPengumumanSearchEvent>(_getPengumumanSearch);
    on<GetBerandaSearchEvent>(_getBerandaSearchEvent);
  }

  void _getFAQSearch(
      GetFAQSearchEvent event, Emitter<SearchpageState> emit) async {
    bool check = await InternetCheck().hasConnection();

    if (check) {
      final result = await getFaqSearch.execute(event.keyword);

      await result.fold(
        (failure) async {
          emit(SearchpageNotFoundState());
        },
        (faqSearchList) async {
          emit(
            SearchpageFAQLoadedState(listFAQ: faqSearchList),
          );
        },
      );
    } else {
      emit(SearchpageNoInternetState());
    }
  }

  void _getNewsSearch(
      GetNewsSearchEvent event, Emitter<SearchpageState> emit) async {
    bool check = await InternetCheck().hasConnection();

    if (check) {
      final result = await getNewsSearch.execute(event.keyword);

      await result.fold(
        (failure) async {
          emit(SearchpageNotFoundState());
        },
        (newsList) async {
          emit(SearchpageBeritaLoadedState(newsList: newsList));
        },
      );
    } else {
      emit(SearchpageNoInternetState());
    }
  }

  void _getPengumumanSearch(
      GetPengumumanSearchEvent event, Emitter<SearchpageState> emit) async {
    bool check = await InternetCheck().hasConnection();

    if (check) {
      final result = await getPengumumanSearch.execute(event.keyword);

      await result.fold(
        (failure) async {
          emit(SearchpageNotFoundState());
        },
        (pengumumanList) async {
          emit(
            SearchpagePengumumanLoadedState(
              pengumumanList: pengumumanList,
              flagPengumuman: pengumumanList.data.length == 0 ? false : true,
            ),
          );
        },
      );
    } else {
      emit(SearchpageNoInternetState());
    }
  }

  void _getBerandaSearchEvent(
      GetBerandaSearchEvent event, Emitter<SearchpageState> emit) async {
    var listModul;
    print("_getBerandaSearchEvent");
    NewsList? listNews = NewsList(
      currentPage: 0,
      data: [],
      lastPage: 0,
      totalItem: 0,
      totalItemPerPage: 0,
    );
    PengumumanList? listPengumuman = PengumumanList(
      currentPage: 0,
      data: [],
      lastPage: 0,
      totalItem: 0,
      totalItemPerPage: 0,
    );
    bool check = await InternetCheck().hasConnection();
    print("CCHECKK $check");
    try {
      if (check) {
        final resultPengumuman =
            await getPengumumanSearch.execute(event.keyword);
        final resultNews = await getNewsSearch.execute(event.keyword);
        final resultModul = await getModul.execute(event.keyword);

        bool flagLayanan = false;
        bool flagBerita = false;
        bool flagPengumuman = false;

        await resultModul.fold(
          (failure) async {
            listModul = null;
            emit(SearchpageNotFoundState());
          },
          (modulList) async {
            listModul = modulList;
            flagLayanan = modulList.data.modul.isNotEmpty ? true : false;
          },
        );

        await resultNews.fold(
          (failure) async {
            listNews = null;
            emit(SearchpageNotFoundState());
          },
          (newsList) async {
            listNews = newsList;
            flagBerita = newsList.data.isNotEmpty ? true : false;
          },
        );

        await resultPengumuman.fold(
          (failure) async {
            listPengumuman = null;
            emit(SearchpageNotFoundState());
          },
          (pengumumanList) async {
            listPengumuman = pengumumanList;
            flagPengumuman = pengumumanList.data.isNotEmpty ? true : false;
          },
        );
        print("searchpagebloc: SearchpageBerandaLoadedState $listModul");

        if (listModul != null || listNews != null || listPengumuman != null)
          emit(
            SearchpageBerandaLoadedState(
              pengumumanList: listPengumuman,
              newsList: listNews,
              listModul: listModul,
              flagBerita: flagBerita,
              flagPengumuman: flagPengumuman,
              flagLayanan: flagLayanan,
            ),
          );
        else
          emit(SearchpageNotFoundState());
      } else {
        emit(SearchpageNoInternetState());
      }
    } catch (e, stackTrace) {
      print(" on Exception $e");
      print(" on stackTrace $stackTrace");
      emit(SearchpageNotFoundState());
    }
  }
}
