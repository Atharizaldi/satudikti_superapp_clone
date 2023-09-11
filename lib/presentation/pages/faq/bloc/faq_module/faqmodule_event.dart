part of 'faqmodule_bloc.dart';

abstract class FaqmoduleEvent extends Equatable {
  const FaqmoduleEvent();

  @override
  List<Object> get props => [];
}

class FetchfaqModuleEvent extends FaqmoduleEvent {
  final String moduleCode;

  FetchfaqModuleEvent(this.moduleCode);

  @override
  List<Object> get props => [];
}
