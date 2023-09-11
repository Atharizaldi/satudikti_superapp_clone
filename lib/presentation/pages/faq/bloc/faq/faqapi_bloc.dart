import 'package:app/data/source/remote/model/faq/faqList.dart';
import 'package:app/domain/usecases/faq/getFaq.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'faqapi_event.dart';
part 'faqapi_state.dart';

class FaqapiBloc extends Bloc<FaqapiEvent, FaqapiState> {
  GetFaq getFaq;

  FaqapiBloc({required this.getFaq}) : super(FaqapiLoading()) {
    on<FetchFaqApi>(_getFaqApi);
  }

  void _getFaqApi(FetchFaqApi event, Emitter<FaqapiState> emit) async {
    // await InternetCheck(timeout: 5).hasConnection();
    final result = await getFaq.execute();
    await result.fold(
      (failure) async {
        emit(FaqapiNoInternet());
      },
      (listFAQ) async {
        if (state is FaqapiLoading) {
          emit(FaqapiLoaded(listFAQ: listFAQ));
        } else {
          emit(FaqapiLoaded(listFAQ: listFAQ));
        }
      },
    );
  }
}
