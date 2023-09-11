part of 'faqapi_bloc.dart';

abstract class FaqapiEvent extends Equatable {
  const FaqapiEvent();

  @override
  List<Object> get props => [];
}

class FetchFaqApiNoInternet extends FaqapiEvent {
  @override
  List<Object> get props => [];
}

class FetchFaqApi extends FaqapiEvent {
  @override
  List<Object> get props => [];
}
