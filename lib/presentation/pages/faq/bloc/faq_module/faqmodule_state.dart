part of 'faqmodule_bloc.dart';

abstract class FaqmoduleState extends Equatable {
  const FaqmoduleState();

  @override
  List<Object> get props => [];
}

class FaqModuleInitial extends FaqmoduleState {}

class FaqModuleLoadedState extends FaqmoduleState {
  final FAQList listFAQLayanan;
  final String moduleCode;

  FaqModuleLoadedState({
    required this.listFAQLayanan,
    required this.moduleCode,
  });
}

class FaqModuleErrorState extends FaqmoduleState {
  final String moduleCode;

  FaqModuleErrorState({required this.moduleCode});
}

class FaqModuleNoInternetState extends FaqmoduleState {
  final String moduleCode;

  FaqModuleNoInternetState({required this.moduleCode});
}
