import 'package:app/common/internetCheck.dart';
import 'package:app/data/source/remote/model/faq/faqList.dart';
import 'package:app/domain/usecases/faq/getFaqModule.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'faqmodule_event.dart';
part 'faqmodule_state.dart';

class FaqmoduleBloc extends Bloc<FaqmoduleEvent, FaqmoduleState> {
  GetFaqModule getFaqModule;
  InternetCheck internetCheck;
  FaqmoduleBloc({
    required this.getFaqModule,
    required this.internetCheck,
  }) : super(FaqModuleInitial()) {
    on<FetchfaqModuleEvent>((event, emit) async {
      bool hasInternet = await internetCheck.hasConnection();
      if (hasInternet) {
        final result = await getFaqModule.execute(event.moduleCode);
        await result.fold(
          (failure) async {
            if (failure.message == 'error500') {
              emit(FaqModuleErrorState(moduleCode: event.moduleCode));
            } else {
              emit(FaqModuleNoInternetState(moduleCode: event.moduleCode));
            }
          },
          (listFAQLayanan) async {
            if (state is FaqModuleNoInternetState ||
                state is FaqModuleErrorState) {
              emit(FaqModuleInitial());
              add(FetchfaqModuleEvent(event.moduleCode));
            } else {
              emit(FaqModuleLoadedState(
                listFAQLayanan: listFAQLayanan,
                moduleCode: event.moduleCode,
              ));
            }
          },
        );
      } else {
        emit(FaqModuleNoInternetState(moduleCode: event.moduleCode));
      }
    });
  }
}
