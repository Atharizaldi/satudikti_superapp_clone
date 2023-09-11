part of 'affiliations_list_bloc.dart';

abstract class AffiliationsListEvent extends Equatable {
  const AffiliationsListEvent();
}

class GetAffiliationsListEvent extends AffiliationsListEvent {
  final String keyword;
  final bool top;

  GetAffiliationsListEvent({required this.keyword, required this.top});

  @override
  List<Object> get props => [keyword];
}
