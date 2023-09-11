part of 'faqapi_bloc.dart';

abstract class FaqapiState extends Equatable {
  const FaqapiState();

  @override
  List<Object> get props => [];
}

class FaqapiLoading extends FaqapiState {
  @override
  List<Object> get props => [];
}

class FaqapiNoInternet extends FaqapiState {
  @override
  List<Object> get props => [];
}

class FaqapiLoaded extends FaqapiState {
  final FAQList listFAQ;

  FaqapiLoaded({required this.listFAQ});
  @override
  List<Object> get props => [listFAQ];
}
